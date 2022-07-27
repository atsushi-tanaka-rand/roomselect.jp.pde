// 商圏・地区選択のテストクラス
@isTest
public class GH201005Test {

    @TestSetup static void setting(){

		//標準オブジェクト自動採番
		StandardObjectNumberSerial__c stdObjSerialAccount = new StandardObjectNumberSerial__c(
			ObjectApi__c = 'Account'      //オブジェクトAPI名
			,Serial__c   = 1              //連番
			,FieldApi__c = 'ForeignIDAutoNumber__c'//項目名
			,Format__c = 'AFN-{0000000}'  //表示形式
		);
		insert stdObjSerialAccount;   
		

        // ユーザ作成
        List<Profile> profiles = [SELECT Id FROM Profile WHERE Name IN ('Standard User', '一般ユーザ')];
        System.assert(profiles.size() > 0);
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs(thisUser){
            User testUser = new User(UserName = 'GH201005Test@horaguchi.com',
                                     Email = 'test@example.com',
                                     LastName = 'test',
                                     Alias = 'test',
                                     TimeZoneSidKey = 'Asia/Tokyo',
                                     LocaleSidKey = 'ja_JP',
                                     EmailEncodingKey = 'ISO-2022-JP',
                                     LanguageLocaleKey = 'ja',
                                     ProfileId = profiles.get(0).Id );
            insert testUser;
        }

        // 商圏をセット（;区切り） 
        SystemConfig__c sysconf = new SystemConfig__c(
            TradeArea__c = '愛知県;東京都'
        );
        insert sysconf;



        //国土地理協会住所レコードを作成
        JapanGeographicDataCenterAddress__c j1 = new JapanGeographicDataCenterAddress__c(
                                                        State__c = '東京都',
                                                        City__c = '新宿区'
                                                    );
        JapanGeographicDataCenterAddress__c j2 = new JapanGeographicDataCenterAddress__c(
                                                        State__c = '東京都',
                                                        City__c = '豊島区'
                                                    );
        JapanGeographicDataCenterAddress__c j3 = new JapanGeographicDataCenterAddress__c(
                                                        State__c = '東京都',
                                                        City__c = '中央区'
                                                    );
        JapanGeographicDataCenterAddress__c j4 = new JapanGeographicDataCenterAddress__c(
                                                        State__c = '愛知県',
                                                        City__c = '名古屋市千種区'
                                                    );
        // JapanGeographicDataCenterAddress__c j5 = new JapanGeographicDataCenterAddress__c(
        //                                                 State__c = '愛知県',
        //                                                 City__c = '名古屋市中央区'
        //                                             );
        JapanGeographicDataCenterAddress__c j6 = new JapanGeographicDataCenterAddress__c(
                                                        State__c = '愛知県',
                                                        City__c = '北名古屋市'
                                                    );
		// 2022.06.14 No0853 対応で重複内容追加	
        JapanGeographicDataCenterAddress__c j7 = new JapanGeographicDataCenterAddress__c(
                                                        State__c = '愛知県',
                                                        City__c = '北名古屋市重複内容'
                                                    );

        List<JapanGeographicDataCenterAddress__c> JRecord = new List<JapanGeographicDataCenterAddress__c>{
            j1,j2,j3,j4,j6,j7
        };
        insert JRecord;

		//▼ 2022.06.14 No0853 対応で追加
		// 取引先
        Account AccountRecord = new Account();//登録に使用する取引先を設定
        AccountRecord.Name = 'テスト太郎' ;//取引先名
        AccountRecord.NameKana__c = 'ﾃｽﾄﾀﾛｳ' ; //取引先名（カナ）
        AccountRecord.Phone = '025-200-1234' ;//電話番号
        AccountRecord.Email__c = 'aaa@hora'; // メール
		AccountRecord.DesiredArea__c = '北名古屋市 名古屋市中央区'; // 希望地域
        AccountRecord.RecordTypeId = CommonUtil.getRecordTypeId('Account', CommonConst.ACCOUNT_RECTYPE_CUSTOMER);//顧客;//レコードタイプID（顧客）
		insert AccountRecord;

		Account AccountRecord2 = new Account();
        AccountRecord2.Name = 'テストじろう' ;//取引先名
        AccountRecord2.NameKana__c = 'ﾃｽﾄｼﾞﾛｳ' ; //取引先名（カナ）
        AccountRecord2.Phone = '025-200-1234' ;//電話番号
        AccountRecord2.Email__c = 'bbb@hora'; // メール
		AccountRecord2.DesiredArea__c = ''; // 希望地域
        AccountRecord2.RecordTypeId = CommonUtil.getRecordTypeId('Account', CommonConst.ACCOUNT_RECTYPE_CUSTOMER);//顧客;//レコードタイプID（顧客）
		insert AccountRecord2;

		// 来店カード
		VisitCard__c visitCard = new VisitCard__c();//来店カード
		visitCard.Account__c  = AccountRecord.Id;//取引先Id
		visitCard.DesiredArea__c = '北名古屋市 名古屋市中央区'; // 希望地域
		insert visitCard;

		// 来店カード
		VisitCard__c visitCard2 = new VisitCard__c();//来店カード
		visitCard2.Account__c  = AccountRecord2.Id;//取引先Id
		visitCard2.DesiredArea__c = ''; // 希望地域
		insert visitCard2;


        //対応作成
		Correspond__c correspond = new Correspond__c();//対応
        correspond.AccountId__c = AccountRecord.Id;//取引先
        correspond.Status__c = CommonConst.TASK_CORRESPONDTYPE_VISITED;//ステータス
        correspond.EventDateTime__c = CommonUtil.getNow();//イベント時刻
        correspond.IsSupportedListShow__c = FALSE;//対応確認
        correspond.ShopStaff__c	= UserInfo.getUserId();//担当者（来店）

        insert correspond;

        //対応作成
		Correspond__c correspond2 = new Correspond__c();//対応
        correspond2.AccountId__c = AccountRecord2.Id;//取引先
        correspond2.Status__c = CommonConst.TASK_CORRESPONDTYPE_VISITED;//ステータス
        correspond2.EventDateTime__c = CommonUtil.getNow();//イベント時刻
        correspond2.IsSupportedListShow__c = FALSE;//対応確認
        correspond2.ShopStaff__c	= UserInfo.getUserId();//担当者（来店）

        insert correspond2;
		//▲ 2022.06.14 No0853 対応で追加
    }

