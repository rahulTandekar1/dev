/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Specialization of UspsAddress that contains the additional fields returned by the USPS Address Validation API when the validation is successful
*/

public with sharing class UspsValidatedAddress {

    @auraEnabled public final String id;
    @auraEnabled public final String street;
    @testVisible public final String addressLine1;
    @testVisible public final String addressLine2;
    @auraEnabled public final String city;
    @auraEnabled public final String state;
    @auraEnabled public final UspsZipCode zipCode;
    @auraEnabled public final String firmName;
    @AuraEnabled public final String cityAbbreviation;
    @AuraEnabled public final String deliveryPoint;
    @AuraEnabled public final String carrierRoute;
    @AuraEnabled public final List<UspsFootnote> footnotes;
    @AuraEnabled public final String dpvConfirmation;
    @AuraEnabled public final Boolean isDpvCmra;
    @AuraEnabled public final List<UspsDpvFootnote> dpvFootnotes;
    @AuraEnabled public final Boolean isBusiness;
    @AuraEnabled public final Boolean isCentralDeliveryPoint;
    @AuraEnabled public final Boolean isVacant;

    public UspsValidatedAddress(Map<String,String> addressData) {

        this.id =  Strings.denullify(addressData.get('ID')?.trim());
        this.addressLine1 = Strings.denullify(addressData.get('Address1')?.trim());
        this.addressLine2 = Strings.denullify(addressData.get('Address2')?.trim());
        this.street = this.addressLine1 != '' ? this.addressLine2 + ' \n' + this.addressLine1 : this.addressLine2;
        this.city = Strings.denullify(addressData.get('City')?.trim());
        this.state = Strings.denullify(addressData.get('State')?.trim());
        this.zipcode = new UspsZipCode(Strings.denullify(addressData.get('Zip5')?.trim()) + Strings.denullify(addressData.get('Zip4')?.trim()));
        this.firmName = Strings.denullify(addressData.get('FirmName')?.trim());
        this.cityAbbreviation = Strings.denullify(addressData.get('CityAbbreviation')?.trim());
        this.deliveryPoint = Strings.denullify(addressData.get('DeliveryPoint')?.trim());
        this.carrierRoute = Strings.denullify(addressData.get('CarrierRoute')?.trim());
        this.footnotes = UspsFootnote.fromString(addressData.get('Footnotes')?.trim());
        this.dpvConfirmation = Strings.denullify(addressData.get('DPVConfirmation')?.trim());
        this.isDpvCmra = 'Y' == Strings.denullify(addressData.get('DPVCMRA')?.trim());
        this.dpvFootnotes = UspsDpvFootnote.fromString(addressData.get('DPVFootnotes')?.trim());
        this.isBusiness = 'Y' == Strings.denullify(addressData.get('Business')?.trim());
        this.isCentralDeliveryPoint = 'Y' == Strings.denullify(addressData.get('CentralDeliveryPoint')?.trim());
        this.isVacant = 'Y' == Strings.denullify(addressData.get('Vacant')?.trim());
    }
}