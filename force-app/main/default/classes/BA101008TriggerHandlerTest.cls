//行動トリガテストクラス
@ isTest
private class BA101008TriggerHandlerTest {

    @TestSetup
    static void Setting(){
        //ユーザ作成
        List<Profile> profiles = [SELECT Id FROM Profile WHERE Name IN ('一般ユーザ')];
        System.assert(profiles.size() > 0);
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs(thisUser){
            insert new User(
                UserName = 'Test@horaguchi.com',
                Email = 'test@example.com',
                LastName = 'test',
                Alias = 'test',
                TimeZoneSidKey = 'Asia/Tokyo',
                LocaleSidKey = 'ja_JP',
                EmailEncodingKey = 'ISO-2022-JP',
                LanguageLocaleKey = 'ja',
                ProfileId = profiles.get(0).Id);
        }
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'Test@horaguchi.com'];
        //店舗レコード
        Shop__c shopRecord = new shop__c(Name = 'テスト店舗',
                PortalSitePostingDistrict__c = '港区;北区',
                Email__c = 'tempoEmail@rand.co.jp');
        insert shopRecord;

        // 組織階層レコード
        OrganizationHierarchy__c orgRecord1 = new OrganizationHierarchy__c(
            OrganizationCode__c = '0001',
            OrganizationName__c = '本部',
            HierarchyCode__c = '10',
            HierarchyOrder__c = 1,
            UpperOrganizationHierarchy__c = null,
            ExpandedOrganizationCode__c = '0000_0001',
            Shop__c = null
        );
        insert orgRecord1;
        OrganizationHierarchy__c orgRecord2 = new OrganizationHierarchy__c(
            OrganizationCode__c = '0002',
            OrganizationName__c = 'テスト店舗',
            HierarchyCode__c = '20',
            HierarchyOrder__c = 1,
            UpperOrganizationHierarchy__c = orgRecord1.Id,
            ExpandedOrganizationCode__c = '0000_0001_0002',
            Shop__c = shopRecord.Id
        );
        insert orgRecord2;

        // 店舗異動レコード
        ShopTransfer__c ShopTransferRecord = new ShopTransfer__c(OrgzanizationHierarchy__c = orgRecord2.id,
                                                                Staff__c = userRecord.id,
                                                                StartDate__c = Date.newInstance(2000, 12, 1),
                                                                EndDate__c = Date.newInstance(2999, 12, 1)); 
        insert ShopTransferRecord;

        //来店受付
         AppointmentReceiptStoreDate__c arsd = new AppointmentReceiptStoreDate__c(
             PeopleLimit__c = 2,
             TargetDate__c = CommonUtil.getToday(),
             Shop__c = shopRecord.Id,
             ProcessingFlg__c = true
         );
         insert arsd;    

        // 来店受付
         AppointmentReceipt__c appointmentReceipt = new AppointmentReceipt__c(
              OwnerId = userRecord.id
            , ReceiptDate__c = Date.newInstance(2020,10,10)
            , Shop__c = shopRecord.id
            , ReserveStartTime__c = Time.newInstance(10, 0, 0 ,0)
            , ReserveEndTime__c = Time.newInstance(10, 30, 0 ,0)
            , ReserveCanCount__c = 5
            , ReserveResultCount__c = 0 
            , AppointmentReceiptStoreDate__c = arsd.id
            , ReserveCanNotCount__c = 0
         );
         insert appointmentReceipt;
    }

    // イベントトリガー
    @isTest static void eventTrigger(){
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'Test@horaguchi.com'];
        // 行動の登録
        Event eventIns = new Event(
            OwnerId = userRecord.id
            ,StartDateTime = DateTime.newInstance(2020, 10, 10, 10, 0, 00)
            ,endDateTime =  DateTime.newInstance(2020, 10, 10, 14, 0, 00)
            ,SUBJECT = '【商談】'
        );
        insert eventIns;   

        // 対応の登録
        Correspond__c addCorrespond = new Correspond__c(
            EventId__c = eventIns.id,
            VisitReservationFlag__c = true
        );
        insert addCorrespond;

        // 行動の更新
        Event eventUpdate = new Event(
            id = eventIns.id
            ,endDateTime =  DateTime.newInstance(2020, 10, 10, 16, 0, 00)
        );
        update eventUpdate;

        // 行動の削除
        delete eventUpdate;
    }

        // イベントトリガー2
    @isTest static void eventTrigger2(){
        User userRecord =  [SELECT Id FROM User WHERE UserName = 'Test@horaguchi.com'];
        
        try{
        // 行動の登録(重複しない)
        Event eventInsA = new Event(
            OwnerId = userRecord.id
            ,StartDateTime = DateTime.newInstance(2020, 10, 11, 10, 0, 00)
            ,endDateTime =  DateTime.newInstance(2020, 10, 11, 14, 0, 00)
            ,SUBJECT = '【商談】'
        ); 
        // 行動の登録（重複）
        Event eventInsB = new Event(
            OwnerId = userRecord.id
            ,StartDateTime = DateTime.newInstance(2020, 10, 10, 10, 0, 00)
            ,endDateTime =  DateTime.newInstance(2020, 10, 10, 14, 0, 00)
            ,SUBJECT = '【商談】'
        );
        // 行動の登録（重複）
        Event eventInsC = new Event(
            OwnerId = userRecord.id
            ,StartDateTime = DateTime.newInstance(2020, 10, 10, 10, 0, 00)
            ,endDateTime =  DateTime.newInstance(2020, 10, 10, 14, 0, 00)
            ,SUBJECT = '【商談】'
        );    
        //行動をリストに追加
        List<Event> eventList = new List<Event>(); 
        eventList.add(eventInsA);
        eventList.add(eventInsB);
        eventList.add(eventInsC);
        //リストを追加
        insert eventList;    
        }catch(Exception e){
            System.assertEquals(true, e.getMessage().contains(CommonConst.MSG_CUST_E_REGISTRATION_EVENT_DUPLICATE));
        }

        try{
        // 行動の登録（既存レコードの作成）
        Event eventInsD = new Event(
            OwnerId = userRecord.id
            ,StartDateTime = DateTime.newInstance(2020, 10, 11, 10, 0, 00)
            ,endDateTime =  DateTime.newInstance(2020, 10, 11, 14, 0, 00)
            ,SUBJECT = '【商談】'
        );      
        //追加
        insert eventInsD;  
        
        // 行動の登録（Dに重複）
        Event eventInsE = new Event(
            OwnerId = userRecord.id
            ,StartDateTime = DateTime.newInstance(2020, 10, 11, 10, 0, 00)
            ,endDateTime =  DateTime.newInstance(2020, 10, 11, 14, 0, 00)
            ,SUBJECT = '【商談】'
        );             
        //追加
        update eventInsD;
        insert eventInsE;  
        }catch(Exception e){
            System.assertEquals(true, e.getMessage().contains(CommonConst.MSG_CUST_E_REGISTRATION_EVENT_DUPLICATE));
        }
    }
}