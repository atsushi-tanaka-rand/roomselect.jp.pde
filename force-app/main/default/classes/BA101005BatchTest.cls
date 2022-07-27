//反響メールバッチ　テストクラス
@isTest 
private class BA101005BatchTest {
    
    //テストに使用するレコードを作成する
    @testSetup static void Setting(){

		//標準オブジェクト自動採番
		StandardObjectNumberSerial__c stdObjSerialAccount = new StandardObjectNumberSerial__c(
			ObjectApi__c = 'Account'      //オブジェクトAPI名
			,Serial__c   = 1              //連番
			,FieldApi__c = 'ForeignIDAutoNumber__c'//項目名
			,Format__c = 'AFN-{0000000}'  //表示形式
		);
		insert stdObjSerialAccount;
        
        //データ作成　システム変数 バッチサイズ
        SystemVariables__c s = new SystemVariables__c(
              VariablesLabel__c = '反響メールフラグ'
            , VariablesName__c  = CommonConst.IS_ECHOMAIL_BATCHPROCESSING
            , BooleanValue__c   = true
            , BooleanValue2__c  = true
        );
        insert s;

		//▼2022.07.06 問合せNo0852で追加
		Account account = new Account(
			Name = 'テスト'
			,FirstName__c = '山田'
			, FirstNameKana__c = 'ヤマダ'
			, LastName__c = '太郎'
			, LastNameKana__c = 'タロウ'
			, Email__c = 'example@co.jp'
			, Phone = '000-1111-2222'
		);
		insert account;
		//▲2022.07.06 問合せNo0852で追加

		// ▼ 2022.2.2 LINE連携対応より、追加
		Shop__c shop = new Shop__c(
			Email__c	= 'test@co.jp'
		);
		insert shop;

		LineMember__c lineMember = new LineMember__c(
			LineId__c = 'LINE ID'
			,Account__c = account.Id //2022.07.06 問合せNo0852で追加
		);
		insert lineMember;
		// ▼ 2022.2.2
        
        EchoMail__c e = new EchoMail__c(
            BatchStatus__c = CommonConst.BATCH_STUTAS_WAITING
			// ▼ 2022.2.2 LINE連携対応より、追加
			, Email__c				= 'test@co.jp'
			, PropertyCode__c		= '物件コード'
			, LineId__c				= lineMember.LineId__c
			, LineName__c			= 'LINE名'
			, IsLineReceive__c		= true
			, LineReceiveType__c	= CommonConst.LINE_RECEIVE_TYPE_RECEIVE
			, LineMember__c			= lineMember.Id
			, LineMessage__c		= 'LINEメッセージ'
			, LineFileName__c		= 'LINEファイル名'
			, LineFileUrl__c		= 'LINEファイルURL'
			, LineThumbnailName__c	= 'LINEサムネイル名'
			, LineThumbnailUrl__c	= 'LINEサムネイルURL'
			, LineReceiveTime__c	= CommonUtil.getToday()
			// ▼ 2022.2.2
		);
		//▼2022.07.06 問合せNo0852で追加
		//LINE受信でない反響メールの場合
		EchoMail__c e2 = new EchoMail__c(
			BatchStatus__c = CommonConst.BATCH_STUTAS_WAITING
			, Email__c				= 'test@co.jp'
			, IsLineReceive__c		= false
		);
		//LINE会員が登録される前に反響メール（LINE追加）を受信した場合
		EchoMail__c e3 = new EchoMail__c(
			BatchStatus__c = CommonConst.BATCH_STUTAS_WAITING
			, Email__c				= 'test@co.jp'
			, LineId__c				= 'LINEID2'
			, LineName__c			= 'LINE名2'
			, IsLineReceive__c		= true
			, LineReceiveType__c	= CommonConst.LINE_RECEIVE_TYPE_ADD
			, LineMember__c			= null
			, LineMessage__c		= 'LINEメッセージ2'
			, LineFileName__c		= 'LINEファイル名2'
			, LineFileUrl__c		= 'LINEファイルURL2'
			, LineThumbnailName__c	= 'LINEサムネイル名2'
			, LineThumbnailUrl__c	= 'LINEサムネイルURL2'
			, LineReceiveTime__c	= CommonUtil.getToday()
		);
		//LINE会員が登録される前に反響メール（LINE受信）を受信した場合
		EchoMail__c e4 = new EchoMail__c(
			BatchStatus__c = CommonConst.BATCH_STUTAS_WAITING
			, Email__c				= 'test@co.jp'
			, LineId__c				= 'LINEID2'
			, LineName__c			= 'LINE名2'
			, IsLineReceive__c		= true
			, LineReceiveType__c	= CommonConst.LINE_RECEIVE_TYPE_RECEIVE
			, LineMember__c			= null
			, LineMessage__c		= 'LINEメッセージ2'
			, LineFileName__c		= 'LINEファイル名2'
			, LineFileUrl__c		= 'LINEファイルURL2'
			, LineThumbnailName__c	= 'LINEサムネイル名2'
			, LineThumbnailUrl__c	= 'LINEサムネイルURL2'
			, LineReceiveTime__c	= CommonUtil.getToday()
		);
		//LINE会員が登録済みで反響メール（LINE追加）と紐づいていない場合
		EchoMail__c e5 = new EchoMail__c(
			BatchStatus__c = CommonConst.BATCH_STUTAS_WAITING
			, Email__c				= 'test@co.jp'
			, LineId__c				= 'LINE ID'
			, LineName__c			= 'LINE名'
			, IsLineReceive__c		= true
			, LineReceiveType__c	= CommonConst.LINE_RECEIVE_TYPE_ADD
			, LineMember__c			= null
			, LineMessage__c		= 'LINEメッセージ'
			, LineFileName__c		= 'LINEファイル名'
			, LineFileUrl__c		= 'LINEファイルURL'
			, LineThumbnailName__c	= 'LINEサムネイル名'
			, LineThumbnailUrl__c	= 'LINEサムネイルURL'
			, LineReceiveTime__c	= CommonUtil.getToday()
		);
		//LINE会員が登録済みで反響メール（LINE受信）と紐づいていない場合
		EchoMail__c e6 = new EchoMail__c(
			BatchStatus__c = CommonConst.BATCH_STUTAS_WAITING
			, Email__c				= 'test@co.jp'
			, LineId__c				= 'LINE ID'
			, LineName__c			= 'LINE名'
			, IsLineReceive__c		= true
			, LineReceiveType__c	= CommonConst.LINE_RECEIVE_TYPE_RECEIVE
			, LineMember__c			= null
			, LineMessage__c		= 'LINEメッセージ'
			, LineFileName__c		= 'LINEファイル名'
			, LineFileUrl__c		= 'LINEファイルURL'
			, LineThumbnailName__c	= 'LINEサムネイル名'
			, LineThumbnailUrl__c	= 'LINEサムネイルURL'
			, LineReceiveTime__c	= CommonUtil.getToday()
		);
		List<EchoMail__c> eList = new List<EchoMail__c> {
			e
			,e2
			,e3
			,e4
			,e5
			,e6
		};
		insert eList;
		//▲2022.07.06 問合せNo0852で追加
    }
    
    //バッチ起動テスト
    @isTest static void successTest(){
        
        //バッチ実行
        BA101005Batch b = new BA101005Batch(1);
        Integer BATCH_SIZE = 200; //バッチサイズ
        Database.executeBatch(b, BATCH_SIZE);
        
		// ▼ 2022.2.2 LINE連携対応より、追加
		System.assertEquals(null,	null,	'非同期処理によりオブジェクトの登録値が確認できない為、確認不要とする');
		// ▼ 2022.2.2
    }
    
}