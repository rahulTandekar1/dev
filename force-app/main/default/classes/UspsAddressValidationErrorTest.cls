/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for UspsAddressValidationError
*/

@isTest(isParallel=true)
private with sharing class UspsAddressValidationErrorTest {

    @isTest private static void constructorWithMatchingDescription() {

        Map<String,String> errorData = new Map<String,String>{
            'ID' => '0',
            'Number' => '-2147219401',
            'Source' => 'clsAMS',
            'Description' => 'Invalid Address.'
        };

        UspsAddressValidationError theError = new UspsAddressValidationError(errorData);

        Assert.areEqual('0', theError.id, 'Constructing a UspsAddressValidationError should properly populate the id attribute.');
        Assert.areEqual('-2147219401', theError.errorNumber, 'Constructing a UspsAddressValidationError should properly populate the errorNumber attribute.');
        Assert.areEqual('clsAMS', theError.source, 'Constructing a UspsAddressValidationError should properly populate the source attribute.');
        Assert.areEqual('Invalid Address.', theError.description, 'Constructing a UspsAddressValidationError should properly populate the description attribute.');
        Assert.areEqual('Address is not valid', theError.explanation, 'Constructing a UspsAddressValidationError with a matching description should properly populate the explanation attribute.');
    }

    @isTest private static void constructorWithPaddedMatchingDescription() {

        Map<String,String> errorData = new Map<String,String>{
            'ID' => '0',
            'Number' => '-2147219401',
            'Source' => 'clsAMS',
            'Description' => '       Invalid Address.               '
        };
        
        UspsAddressValidationError theError = new UspsAddressValidationError(errorData);

        Assert.areEqual('0', theError.id, 'Constructing a UspsAddressValidationError should properly populate the id attribute.');
        Assert.areEqual('-2147219401', theError.errorNumber, 'Constructing a UspsAddressValidationError should properly populate the errorNumber attribute.');
        Assert.areEqual('clsAMS', theError.source, 'Constructing a UspsAddressValidationError should properly populate the source attribute.');
        Assert.areEqual('Invalid Address.', theError.description, 'Constructing a UspsAddressValidationError should properly populate the description attribute.');
        Assert.areEqual('Address is not valid', theError.explanation, 'Constructing a UspsError with a space-padded matching description should properly populate the explanation attribute.');
    }

    @isTest private static void constructorWithNonmatchingDescription() {

        Map<String,String> errorData = new Map<String,String>{
            'ID' => '0',
            'Number' => '-2147219401',
            'Source' => 'clsAMS',
            'Description' => 'Valid Address.'
        };

        UspsAddressValidationError theError = new UspsAddressValidationError(errorData);

        Assert.areEqual('0', theError.id, 'Constructing a UspsAddressValidationError should properly populate the id attribute.');
        Assert.areEqual('-2147219401', theError.errorNumber, 'Constructing a UspsAddressValidationError should properly populate the errorNumber attribute.');
        Assert.areEqual('clsAMS', theError.source, 'Constructing a UspsAddressValidationError should properly populate the source attribute.');
        Assert.areEqual('Valid Address.', theError.description, 'Constructing a UspsAddressValidationError should properly populate the description attribute.');
        Assert.areEqual('', theError.explanation, 'Constructing a UspsError with a non-matching description should populate the explanation attribute with an empty string.');

    }
}