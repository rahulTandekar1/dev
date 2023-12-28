/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for UspsAddressValidationService
*/

@isTest(isParallel=true)
public with sharing class UspsAddressValidationServiceTest {

    public static final String SAMPLE_REQUEST = '<AddressValidateRequest USERID="XXXXXXXXXXXX"><Revision>1</Revision><Address ID="0"><FirmName/><Address1>SUITE K</Address1><Address2>29851 Aventura</Address2><City/><State>CA</State><Zip5>92688</Zip5><Zip4/></Address></AddressValidateRequest>';
    @isTest private static void validateWithSampleRequest() {

        Test.setMock(HttpCalloutMock.class, new UspsAddressValidationApiMock());

        List<UspsAddress> addresses = new List<UspsAddress>();

        addresses.add(
            new UspsAddress(
                '0',                        // Address ID
                'SUITE K\n29851 Aventura',  // Street
                '',                         // City
                'CA',                       // State
                '92688'                     // Zip Code
            )
        );

        List<UspsAddressValidationResult> result = UspsAddressValidationService.validate(addresses);

        Assert.areEqual(1, result.size(), 'The resulting list should contain only one element, like the sample response.');
        Assert.isNull(result[0].error, 'The resulting list should not contain errors.');

        UspsValidatedAddress theAddress = result[0].validatedAddress;

        Assert.areEqual('0', theAddress.id, 'The attribute id in the validated address should match the value of "ID" in the XML.');
        Assert.areEqual('29851 AVENTURA \nSTE K', theAddress.street, 'The attribute street in the validated address should be the concatenation of "Address2" and "Address1" from the XML.');
        Assert.areEqual('RANCHO SANTA MARGARITA', theAddress.city, 'The attribute city in the validated address should match the value of "City" in the XML.');
        Assert.areEqual('RCHO STA MARG', theAddress.cityAbbreviation, 'The attribute cityAbbreviation in the validated address should match the value of "CityAbbreviation" in the XML.');
        Assert.areEqual('CA', theAddress.state, 'The attribute state in the validated address should match the value of "State" in the XML.');
        Assert.areEqual('92688', theAddress.zipCode.zip5, 'The attribute zip5 in the zip code of the validated address should match the value of "Zip5" in the XML.');
        Assert.areEqual('2014', theAddress.zipCode.zip4, 'The attribute zip4 in the zip code of the validated address should match the value of "Zip4" in the XML.');
        Assert.areEqual('83', theAddress.deliveryPoint, 'The attribute deliveryPoint in the validated address should match the value of "DeliveryPoint" in the XML.');
        Assert.areEqual('C057', theAddress.carrierRoute, 'The attribute carrierRoute in the validated address should match the value of "CarrierRoute" in the XML.');
        Assert.areEqual(UspsFootnote.fromString('N'), theAddress.footnotes, 'The attribute footnotes in the validated address should match the value of "Footnotes" in the XML.');
        Assert.areEqual('Y', theAddress.dpvConfirmation, 'The attribute dpvConfirmation in the validated address should match the value of "DPVConfirmation" in the XML.');
        Assert.areEqual(false, theAddress.isDpvCmra, 'The attribute isDpvCmra in the validated address should match the value of "DPVCMRA" in the XML.');
        Assert.areEqual(UspsDpvFootnote.fromString('AABB'), theAddress.dpvFootnotes, 'The attribute dpvFootnotes in the validated address should match the value of "DPVFootnotes" in the XML.');
        Assert.areEqual(true, theAddress.isBusiness, 'The attribute isBusiness in the validated address should match the value of "Business" in the XML.');
        Assert.areEqual(false, theAddress.isCentralDeliveryPoint, 'The attribute isCentralDeliveryPoint in the validated address should match the value of "CentralDeliveryPoint" in the XML.');
        Assert.areEqual(false, theAddress.isVacant, 'The attribute isVacant in the validated address should match the value of "Vacant" in the XML.');
    }

    @isTest private static void buildPayloadWithNullAddresses() {
        Assert.areEqual(
            '', 
            UspsAddressValidationService.buildPayload(null, 'XXXXXXXXXXXX'),
            'When invoked with a null list of addresses, the buildPayload() method builds an XML that is equivalent to USPS\'s sample request.'
        );        
    }

    @isTest private static void buildPayloadWithEmptyAddresses() {
        Assert.areEqual(
            '', 
            UspsAddressValidationService.buildPayload(new List<UspsAddress>(), 'XXXXXXXXXXXX'),
            'When invoked with an empty list of addresses, the buildPayload() method builds an XML that is equivalent to USPS\'s sample request.'
        );        
    }

    @isTest private static void buildPayloadWithTooManyAddresses() {

        List<UspsAddress> addresses = new List<UspsAddress>();

        for (Integer iteration = 0; iteration < UspsAddressValidationService.MAX_ADDRESSES_PER_VALIDATION + 1; iteration++) {
            addresses.add(new UspsAddress(String.valueOf(iteration), 'SUITE K\n29851 Aventura', '', 'CA', '92688'));
        }

        try {
            UspsAddressValidationService.buildPayload(addresses, 'XXXXXXXXXXXX');
            Assert.fail('When invoked with a list above the limit of addresses per validation, the method buildPayload() should have thrown an exception.');
        } catch(UspsAddressValidationService.AddressValidationException theException) {
            Assert.isTrue(
                theException.getMessage().contains(UspsAddressValidationService.ERROR_TOO_MANY_ADDRESSES), 
                'When invoked with a list above the limit of addresses per validation, the method buildPayload() should have thrown an exception of type AddressValidationException with the right error message.'
            );
        } catch(Exception theException) {
            Assert.fail('When invoked with a list above the limit of addresses per validation, the method buildPayload() should have thrown an exception of type AddressValidationException.');
        }
    }


    @isTest private static void buildPayloadWithUspsSampleRequest() {

        List<UspsAddress> addresses = new List<UspsAddress>();

        addresses.add(
            new UspsAddress(
                '0',                        // Address ID
                'SUITE K\n29851 Aventura',  // Street
                '',                         // City
                'CA',                       // State
                '92688'                     // Zip Code
            )
        );
        
        Assert.areEqual(
            SAMPLE_REQUEST, 
            UspsAddressValidationService.buildPayload(addresses, 'XXXXXXXXXXXX'),
            'When invoked with the necessary parameters, the buildPayload() method builds an XML that is equivalent to USPS\'s sample request.'
        );
    }
}