    /**
    来店カード新規作成時、商圏(都道府県)の初期表示はシステム設定で設定された商圏(都道府県)の
    最初の値を確認するケース
    */
    @isTest static void initializeTest1(){
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'GH201005Test@horaguchi.com'];
        system.runas(userRecord){

            //コントローラー、パラメータークラス
            GH201005Controller GH201005Controller = new GH201005Controller();
            GH201005ParameterClass GH201005Parameter = new GH201005ParameterClass();

            // ページ遷移時の設定
            GH201005Parameter.isDrawing = TRUE;
            GH201005Parameter.noFirst = TRUE;
        
            // 選択済み地区を設定
            GH201005Parameter.selectedDistrict = new list<String>();
    
            // コントローラの共通クラスを設定
            GH201005Controller.Parameter = GH201005Parameter;
            
            Test.startTest();
            GH201005Controller.getSelectOption();
            Test.stopTest();

            //商圏リストを取得
            String TRADEAREA_ALL = SystemConfig__c.getInstance().TradeArea__c;//　商圏のリスト（;区切り）
            String TRADEAREA_SEPARATOR = ';';//区切り文字
            List<String> tradeAreaList = TRADEAREA_ALL.split(TRADEAREA_SEPARATOR);

            //セットされた商圏が商圏リストの1番目の値であることを確認する。
            system.assertEquals(GH201005Controller.selectedTradeArea, tradeAreaList[0]);
        }
    }

    /**
    メソッドが問題なく呼び出されることを確認するケース
     */
    @isTest static void callTest(){
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'GH201005Test@horaguchi.com'];
        system.runas(userRecord){

            //コントローラー、パラメータークラス
            GH201005Controller GH201005Controller = new GH201005Controller();
            GH201005ParameterClass GH201005Parameter = new GH201005ParameterClass();
            
            // ページ遷移時の設定
            GH201005Parameter.isDrawing = TRUE;
            GH201005Parameter.noFirst = TRUE;

            // コントローラの共通クラスを設定
            
            GH201005Controller.Parameter = GH201005Parameter;

            // 選択済み地区を設定
            GH201005Parameter.selectedDistrict = new list<String>();
            GH201005Parameter.selectedDistrict.add('千種区');

    
            Test.startTest();
            try{
                GH201005Controller.getSelectOption();
                GH201005Controller.changeTradeArea();
                GH201005Controller.settingSelect();
            }catch(BusinessLogicException e){
                System.assert(false); // 例外が発生したら失敗
            }
            Test.stopTest();
        }
    }

	//▼ 2022.06.14 No0853 対応で追加
	/**
	* 新規来店ボタン押下（地区の一覧）
	*     初期表示
	*     類似地区があっても同名地区が複数件取得されないこと
	*/
    @isTest static void createNewVisit1(){
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'GH201005Test@horaguchi.com'];
        system.runas(userRecord){
			// 国土地理協会住所取得
			List<JapanGeographicDataCenterAddress__c> beforeJapanAddressList = [
				SELECT ID 
				FROM JapanGeographicDataCenterAddress__c
				WHERE State__c = '愛知県'
			];
    
            Test.startTest();
            //コントローラー、パラメータークラス
            GH201005ParameterClass GH201005Parameter = new GH201005ParameterClass();
			GH201005Parameter.selectedTradeArea = '愛知県';

			// コントローラの共通クラスを設定
			GH201005Controller GH201005Controller = new GH201005Controller();
			GH201005Controller.Parameter = GH201005Parameter;
			GH201005Controller.getSelectOption();

			// 類似地区は除かれている。
			system.assertEquals(GH201005Controller.displayDistrictList.size(), 2,'地区の件数');
			List<String> stateDistrictNameList = new List<String>();
			for (GH201005Controller.displayDistrict displayDistrict : GH201005Controller.displayDistrictList) {
				String statedDistrictName = displayDistrict.state+displayDistrict.districtName;
				if(stateDistrictNameList.contains(statedDistrictName)){
					// 一致があればエラー
					system.assertEquals(statedDistrictName,'a','同都道府県の同地区有='+statedDistrictName);
				}else {
					stateDistrictNameList.add(statedDistrictName);
				}
				
			}

            Test.stopTest();
        }
    }

	/**
	* 新規来店ボタン押下（地区の一覧）
	*     初期表示
	*     地区選択後、商圏・地区選択モーダルを開く
	*     選択した地区にチェックがあり、類似地区があっても同名地区が複数件取得されないこと
	*/
    @isTest static void createNewVisit2(){
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'GH201005Test@horaguchi.com'];
        system.runas(userRecord){
			
			// 国土地理協会住所取得
			List<JapanGeographicDataCenterAddress__c> beforeJapanAddressList = [
				SELECT ID 
				FROM JapanGeographicDataCenterAddress__c
				WHERE State__c = '愛知県'
			];	
            Test.startTest();
			// 来店カード
			GA202001Controller GA202001Controller = new GA202001Controller();
			GA202001Controller.openDistrictModal();
			GA202001Controller.GH201005Parameter.selectedTradeArea = '愛知県';

			// コントローラの共通クラスを設定
			GH201005Controller GH201005Controller = new GH201005Controller();
			GH201005Controller.Parameter = GA202001Controller.GH201005Parameter;
			GH201005Controller.getSelectOption();

			// 類似地区は除かれている。
			system.assertEquals(GH201005Controller.displayDistrictList.size(), 2,'地区の件数');
			List<String> stateDistrictNameList = new List<String>();
			for (GH201005Controller.displayDistrict displayDistrict : GH201005Controller.displayDistrictList) {
				displayDistrict.isSelected = true; 
			}
			// 選択済み対象の設定
			GH201005Controller.settingSelect();
			GA202001Controller.closeModal();

			// 再度開く
			GA202001Controller.openDistrictModal();

			for (GH201005Controller.displayDistrict displayDistrict : GH201005Controller.displayDistrictList) {
				String statedDistrictName = displayDistrict.state+displayDistrict.districtName;
				system.assertEquals(displayDistrict.isSelected,true,'選択した地区にチェック='+statedDistrictName);
				if(stateDistrictNameList.contains(statedDistrictName)){
					// 一致があればエラー
					system.assertEquals(statedDistrictName,'a','同都道府県の同地区有='+statedDistrictName);
				}else {
					stateDistrictNameList.add(statedDistrictName);
				}
			}

            Test.stopTest();
        }
    }

	/**
	* お客様情報詳細から来店押下（地区の一覧）
	*     初期表示
	*     類似地区があっても同名地区が複数件取得されないこと
	*/
    @isTest static void openVisitCardDesiredAreaList1(){
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'GH201005Test@horaguchi.com'];
        system.runas(userRecord){
			// 取引先＋来店カード
			Account AccountRecord = [
				SELECT ID
				,(SELECT ID FROM VisitsCardAccount__r ORDER BY SystemModstamp DESC LIMIT 1)
				FROM ACCOUNT WHERE NAME = 'テストじろう'
			];
			// 対応
			Correspond__c correspond = [SELECT ID FROM Correspond__c WHERE AccountId__c = :AccountRecord.Id];

			// 国土地理協会住所取得
			List<JapanGeographicDataCenterAddress__c> beforeJapanAddressList = [
				SELECT ID 
				FROM JapanGeographicDataCenterAddress__c
				WHERE State__c = '愛知県'
			];
            //パラメータ設定
			PageReference pageRef = Page.GA202001View;
			pageRef.getParameters().put('acc',AccountRecord.Id );
			pageRef.getParameters().put('Corresponds',correspond.Id );
			Test.setCurrentPage(pageRef);
	
            Test.startTest();

			// 来店カードのモーダルオープンまで
			GA202001Controller GA202001Controller = new GA202001Controller();
			GA202001Controller.openDistrictModal();
            
            // ページ遷移時の設定
			GA202001Controller.GH201005Parameter.selectedTradeArea = '愛知県';

			// コントローラの共通クラスを設定
			GH201005Controller GH201005Controller = new GH201005Controller();
			GH201005Controller.Parameter = GA202001Controller.GH201005Parameter;
			GH201005Controller.getSelectOption();

			// 類似地区は除かれている。
			system.assertEquals(GH201005Controller.displayDistrictList.size(), 2,'地区の件数');
			List<String> stateDistrictNameList = new List<String>();
			for (GH201005Controller.displayDistrict displayDistrict : GH201005Controller.displayDistrictList) {
				system.assertEquals(displayDistrict.isSelected,false,'初期チェック='+displayDistrict);
				displayDistrict.isSelected = true; // チェックを全てに付ける。
			}
			// 選択済み対象の設定
			GH201005Controller.settingSelect();
			GA202001Controller.closeModal();

			// 再度開く
			GA202001Controller.openDistrictModal();
			GH201005Controller = new GH201005Controller();
			GH201005Controller.Parameter = GA202001Controller.GH201005Parameter;
			GH201005Controller.getSelectOption();
			GH201005Controller.settingSelect();

			for (GH201005Controller.displayDistrict displayDistrict : GH201005Controller.displayDistrictList) {
				String statedDistrictName = displayDistrict.state+displayDistrict.districtName;
				system.assertEquals(displayDistrict.isSelected,true,'選択した地区にチェック='+statedDistrictName);
				if(stateDistrictNameList.contains(statedDistrictName)){
					// 一致があればエラー
					system.assertEquals(statedDistrictName,'a','同都道府県の同地区有='+statedDistrictName);
				}else {
					stateDistrictNameList.add(statedDistrictName);
				}
			}

            Test.stopTest();
        }
    }

	/**
	* お客様情報詳細から来店押下（地区の一覧）
	*     初期表示（データ有）
	*     選択した地区にチェックがあり、
	*     類似地区があっても同名地区が複数件取得されないこ
	*/
    @isTest static void openVisitCardDesiredAreaList2(){
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'GH201005Test@horaguchi.com'];
        system.runas(userRecord){
			// 取引先＋来店カード
			Account AccountRecord = [
				SELECT ID
				,(SELECT ID FROM VisitsCardAccount__r ORDER BY SystemModstamp DESC LIMIT 1)
				FROM ACCOUNT WHERE NAME = 'テスト太郎'
			];
			// 対応
			Correspond__c correspond = [SELECT ID FROM Correspond__c WHERE AccountId__c = :AccountRecord.Id];

			// 国土地理協会住所取得
			List<JapanGeographicDataCenterAddress__c> beforeJapanAddressList = [
				SELECT ID FROM JapanGeographicDataCenterAddress__c WHERE State__c = '愛知県'
			];
            //パラメータ設定
			PageReference pageRef = Page.GA202001View;
			pageRef.getParameters().put('acc',AccountRecord.Id );
			pageRef.getParameters().put('Corresponds',correspond.Id );
			Test.setCurrentPage(pageRef);
	
            Test.startTest();
			// 来店カードのモーダルオープンまで
			GA202001Controller GA202001Controller = new GA202001Controller();
			GA202001Controller.openDistrictModal();
            
            // ページ遷移時の設定
			GA202001Controller.GH201005Parameter.selectedTradeArea = '愛知県';

			// コントローラの共通クラスを設定
			GH201005Controller GH201005Controller = new GH201005Controller();
			GH201005Controller.Parameter = GA202001Controller.GH201005Parameter;
			GH201005Controller.getSelectOption();


			// 類似地区は除かれている。
			system.assertEquals(GH201005Controller.displayDistrictList.size(), 2,'地区の件数');

			List<String> stateDistrictNameList = new List<String>();
			for (GH201005Controller.displayDistrict displayDistrict : GH201005Controller.displayDistrictList) {
				String statedDistrictName = displayDistrict.state+displayDistrict.districtName;
				if(displayDistrict.districtName =='北名古屋市' || displayDistrict.districtName == '名古屋市中央区'){
					system.assertEquals(displayDistrict.isSelected,true,'初期チェック='+displayDistrict);
				}else{
					system.assertEquals(displayDistrict.isSelected,false,'初期チェック='+displayDistrict);
				}

				if(stateDistrictNameList.contains(statedDistrictName)){
					// 一致があればエラー
					system.assertEquals(statedDistrictName,'a','同都道府県の同地区有='+statedDistrictName);
				}else {
					stateDistrictNameList.add(statedDistrictName);
				}
				
			}
            Test.stopTest();

        }
    }
	//▲ 2022.06.14 No0853 対応で追加
}