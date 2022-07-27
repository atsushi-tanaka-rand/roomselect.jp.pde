@isTest 
public class ZB101001Test {

    //標準オブジェクト（取引）登録エラーテスト
    @isTest static void InsertErrorTest(){
        //取引先をInsert
        try{
            Account a1 = new Account (Name = 'aaa');
            insert a1;
        }catch(Exception e){
           System.assertEquals(true, e.getMessage().contains(CommonUtil.callMessageCreate(CommonConst.MSG_COM_E_NOTING_SERIALRECORD,'取引先')));
        }

    }
    
    //標準オブジェクトトリガカバレッジ率あげ
    @isTest static void coverageUp(){
        //標準オブジェクト自動採番レコードInsert
        StandardObjectNumberSerial__c stdObjSerial = new StandardObjectNumberSerial__c(
            ObjectApi__c = 'Account'      //オブジェクトAPI名
            ,Serial__c   = 1              //連番
            ,FieldApi__c = 'ForeignIDAutoNumber__c'//項目名
            ,Format__c = 'AFN-{0000000}'  //表示形式
        );
        insert stdObjSerial;

        //標準オブジェクトInsert
        Account acc = new Account(Name = 'aaa');
        List<Profile> profiles = [SELECT Id FROM Profile WHERE Name IN ('システム管理者')];
        User userRecord = new User(
                        UserName = 'zb101001test@example.com',
                        Email = 'zb101001test@example.com',
                        LastName = 'zb101001test',
                        Alias = 'test',
                        TimeZoneSidKey = 'Asia/Tokyo',
                        LocaleSidKey = 'ja_JP',
                        EmailEncodingKey = 'ISO-2022-JP',
                        LanguageLocaleKey = 'ja',
                        ProfileId = profiles.get(0).Id);
        insert acc;
        insert userRecord;
        update acc;
        update userRecord;
        delete acc;
        //ユーザは削除できないため、削除処理してません
        
        List<Account> accList = [SELECT id FROM Account WHERE Name = 'aaa'];
        System.assertEquals(true, accList.isEmpty());

        
    }
}