/**
 * @File Name          : TD401001Test.cls
 * @Description        : 一括確認(長期)物件一覧のテスト
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 2020/3/13 14:50:18
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    2020/3/13   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
@isTest
private class TD401001Test {
    
//***************************************************** テストデータ作成用メソッド *****************************************************************

//テストに使用するレコードを作成する
@testSetup static void Setting(){
    //テスト用レコードを作成

    //標準オブジェクト自動採番
    StandardObjectNumberSerial__c stdObjSerialAccount = new StandardObjectNumberSerial__c(
        ObjectApi__c = 'Account'      //オブジェクトAPI名
        ,Serial__c   = 1              //連番
        ,FieldApi__c = 'ForeignIDAutoNumber__c'//項目名
        ,Format__c = 'AFN-{0000000}'  //表示形式
    );
    insert stdObjSerialAccount;

    //店舗レコード
	Shop__c shopRecord = new shop__c(Name = 'テスト店舗',
                                     PortalSitePostingDistrict__c = '名東区',
									 IsChintaiPanoramaContract__c = true,   // 2022.04.14 CHINTAI対応追加
                                     SystemUseStartDate__c = Date.newInstance(2000, 12, 1),
                                     SystemUseEndDate__c = Date.newInstance(2999, 12, 1));
    insert shopRecord;

    //取引先レコード
    Account accountRecord = new Account(Name = 'テスト元付業者',
                                        Phone = '01234567890');
    insert accountRecord;                                 

    //建物レコード
    Building__c buildingRecord = new Building__c(District__c = '名東区',
                                                 State__c = '愛知県',
                                                 City__c = '名古屋市名東区',
	                                             Name = 'テスト建物' );
    insert buildingRecord;

    //物件レコード
	Property__c propertyRecord = new Property__c(Building__c = buildingRecord.Id,
                                                 Name = '1',
                                                 WebPublishing__c = CommonConst.PROPERTY_WEBPUBLISHING_EXISTS,
                                                 BulkConfirmationDate__c = datetime.newInstance(2020, 3, 1),
                                                 LiveStatus__c = '空室',
                                                 FormerSupplier__c = accountRecord.Id,
                                                 IsBulkConfirmation__c = true);

    Property__c propertyRecord2 = new Property__c(Building__c = buildingRecord.Id,
                                                  Name = '2',
                                                  WebPublishing__c = CommonConst.PROPERTY_WEBPUBLISHING_EXISTS,
                                                  BulkConfirmationDate__c = datetime.newInstance(2020, 2, 1),
                                                  LiveStatus__c = '退去予定',
                                                  FormerSupplier__c = accountRecord.Id,
                                                  IsBulkConfirmation__c = true);

    List<Property__c> proList = new List<Property__c>{propertyRecord,propertyRecord2};
    insert proList;

    /*ポータルサイト掲載物件レコード ▼ 2022.05.18 CHINTAI対応：本番リリース時、テストエラー発生のためコメントアウト
	PortalSitePostingProperty__c portalRecord = new PortalSitePostingProperty__c(Shop__c = shopRecord.Id,
                                                                                 Property__c = propertyRecord.Id,
                                                                                 IsHomes__c = true,
																				 IsChintaiNet__c = true, // 2022.04.14 CHINTAI対応追加
                                                                                 IsChintaiPanoramaPosting__c = true // 2022.04.14 CHINTAI対応追加
																				 );   
               
    PortalSitePostingProperty__c portalRecord2 = new PortalSitePostingProperty__c(Shop__c = shopRecord.Id,
                                                                                  Property__c = propertyRecord2.Id,
                                                                                  IsSUUMO__c = true,
																				  IsChintaiNet__c = true, // 2022.04.14 CHINTAI対応追加
                                                                                  IsChintaiPanoramaPosting__c = true // 2022.04.14 CHINTAI対応追加
																				  ); 

    List<PortalSitePostingProperty__c> portalList = new List<PortalSitePostingProperty__c>{portalRecord,portalRecord2};
    insert portalList;
    ▲ 2022.05.18 CHINTAI対応 */

    // ▼ 2022.05.18 CHINTAI対応：本番リリース時、テストエラー発生のためupdate処理を追加
    List<PortalSitePostingProperty__c> portalList = [SELECT Id, IsSUUMO__c, IsChintaiNet__c, IsChintaiPanoramaPosting__c FROM PortalSitePostingProperty__c];
    for(PortalSitePostingProperty__c portal : portalList){
        portal.IsSUUMO__c = true;
        portal.IsChintaiNet__c = true;
        portal.IsChintaiPanoramaPosting__c  = true;
    }
    update portalList;
    // ▲ 2022.05.18 CHINTAI対応

    // ▼ 2022.06.20 パノラマ複数店舗対応
    List<PortalSitePostingProperty__c> portalList2 = [SELECT Id, IsSuumo__c, IsSuumoPanoramaPosting__c FROM PortalSitePostingProperty__c];
    for(PortalSitePostingProperty__c portal2 : portalList2){
        portal2.IsSuumo__c = true;
        portal2.IsSuumoPanoramaPosting__c  = true;
    }
    update portalList2;

    List<PortalSitePostingProperty__c> portalList3 = [SELECT Id, IsHomes__c, IsHomesPanoramaPosting__c FROM PortalSitePostingProperty__c];
    for(PortalSitePostingProperty__c portal3 : portalList3){
        portal3.IsHomes__c = true;
        portal3.IsHomesPanoramaPosting__c  = true;
    }
    update portalList3;
    // ▲ 2022.06.20 パノラマ複数店舗対応

    //物件写真レコード
    PropertyPhoto__c propertyPhotoRecord = new PropertyPhoto__c(Property__c = propertyRecord.Id,
                                                                PanoramaFileName1__c = 'テストパノラマ写真');
    insert propertyPhotoRecord;    
}

    //カスタム設定の作成
    static SystemConfig__c BulkConfirmationPropertyMaxCountCustomSettings(Decimal maxCount){
        SystemConfig__c settings = new SystemConfig__c();
        settings.BulkConfirmationPropertyMaxCount__c = maxCount;//検索上限
        insert settings;
    
        return settings;
    }

    //帳票出力
    @isTest 
    static void outputTest() {
        BulkConfirmationPropertyMaxCountCustomSettings(1000);//検索上限

        //テストデータ取得
        Shop__c s = [SELECT Id FROM Shop__c WHERE Name = 'テスト店舗'];

        //パラメータ設定
        PageReference pageRef = Page.TD401001View;
        pageRef.getParameters().put('targetShopsName',s.Id );
        Test.setCurrentPage(pageRef);

        //コントローラー作成
        TD401001Controller TD401001Controller = new TD401001Controller();

        //「エラーフラグ」がfalseに設定されている？
        system.assertEquals(TD401001Controller.isOpenError, false);
        //「出力内容」が設定されている？
        system.assertnotEquals(TD401001Controller.propertyAndPortalList.size(), 0);
		// ▼ 2022.04.14 CHINTAI対応追加 CHINTAI関連項目が正しく(全てTrueでデータ作成のため、true・〇)セットされているか確認。
        System.assertEquals(TD401001Controller.propertyAndPortalList[0].portalRecord.IsChintaiNet__c, true);
        System.assertEquals(TD401001Controller.propertyAndPortalList[0].isChintaiPanoramaCheck, '〇');
        // ▲ 2022.04.14 CHINTAI対応追加
        // ▼ 2022.06.20 No.826 パノラマ複数店舗対応
        System.assertEquals(TD401001Controller.propertyAndPortalList[0].portalRecord.IsSuumo__c, true);
        System.assertEquals(TD401001Controller.propertyAndPortalList[0].isSuumoPanoramaCheck, '〇');
        System.assertEquals(TD401001Controller.propertyAndPortalList[0].portalRecord.IsHomes__c, true);
        System.assertEquals(TD401001Controller.propertyAndPortalList[0].isHomesPanoramaCheck, '〇');
        // ▲ 2022.06.20 No.826 パノラマ複数店舗対応
    }



    //帳票出力エラー
    @isTest static void parameterErrorTest() {
        BulkConfirmationPropertyMaxCountCustomSettings(1000);//検索上限

        //パラメータ設定
        PageReference pageRef = Page.TD401001View;
        pageRef.getParameters().put('targetShopsName',null );//店舗Idがnullの場合エラー
        Test.setCurrentPage(pageRef);

        //コントローラー作成
        TD401001Controller TD401001Controller = new TD401001Controller();

        //「エラーフラグ」がTRUEに設定されている？
        system.assertEquals(TD401001Controller.isOpenError, true);

        //「エラーメッセージ」が正しく設定されている？
        system.assertEquals(ApexPages.getMessages()[0].getDetail(), CommonUtil.callMessageCreate(CommonConst.MSG_COM_E_SYSTEM_PARAMETER));
        system.debug('ApexPages.getMessages()[0].getDetail()' + ApexPages.getMessages()[0].getDetail());
    }
}