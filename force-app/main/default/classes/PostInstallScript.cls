/**
 * インストール後にデータ作成クラス
 */
global class PostInstallScript implements InstallHandler {
    
    global void onInstall(InstallContext context) {
        // 初回時
        if(context.previousVersion() == null) {
            //標準オブジェクト自動採番作成
            StandardObjectNumberSerial__c stdObjSerialAccount = new StandardObjectNumberSerial__c(
                ObjectApi__c = 'Account'      //オブジェクトAPI名
                ,Serial__c   = 1              //連番
                ,FieldApi__c = 'grung__ForeignIDAutoNumber__c'//項目名
                ,Format__c = 'AFN-{0000000}'  //表示形式
            );
            SecureDML.secureInsert(stdObjSerialAccount);
        }
    }
}