trigger BD301006Trigger on  BuildingCodeHistory__c (before insert, after insert, before update, after update,                  
                                                    before delete, after delete, after undelete) {                 

    SystemConfig__c config = SystemConfig__c.getOrgDefaults();                    
    if (config.IsSkipTrigger__c) {                    
        return;   // フラグONなら処理Skip                  
    }                 
 
    BD301006TriggerHandler handler = new BD301006TriggerHandler(Trigger.isExecuting, Trigger.size);   
    if(Trigger.isInsert && Trigger.isBefore){ 
        handler.onBeforeInsert(Trigger.new); 
    }                 
    else if(Trigger.isInsert && Trigger.isAfter){                 
        handler.onAfterInsert(Trigger.new, Trigger.newMap);                  
    }
    else if(Trigger.isUpdate && Trigger.isBefore){                    
        handler.onBeforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);                    
    }
    else if(Trigger.isUpdate && Trigger.isAfter){                 
        handler.onAfterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);                 
    }
    else if(Trigger.isDelete && Trigger.isBefore){                    
        handler.onBeforeDelete(Trigger.old, Trigger.oldMap);                 
    }
    else if(Trigger.isDelete && Trigger.isAfter){                 
        handler.onAfterDelete(Trigger.old, Trigger.oldMap);                  
    }
    else if(Trigger.isUnDelete){                  
      handler.onUndelete(Trigger.new);                 
    }
}