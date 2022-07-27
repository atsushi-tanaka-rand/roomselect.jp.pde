@isTest
private class PostInstallScriptTest{
    
    /**
     * 初回インストールテスト
     */
    @isTest static void firstInstall() {
        PostInstallScript postinstall = new PostInstallScript();
        Test.testInstall(postinstall, null);
        List<StandardObjectNumberSerial__c> serialList = [Select id, Serial__c,FieldApi__c,Format__c From StandardObjectNumberSerial__c Where ObjectApi__c ='Account'];
        System.assertEquals(serialList.size(), 1, '標準オブジェクトが登録されていません');
    }
}