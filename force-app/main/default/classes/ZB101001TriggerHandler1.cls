// 取引先のトリガハンドラ
public with sharing class ZB101001TriggerHandler1 {
    
    /** トリガから実行 */
    private boolean m_isExecuting = false;
    /** 新旧両方のトリガコール内のレコードの数 */
    private integer BatchSize = 0;
    
    /** コンストラクタ */
    public ZB101001TriggerHandler1(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
    
    /** 登録前処理 */
    public void onBeforeInsert(Account[] newObjs){
        ZB101001Controller.serialSettingSerial(newObjs, 'Account');
    }
    
    /** 登録後処理 */
    public void onAfterInsert(Account[] newObjs, Map<ID, Account> newObjMap){
    }
    
    /** 更新前処理 */
    public void onBeforeUpdate(Account[] oldObjs, Map<ID, Account> oldObjMap, Account[] newObjs, Map<ID, Account> newObjMap){
    }
    
    /** 更新後処理 */
    public void onAfterUpdate(Account[] oldObjs, Map<ID, Account> oldObjMap, Account[] newObjs, Map<ID, Account> newObjMap){
    }
    
    /** 削除前処理 */
    public void onBeforeDelete(Account[] oldObjs, Map<ID, Account> oldObjMap){
    }
    
    /** 削除後処理 */
    public void onAfterDelete(Account[] oldObjs, Map<ID, Account> oldObjMap){
    }
    
    /** 復元後処理 */
    public void onUndelete(Account[] newObjs){
    }
}