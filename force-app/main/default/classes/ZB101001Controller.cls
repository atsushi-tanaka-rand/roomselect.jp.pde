public with sharing class ZB101001Controller {
    public ZB101001Controller() {

    }

    //連番設定
    public static void serialSettingSerial (List<SObject> stdList,String objName){
        //update用標準オブジェクト自動採番
        List<StandardObjectNumberSerial__c> updateSerialList = new List<StandardObjectNumberSerial__c>();
        for (List<StandardObjectNumberSerial__c> serialList : [SELECT Id, Serial__c,FieldApi__c,Format__c From StandardObjectNumberSerial__c WHERE ObjectApi__c = :objName For update]){
            
            //標準オブジェクト自動採番が0件ならエラー
            if (serialList.isEmpty()){
                throw new DMLException(CommonUtil.callMessageCreate(CommonConst.MSG_COM_E_NOTING_SERIALRECORD,getObjectLabelName(stdList[0])));
            }
            
            //取得した標準オブジェクト自動採番をループ
            for (StandardObjectNumberSerial__c rec : serialList){
                //連番
                Decimal num = rec.Serial__c;

                //桁数取得
                Integer digits = rec.Format__c.indexOf('}') - rec.Format__c.indexOf('{') - 1;
                if (rec.Format__c.indexOf('}') == -1 || rec.Format__c.indexOf('{') == -1 || digits < 0){
                    //{ または }がない、または桁数がマイナス
                    throw new DMLException(CommonUtil.callMessageCreate(CommonConst.MSG_COM_E_ILLEGAL_FORMAT,getObjectLabelName(stdList[0])));
                }

                //引数の標準オブジェクト
                for(SObject std : stdList){   
                    //外部Id作成　（表示形式の{より前の値 + 桁数分0詰めした連番）
                    String foreignID = rec.Format__c.substringBefore('{') + String.valueOf(num).leftPad(digits, '0');
                    system.debug(foreignID);                    
                    std.put(rec.FieldApi__c, foreignID);

                    num++;
                }
                
                rec.Serial__c = num;
                updateSerialList.add(rec);
            
            }
            
            //標準オブジェクト採番リストを更新
            SecureDML.secureUpdate(updateSerialList);
        }
    }

    private static String getObjectLabelName (Sobject sobj){
        Schema.SObjectType sot = sobj.getSObjectType();
        DescribeSObjectResult dsor = sot.getDescribe();
        return dsor.getLabel();
    }
}