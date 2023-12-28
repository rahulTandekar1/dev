public class SubmissionTriggerHandler implements TriggerHandler {
    public class SubmissionTriggerHandlerException extends Exception{}
    
    private Boolean triggerIsExecuting;
    private Integer triggerSize;
    
    public static Boolean firstRun = true;
    public static Integer totalRunCount = 0;
    public static Integer beforeInsertRunCount = 0;
    public static Integer afterInsertRunCount = 0;
    public static Integer beforeUpdateRunCount = 0;
    public static Integer afterUpdateRunCount = 0;
    
    public static Boolean isTestBeforeInsertFailure = false;
    public static Boolean isTestAfterInsertFailure = false;
    public static Boolean isTestBeforeUpdateFailure = false;
    public static Boolean isTestAfterUpdateFailure = false;
    public static Boolean isTestBeforeDeleteFailure = false;
    public static Boolean isTestAfterDeleteFailure = false;
    public static Boolean isTestAfterUndeleteFailure = false;
    public static Boolean runTrigger = true;
    
    public SubmissionTriggerHandler(Boolean triggerIsExecuting, Integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        
    }
    
    public void beforeInsert(SObject[] newAccounts) {
        totalRunCount++;
        beforeInsertRunCount++;
        System.debug('beforeInsert totalRunCount: ' + totalRunCount);
        System.debug('beforeInsert beforeInsertRunCount: ' + beforeInsertRunCount);
        
        try{
            if(isTestBeforeInsertFailure && Test.isRunningTest()){
                throw new SubmissionTriggerHandlerException('Test Exception');
            }
            ///CODE UNDER THIS LINE///
            
        }catch(Exception e){
            String exceptionDetails = e.getMessage() + ' | ' + e.getLineNumber() + ' | ' + e.getTypeName() + ' | ' + e.getStackTraceString() + ' | UserInfo: ' + UserInfo.getName();
            throw e;
        }
    }
    
    public void afterInsert(List<sObject> newAccounts, Map<Id, sObject> newAccountMap) {
        try{
            if(isTestAfterInsertFailure && Test.isRunningTest()){
                throw new SubmissionTriggerHandlerException('Test Exception');
            }
            ///CODE UNDER THIS LINE///
            
        }catch(Exception e){
            String exceptionDetails = e.getMessage() + ' | ' + e.getLineNumber() + ' | ' + e.getTypeName() + ' | ' + e.getStackTraceString() + ' | UserInfo: ' + UserInfo.getName();
            throw e;
        }
    }
    
    /* UPDATE CONTEXT */
    public void beforeUpdate(List<sObject> newAccounts, List<sObject> oldAccounts, Map<Id, sObject> newAccountMap, Map<Id, sObject> oldAccountMap) {
        try{
            if(isTestBeforeUpdateFailure && Test.isRunningTest()){
                throw new SubmissionTriggerHandlerException('Test Exception');
            }
            ///CODE UNDER THIS LINE///
            
        }catch(Exception e){
            String exceptionDetails = e.getMessage() + ' | ' + e.getLineNumber() + ' | ' + e.getTypeName() + ' | ' + e.getStackTraceString() + ' | UserInfo: ' + UserInfo.getName();
            throw e;
        }
    }
    
    public void afterUpdate(List<sObject> newAccounts, List<sObject> oldAccounts, Map<Id, sObject> newAccountMap, Map<Id, sObject> oldAccountMap) {
        try{
            if(isTestAfterUpdateFailure && Test.isRunningTest()){
                throw new SubmissionTriggerHandlerException('Test Exception');
            }
            ///CODE UNDER THIS LINE///
            
            
        }catch(Exception e){
            String exceptionDetails = e.getMessage() + ' | ' + e.getLineNumber() + ' | ' + e.getTypeName() + ' | ' + e.getStackTraceString() + ' | UserInfo: ' + UserInfo.getName();
            throw e;
        }
    }
    
    /* DELETE CONTEXT */
    public void beforeDelete(List<sObject> oldAccounts, Map<Id, sObject> oldAccountMap) {
        try{
            if(isTestBeforeDeleteFailure && Test.isRunningTest()){
                throw new SubmissionTriggerHandlerException('Test Exception');
            }
            ///CODE UNDER THIS LINE///
            
        }catch(Exception e){
            String exceptionDetails = e.getMessage() + ' | ' + e.getLineNumber() + ' | ' + e.getTypeName() + ' | ' + e.getStackTraceString() + ' | UserInfo: ' + UserInfo.getName();
            throw e;
        }
    }    
    
    public void afterDelete(List<sObject> oldAccounts, Map<Id, sObject> oldAccountMap) {
        try{
            if(isTestAfterDeleteFailure && Test.isRunningTest()){
                throw new SubmissionTriggerHandlerException('Test Exception');
            }
            ///CODE UNDER THIS LINE///
            
        }catch(Exception e){
            String exceptionDetails = e.getMessage() + ' | ' + e.getLineNumber() + ' | ' + e.getTypeName() + ' | ' + e.getStackTraceString() + ' | UserInfo: ' + UserInfo.getName();
            throw e;
        }
    }
    
    /* UNDELETE CONTEXT */
    public void afterUndelete(List<sObject> newAccounts, Map<Id, sObject> newAccountMap) {
        try{
            if(isTestAfterUndeleteFailure && Test.isRunningTest()){
                throw new SubmissionTriggerHandlerException('Test Exception');
            }
            ///CODE UNDER THIS LINE///
            
        }catch(Exception e){
            String exceptionDetails = e.getMessage() + ' | ' + e.getLineNumber() + ' | ' + e.getTypeName() + ' | ' + e.getStackTraceString() + ' | UserInfo: ' + UserInfo.getName();
            throw e;
        }
    }
}