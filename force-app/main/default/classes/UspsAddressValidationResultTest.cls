/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for UspsAddressValidationResult
*/

@isTest(isParallel=true)
public with sharing class UspsAddressValidationResultTest {

    public static final String SAMPLE_RESPONSE = '<AddressValidateResponse><Address ID="0"><Address1> STE K</Address1><Address2>29851 AVENTURA</Address2><City>RANCHO SANTA MARGARITA</City><CityAbbreviation>RCHO STA MARG</CityAbbreviation><State>CA</State><Zip5>92688</Zip5><Zip4>2014</Zip4><DeliveryPoint>83</DeliveryPoint><CarrierRoute>C057</CarrierRoute><Footnotes>N</Footnotes><DPVConfirmation>Y</DPVConfirmation><DPVCMRA>N</DPVCMRA><DPVFootnotes>AABB</DPVFootnotes><Business>Y</Business><CentralDeliveryPoint>N</CentralDeliveryPoint><Vacant>N</Vacant></Address></AddressValidateResponse>';
    public static final String SAMPLE_RESPONSE_FIVE_ADDRESSES = '<AddressValidateResponse><Address ID="0"><Address1> STE K</Address1><Address2>29851 AVENTURA</Address2><City>RANCHO SANTA MARGARITA</City><CityAbbreviation>RCHO STA MARG</CityAbbreviation><State>CA</State><Zip5>92688</Zip5><Zip4>2014</Zip4><DeliveryPoint>83</DeliveryPoint><CarrierRoute>C057</CarrierRoute><Footnotes>N</Footnotes><DPVConfirmation>Y</DPVConfirmation><DPVCMRA>N</DPVCMRA><DPVFootnotes>AABB</DPVFootnotes><Business>Y</Business><CentralDeliveryPoint>N</CentralDeliveryPoint><Vacant>N</Vacant></Address><Address ID="1"><Address1> STE K</Address1><Address2>29851 AVENTURA</Address2><City>RANCHO SANTA MARGARITA</City><CityAbbreviation>RCHO STA MARG</CityAbbreviation><State>CA</State><Zip5>92688</Zip5><Zip4>2014</Zip4><DeliveryPoint>83</DeliveryPoint><CarrierRoute>C057</CarrierRoute><Footnotes>N</Footnotes><DPVConfirmation>Y</DPVConfirmation><DPVCMRA>N</DPVCMRA><DPVFootnotes>AABB</DPVFootnotes><Business>Y</Business><CentralDeliveryPoint>N</CentralDeliveryPoint><Vacant>N</Vacant></Address><Address ID="2"><Address1> STE K</Address1><Address2>29851 AVENTURA</Address2><City>RANCHO SANTA MARGARITA</City><CityAbbreviation>RCHO STA MARG</CityAbbreviation><State>CA</State><Zip5>92688</Zip5><Zip4>2014</Zip4><DeliveryPoint>83</DeliveryPoint><CarrierRoute>C057</CarrierRoute><Footnotes>N</Footnotes><DPVConfirmation>Y</DPVConfirmation><DPVCMRA>N</DPVCMRA><DPVFootnotes>AABB</DPVFootnotes><Business>Y</Business><CentralDeliveryPoint>N</CentralDeliveryPoint><Vacant>N</Vacant></Address><Address ID="3"><Address1> STE K</Address1><Address2>29851 AVENTURA</Address2><City>RANCHO SANTA MARGARITA</City><CityAbbreviation>RCHO STA MARG</CityAbbreviation><State>CA</State><Zip5>92688</Zip5><Zip4>2014</Zip4><DeliveryPoint>83</DeliveryPoint><CarrierRoute>C057</CarrierRoute><Footnotes>N</Footnotes><DPVConfirmation>Y</DPVConfirmation><DPVCMRA>N</DPVCMRA><DPVFootnotes>AABB</DPVFootnotes><Business>Y</Business><CentralDeliveryPoint>N</CentralDeliveryPoint><Vacant>N</Vacant></Address><Address ID="4"><Address1> STE K</Address1><Address2>29851 AVENTURA</Address2><City>RANCHO SANTA MARGARITA</City><CityAbbreviation>RCHO STA MARG</CityAbbreviation><State>CA</State><Zip5>92688</Zip5><Zip4>2014</Zip4><DeliveryPoint>83</DeliveryPoint><CarrierRoute>C057</CarrierRoute><Footnotes>N</Footnotes><DPVConfirmation>Y</DPVConfirmation><DPVCMRA>N</DPVCMRA><DPVFootnotes>AABB</DPVFootnotes><Business>Y</Business><CentralDeliveryPoint>N</CentralDeliveryPoint><Vacant>N</Vacant></Address></AddressValidateResponse>';
    public static final String SAMPLE_RESPONSE_ERROR = '<AddressValidateResponse><Address ID="0"><Error><Number>-2147219401</Number><Source>clsAMS</Source><Description>Address Not Found.  </Description><HelpFile/><HelpContext/></Error></Address></AddressValidateResponse>';

    @isTest private static void fromUspsXmlOneAddress() {

        XmlStreamReader sampleReader = new XmlStreamReader(SAMPLE_RESPONSE);
        List<UspsAddressValidationResult> results = UspsAddressValidationResult.fromUspsXml(sampleReader);

        Assert.areEqual(1, results.size(), 'The resulting list should contain only one element, like the sample response.');
        Assert.isNull(results[0].error, 'The resulting list should not contain errors.');

        UspsValidatedAddress theAddress = results[0].validatedAddress;

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

    @isTest private static void fromUspsXmlFiveAddresses() {

        XmlStreamReader sampleReader = new XmlStreamReader(SAMPLE_RESPONSE_FIVE_ADDRESSES);
        List<UspsAddressValidationResult> results = UspsAddressValidationResult.fromUspsXml(sampleReader);

        Assert.areEqual(5, results.size(), 'The resulting list should contain only one element, like the sample response.');

        for (Integer iterator = 0; iterator < UspsAddressValidationService.MAX_ADDRESSES_PER_VALIDATION; iterator++) {
            Assert.isNull(results[iterator].error, 'The resulting list should not contain errors.');
            UspsValidatedAddress theAddress = results[iterator].validatedAddress;

            Assert.areEqual(String.valueOf(iterator), theAddress.id, 'The attribute id in the validated address should match the value of "ID" in the XML.');
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
    }

    @isTest private static void fromUspsXmlError() {

        XmlStreamReader sampleReader = new XmlStreamReader(SAMPLE_RESPONSE_ERROR);
        List<UspsAddressValidationResult> results = UspsAddressValidationResult.fromUspsXml(sampleReader);

        Assert.areEqual(1, results.size(), 'The resulting list should contain only one element, like the sample response.');
        Assert.isNull(results[0].validatedAddress, 'The resulting list should not contain a validated address.');
        UspsAddressValidationError theError = results[0].error;

        Assert.areEqual('0', theError.id, 'The attribute id in the error should match the value of "ID" in the XML.');
        Assert.areEqual('-2147219401', theError.errorNumber, 'The attribute errorNumber in the error should match the value of "Number" from the XML.');
        Assert.areEqual('clsAMS', theError.source, 'The attribute source in the error should match the value of "Source" in the XML.');
        Assert.areEqual('Address Not Found.', theError.description, 'The attribute description in the error should match the value of "Description" in the XML.');
        Assert.areEqual(UspsAddressValidationError.EXPLANATIONS_BY_ERROR.get(theError.description), theError.explanation, 'The attribute explanation in the error should match the explanation corresponding to the description.');
    }
}