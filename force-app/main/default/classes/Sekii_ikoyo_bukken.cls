/**
 * 移行用のバッチクラスです。
 * 物件検索用の追加項目四つの値を埋めます。
 * トリガの動きを止めて使ってください。
 **/
global with sharing class Sekii_ikoyo_bukken implements Database.Batchable<sObject>{
    
    //コンストラクタ
    global Sekii_ikoyo_bukken(){
    }
    
    //データ取得
    global Database.QueryLocator start(Database.BatchableContext BC){
        return null;   
    }
    
    //開始
    global void execute(Database.BatchableContext BC, List<Property__c> targetList){

       
        
    }
    
    /*
* バッチ処理の終了時に呼び出される
* 終了処理を実装する
*/
    global void finish(Database.BatchableContext BC) {

    }
}