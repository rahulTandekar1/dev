public class AccountAccessor {
    public static List<Account> getAccountsById(Set<ID>accountIds){
        return [SELECT Id, 
                RecordType.developername,
                BillingStreet, BillingCity, BillingState, BillingPostalCode,
                BillingCountry,
                ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode,
                ShippingCountry,
                PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, 
                PersonMailingCountry
                
                FROM Account WHERE Id IN:accountIds];
    }
}