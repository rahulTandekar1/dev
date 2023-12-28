/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for UspsValidatedAddress
*/

@isTest(isParallel=true)
private with sharing class UspsValidatedAddressTest {

    final static Map<String,String> ADDRESS_VALUES = new Map<String,String>{
        'ID' => '0',
        'Address1' => 'STE K',
        'Address2' => '29851 AVENTURA',
        'City' => 'RANCHO SANTA MARGARITA',
        'CityAbbreviation' => 'RCHO STA MARG',
        'State' => 'CA',
        'Zip5' => '92688',
        'Zip4' => '2014',
        'DeliveryPoint' => '83',
        'CarrierRoute' => 'C057',
        'Footnotes' => 'N',
        'DPVConfirmation' => 'Y',
        'DPVCMRA' => 'N',
        'DPVFootnotes' => 'AABB',
        'Business' => 'Y',
        'CentralDeliveryPoint' => 'N',
        'Vacant' => 'N'
    };

    @isTest private static void constructorWithAllFields() {
        UspsValidatedAddress theAddress = new UspsValidatedAddress(ADDRESS_VALUES);

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
}