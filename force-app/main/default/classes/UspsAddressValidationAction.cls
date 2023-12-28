/**
* @author Andrés Catalán, Slalom
* @date 2023-11-15
* @description Defines an invocable Apex Action for Flow
*/

public with sharing class UspsAddressValidationAction {
    @InvocableMethod(
        label = 'Validate US Addresses'
        description = 'Send up to five addresses to the United States Postal Service for validation'
        callout = true
        category = 'Address'
    ) public static List<Result> validateAddresses(List<Request> requests) {

        List<UspsAddress> addresses = new List<UspsAddress>();
        List<Result> results = new List<Result>();

        for (Request thisRequest: requests) {
            addresses.add(
                new UspsAddress(
                    thisRequest.id,
                    thisRequest.street,
                    thisRequest.city,
                    thisRequest.state,
                    thisRequest.zipCode,
                    thisRequest.firmName
                )
            );
        }
        for (UspsAddressValidationResult thisResult: UspsAddressValidationService.validate(addresses)) {
            Result resultObj = new Result(thisResult.validatedAddress, thisResult.error);
            if(thisResult.error != null){
                resultObj.success = false;
            }
            
            results.add(resultObj);
            System.debug('Address >> ' + thisResult.validatedAddress);
            System.debug('Error >> ' + thisResult.error?.description);
        }
        
        return results;
    }

    public class Request{
        @InvocableVariable(
            label='Address ID' 
            description='Used to identify the proper result when multiple addresses are submitted' 
            required=false
        ) public String id;
        @InvocableVariable(
            label='Street' 
            description='Street number and street name of the address, may contain secondary unit designator' 
            required=false
        ) public String street;
        @InvocableVariable(
            label='City' 
            description='City name of the address' 
            required=false
        ) public String city;
        @InvocableVariable(
            label='State' 
            description='Two-character state code of the address' 
            required=false
        ) public String state;
        @InvocableVariable(
            label='Zip Code' 
            description='Address Zip Code, numeric values only' 
            required=false
        ) public String zipCode;
        @InvocableVariable(
            label='Organization Name' 
            description='Name of the organization or business in this address' 
            required=false
        ) public String firmName;
    }

    public class Result{
        @InvocableVariable public UspsValidatedAddress validatedAddress;
        @InvocableVariable public UspsAddressValidationError error;
        @InvocableVariable public Boolean success;

        public Result(UspsValidatedAddress validatedAddress, UspsAddressValidationError error) {
            this.validatedAddress = validatedAddress;
            this.error = error;
            this.success = (validatedAddress != null);
        }
    }
}