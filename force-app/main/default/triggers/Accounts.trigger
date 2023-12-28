trigger Accounts on Account ( before insert, 
                             after insert, 
                             before update, 
                             after update, 
                             before delete, 
                             after delete, 
                             after undelete) {
                                 (new AccountTriage(Trigger.oldMap, Trigger.new))
                                 .handle(Trigger.operationType);
                             }