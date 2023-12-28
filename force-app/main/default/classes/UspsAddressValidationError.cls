/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Represents an error returned by the USPS Address Validation API
*/

public with sharing class UspsAddressValidationError {

    @AuraEnabled public final String id;
    @AuraEnabled public final String errorNumber;
    @AuraEnabled public final String source;
    @AuraEnabled public final String description;
    @AuraEnabled public final String explanation;

    public UspsAddressValidationError(Map<String,String> errorData) {
        this.id = Strings.denullify(errorData.get('ID')?.trim());
        this.errorNumber = Strings.denullify(errorData.get('Number')?.trim());
        this.source = Strings.denullify(errorData.get('Source')?.trim());
        this.description = Strings.denullify(errorData.get('Description')?.trim());
        this.explanation = Strings.denullify(EXPLANATIONS_BY_ERROR.get(this.description));
    }

    public static final Map<String,String> EXPLANATIONS_BY_ERROR = new Map<String,String>{
        'Invalid Address.' => 
        'Address is not valid',

        'Invalid Zip Code.' =>
        'Zip code is not valid',

        'Invalid State Code.' =>
        'State code is not valid',
    
        'Invalid City.' =>
        'City is not valid',
    
        'Address Not Found.' =>
        'Address not found',
    
        'Multiple addresses were found for the information you entered, and no default exists.' => 
        'More than 1 address was found for the address information provided and there is not default designated for this address. The address as submitted does not contain an apartment/suite number. It is recommended that the requestor check the submitted address and add the missing apartment or suite number',
    
        'Single Response - exact match' =>
        'Exact match on address',
    
        'Default address: The address you entered was found but more information is needed (such as an apartment, suite, or box number) to match to a specific address.' =>
        'Default address was returned, need additional information to get an exact match. The address as submitted does not contain an apartment/suite number. It is recommended that the requestor check the submitted address and add the missing apartment or suite number'
    };
}