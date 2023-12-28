public class AccountTriage extends SObjectTriage {
    
    // Constructor
    public AccountTriage(Map<Id,Account> oldMap, List<Account> newList) {
        super(oldMap, newList);
    }
    
    // Override on() methods to list what actions should be performed
    // Encapsulate each action in a separate method
    protected override void onBeforeInsert() {
    }
    
    protected override void onAfterInsert() {
        
        // AC - This is where we TRIAGE, and check which addresses require validation.
        
        //USPS address validation call
       AddressValidationService.callUSPSValidation(newList,null);
    }
    
    protected override void onAfterUpdate() {
        
        // AC - What is the purpose of the following line?
        
        Map<Id,Account>oldAccountMap = (Map<Id,Account>) oldMap;
        
        
        //USPS address validation call
        AddressValidationService.callUSPSValidation(newList,oldAccountMap);
    }
    
    
}