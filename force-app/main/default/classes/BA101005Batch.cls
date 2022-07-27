//反響メールバッチ
//※基本的にメールはトリガだが、同時に受信する可能性のある反響メールは、パラレルでトリガが起動すると、顧客や対応が複数作成されてしまう可能性がある。
//　これに対応するため、反響メールの場合のみ、バッチで直列で処理する。
global with sharing class BA101005Batch implements Database.Batchable<sObject>, Database.Stateful{
    
    //※Database.Statefulをimplementすることで、バッチは直列で起動される。並列は困る。（顧客や対応が同時に作成されるため）
    public Integer JOB_CHAIN_COUNT; //何回目の連鎖起動か
    
    //コンストラクタ
    global BA101005Batch(Integer jobChainCount){
        JOB_CHAIN_COUNT = jobChainCount;
    }
    
    //データ取得
    global Database.QueryLocator start(Database.BatchableContext BC){
        final String PROCESS_WAITING = CommonConst.BATCH_STUTAS_WAITING;
        return Database.getQueryLocator( createSoql(PROCESS_WAITING) );
    }
    
    //ジョブ本体
	global void execute(Database.BatchableContext BC, List<EchoMail__c> echoMailList){ //2022.07.06 問合せNo0852で変更（targetList⇒echoMailList）

		//▼2022.07.06 問合せNo0852で追加
		//バッチ処理対象の反響メール
		List<EchoMail__c> targetList = new List<EchoMail__c>();
		//▲2022.07.06 問合せNo0852で追加
		
		try{
			//▼2022.07.06 問合せNo0852で追加
			//反響メールのLINE@IDリスト
			List<String> lineIdList = new List<String>();
			//反響メールのIDリスト
			List<Id> echoMailIdList = new List<Id>();
			//LINE@IDリストとIDリストを作成
			for (EchoMail__c echoMail : echoMailList) {
				lineIdList.add(echoMail.LineId__c);
				echoMailIdList.add(echoMail.Id);
			}

			//反響メールに紐づいているLINE会員を取得
			List<LineMember__c> lineMemberList = selectLineMemberList(lineIdList);

			//反響メール更新対象リスト
			List<EchoMail__c> updateEchoMailList = new List<EchoMail__c>();
			
			//更新対象を抽出する
			for (EchoMail__c echoMail : echoMailList) {
				//LINE受信でない反響メールは更新対象外
				if (!echoMail.IsLineReceive__c) {
					continue;
				}

				for (LineMember__c lineMember : lineMemberList) {
					//LINE会員と紐づいていない反響メールは更新対象外
					if (echoMail.LineId__c != lineMember.LineId__c) {
						continue;
					}

					//反響メールのINE会員.IDが設定されていない場合は更新対象
					if (String.isEmpty(echoMail.LineMember__c)) {
						//LINE会員.IDの設定
						echoMail.LineMember__c = lineMember.Id;
						//取引先情報の設定
						if (String.isNotEmpty(lineMember.Account__c)) {
							echoMail.CustomerName__c = CommonUtil.changeNullToEmpty(lineMember.Account__r.LastName__c)
														+ '  ' + CommonUtil.changeNullToEmpty(lineMember.Account__r.FirstName__c);

							echoMail.CustomerNameKana__c = CommonUtil.changeNullToEmpty(lineMember.Account__r.LastNameKana__c)
														+ '  ' + CommonUtil.changeNullToEmpty(lineMember.Account__r.FirstNameKana__c);
							echoMail.FromEmail__c = lineMember.Account__r.Email__c;
							echoMail.Phone__c = lineMember.Account__r.Phone;
						}
						//更新対象リストに追加
						updateEchoMailList.add(echoMail);
					} 
				}
			}

			//反響メールを更新
			if (!updateEchoMailList.isEmpty()) {
				SecureDML.secureUpdate(updateEchoMailList);
			}

			//処理対象候補リスト
			List<EchoMail__c> targetCandidateList = new List<EchoMail__c>();

			//反響メールデータを再取得して、処理対象候補リストに追加
			final String PROCESS_WAITING = CommonConst.BATCH_STUTAS_WAITING;
			targetCandidateList = Database.query( createSoql(PROCESS_WAITING) );

			//処理対象候補から処理対象の反響メールを抽出する
			for (EchoMail__c echoMail : targetCandidateList) {
				if (echoMailIdList.contains(echoMail.Id)) {
					//LINE受信の反響メールの場合
					if(echoMail.IsLineReceive__c) {
						//LINE会員が紐づく場合は処理対象に追加
						if (String.isNotEmpty(echoMail.LineMember__c)) {
							targetList.add(echoMail);
						}
					}else{
						//LINE受信でない反響メールは処理対象に追加
						targetList.add(echoMail);
					}
				}
			}
			//▲2022.07.06 問合せNo0852で追加

            //対応紐づけ(トリガのメソッドを起動)
            BA101004TriggerHandler bth = new BA101004TriggerHandler(true, 200);
            bth.connectMailToCorrespond(targetList);
            
            //バッチステータス更新
            updateBatchStatus(BC, targetList);
            
            //テスト用エラー起動
            throwEForTest();

        } catch(Exception e) {
            // エラーステータス更新
            updateBatchStatusForError(targetList, e);
        }
    }
     
    //終了時処理
    global void finish(Database.BatchableContext bc) {

        //次の処理を起動
        callNextBatch();
        
    }
    
    //***************************************************** private ***********************************************************
    
    //●start用のSOQL文作成
    private String createSoql(final String PROCESS_WAITING){
        
        String soql = '';
        
        soql += 'SELECT';
        soql += ' Id';
        soql += ' , InquiryDateTime__c';  // お問い合わせ日時
        soql += ' , Email__c';            // 宛先
        soql += ' , FromEmail__c';        // 送信元
        soql += ' , FromPotalSite__c';    // ポータルサイト
        soql += ' , Subject__c';          // 件名
        soql += ' , Body__c';             // 本文
        soql += ' , CustomerName__c';     // 顧客名
        soql += ' , CustomerNameKana__c'; // 顧客名カナ
        soql += ' , Phone__c';            // 電話
        soql += ' , Fax__c';              // FAX
        soql += ' , Response__c';         // 反響物件
        soql += ' , IsSpecifiedMail__c';  // 指定メールフラグ
        soql += ' , PropertURL__c';       //物件URL
        soql += ' , PropertyName__c';     //物件名
        soql += ' , PropertyAddress__c';  // 所在地
        soql += ' , ClosestStation__c';   // 最寄駅
        soql += ' , WalkTime__c';         // 徒歩
        soql += ' , RoomLayout__c';       // 間取り
        soql += ' , RentFee__c';          // 賃料            
        //ポータルサイト構築 追加 Start
        soql += ' , PropertyList__c';     // 自社ポータル用_物件Idリスト
        soql += ' , MemberID__c';         // 自社ポータル用_会員Id
        soql += ' , VisitReservationDate__c';// 自社ポータル用_来店予約日
        soql += ' , MailType__c';         // 自社ポータル用_メール種別
        //ポータルサイト構築 追加 End
        // 問合せ323で追加
        soql += ' , InquiryContent__c';          // お問合せ内容
        //▼問合せNo0536で追加
        soql += ' , PostalCode__c ';        // 郵便番号
        soql += ' , Birthdate__c ';         // 生年月日
        soql += ' , DesiredArea__c ';       // 希望地域
        soql += ' , HomeMovingSeason__c ';  // 引越時期
        soql += ' , HomeMovingDate__c ';    // 引越時期（日付）までに
        soql += ' , TenantCount__c ';       // 入居人数
        soql += ' , State__c ';             // 都道府県
        soql += ' , City__c ';              // 住所１（市区町村）
        soql += ' , Street__c ';            // 住所２（番地）
        //▲問合せNo0536で追加
		// ▼ 2022.1.21 LINE連携対応より、追加
		soql += ' , PropertyCode__c ';		// 物件コード
		soql += ' , LineId__c ';			// LINE＠ID
		soql += ' , LineName__c ';			// LINEプロフィール名
		soql += ' , IsLineReceive__c ';		// LINE受信フラグ
		soql += ' , LineReceiveType__c ';	// LINE受信種別
		soql += ' , LineMember__c ';		// LINE会員
		soql += ' , LineMessage__c ';		// LINEメッセージ
		soql += ' , LineFileName__c ';		// LINEファイル名
		soql += ' , LineFileUrl__c ';		// LINEファイルURL
		soql += ' , LineThumbnailName__c ';	// LINEサムネイル名
		soql += ' , LineThumbnailUrl__c ';	// LINEサムネイルURL
		soql += ' , LineReceiveTime__c ';	// LINE受信時刻
        soql += ' , LineMember__r.Account__c ';// LINE＠IDに紐づく取引先 2022.04.04 No0745 対応で追加
		// ▲ 2022.1.21
        soql += ' FROM EchoMail__c'; //反響メールが対象
        soql += ' WHERE  BatchStatus__c = :PROCESS_WAITING';
        soql += ' ORDER BY InquiryDateTime__c';//2022.07.06 問合せNo0852で追加
        return soql;
    }
    
    //●バッチステータスの更新
    private void updateBatchStatus(Database.BatchableContext BC, List<EchoMail__c> targetList) {
        
        // 更新用レコード作成
        List<EchoMail__c> updateEchoMailList = new List<EchoMail__c>();
        for(EchoMail__c e: targetList) {
            EchoMail__c updateEchoMail = new EchoMail__c(
                  Id = e.Id
                , BatchStatus__c        = CommonConst.BATCH_STUTAS_COMPLETED // バッチステータス
                , BatchCompletedTime__c = System.now().time()                // バッチ処理完了時間（Time型だとミリ秒が入る）
                , BatchContent__c       = JOB_CHAIN_COUNT + '回目起動:' + BC.getJobId() + ' ' + BC.getChildJobId() //連鎖数:ジョブId ジョブ子Id（ジョブの詳細を記録）
            );
            updateEchoMailList.add(updateEchoMail);
        }
        
        // 更新
        if ( !updateEchoMailList.isEmpty() ) {
            SecureDML.secureUpdate(updateEchoMailList);
        }
    }
    
    //●テスト用Exception発生
    private void throwEForTest() {
        if (Test.isRunningTest()){
            throw new BusinessLogicException();
        }
    }
    
    //●ステータスの更新(エラーの出力)
    private void updateBatchStatusForError(List<EchoMail__c> targetList, Exception e) {

        
        //更新用変数の宣言
        List<EchoMail__c> updateList = new List<EchoMail__c>();
        
        //エラーメッセージの作成
        String errMsg = createErrMsg(e);
        
        //エラーリストに追加
        for (EchoMail__c target: targetList) {
            EchoMail__c updateData = new EchoMail__c(
                Id = target.Id
                , BatchStatus__c        = CommonConst.BATCH_STUTAS_COMPLETED // バッチステータスを完了に更新
                , BatchCompletedTime__c = System.now().time()                // バッチ処理完了時間（Time型だとミリ秒が入る）
                , BatchContent__c       = errMsg              // エラー内容
            );
            updateList.add(updateData);
        }
        //更新
        if (!updateList.isEmpty()) {
            SecureDML.secureUpdate(updateList);
        }
    }
    
    //●エラーメッセージの作成
    private String createErrMsg(Exception e) {
        String errMsg = CommonConst.STRING_EMPTY;
        errMsg += 'Exception type caught:' + e.getTypeName()         + CommonConst.BREAK_CODE;
        errMsg += 'Message:'               + e.getMessage()          + CommonConst.BREAK_CODE;
        errMsg += 'Cause:'                 + e.getCause()            + CommonConst.BREAK_CODE;
        errMsg += 'Line number:'           + e.getLineNumber()       + CommonConst.BREAK_CODE;
        errMsg += 'getStackTraceString:'   + e.getStackTraceString() + CommonConst.BREAK_CODE;
        return errMsg;
    }
    
    
    //●次のバッチを呼ぶ
    private void callNextBatch() {
        
        //次の処理があるか調べる
        List<SystemVariables__c> slist = [SELECT Id,BooleanValue2__c FROM SystemVariables__c WHERE VariablesName__c = :CommonConst.IS_ECHOMAIL_BATCHPROCESSING LIMIT 1 FOR UPDATE];
        if (slist.isEmpty()) {
            return;
        }
        
        //次の処理があるなら
        if (slist[0].BooleanValue2__c) {
            
            //値2(追加処理あり) を更新（追加処理なしにすることで、バッチをもう一回だけ起動する）
            SystemVariables__c updateSystemVariables = new SystemVariables__c(Id = slist[0].Id, BooleanValue2__c = false);
            SecureDML.secureUpdate(updateSystemVariables);

            //バッチ処理起動
            if (!Test.isRunningTest()) { //テストでは続けてバッチを起動できない
                BA101005Batch b = new BA101005Batch(JOB_CHAIN_COUNT + 1);
                Database.executeBatch(b,1);	// 2022.06.02 No0834 対応で変更：直列の実行をするため回数を１に
            }
            
        } else {
            //値1,2を更新(処理終了)
            SystemVariables__c updateSystemVariables = new SystemVariables__c(Id = slist[0].Id, BooleanValue__c = false, BooleanValue2__c = false);
            SecureDML.secureUpdate(updateSystemVariables);
        }
    }

	//▼2022.07.06 問合せNo0852で追加
	//●LINE会員の取得
	private static List<LineMember__c> selectLineMemberList(List<String> lineIdList) {

		List<LineMember__c> lineMemberList = [
			SELECT
				Id
				, Account__c
				, Account__r.FirstName__c
				, Account__r.FirstNameKana__c
				, Account__r.LastName__c
				, Account__r.LastNameKana__c
				, Account__r.Email__c
				, Account__r.Phone
				, LineId__c
			FROM LineMember__c
			WHERE LineId__c IN :lineIdList
		];

		if (lineMemberList.isEmpty()) {
			return new List<LineMember__c>();
		}

		return lineMemberList;
	}
	//▲2022.07.06 問合せNo0852で追加
}