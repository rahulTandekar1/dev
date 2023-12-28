/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Represents a USPS address and contains methods to form the XML documents necessary to call the Address Validation API
*/

public virtual with sharing class UspsAddress {

    @auraEnabled public String id;
    @auraEnabled public String street;
    @testVisible protected String addressLine1;
    @testVisible protected String addressLine2;
    @auraEnabled public String city;
    @auraEnabled public String state;
    @auraEnabled public UspsZipCode zipCode;
    @auraEnabled public String firmName;

    public UspsAddress() {}

    public UspsAddress(String id, String street, String city, String state, String zipCode) {
        this(id, street, city, state, zipCode, '');
    }

    public UspsAddress(String id, String street, String city, String state, String zipCode, String firmName) {

        this.id = Strings.denullify(id) == '' ? String.valueOf(Datetime.now().getTime()) : Strings.denullify(id);
        this.street = Strings.denullify(street);
        this.city = Strings.denullify(city);
        this.state = Strings.denullify(state);
        this.zipcode = new UspsZipCode(zipCode);
        this.firmName = Strings.denullify(firmName);

        if (street != null) {
            List<String> splitStreet = street.split('\n');
            this.addressLine1 = splitStreet.remove(0);
            this.addressLine2 = String.join(splitStreet.clone(), '\n');     
        } else {
            this.addressLine1 = '';
            this.addressLine2 = '';
        }
    }

    public String toUspsXml() {
        String thePayload = '';
        
        thePayload += '<Address ID="' + this.id + '">';
        thePayload += buildXmlAttribute(this.firmName, 'FirmName');
        thePayload += buildXmlAttribute(this.addressLine1, 'Address1');
        thePayload += buildXmlAttribute(this.addressLine2, 'Address2');
        thePayload += buildXmlAttribute(this.city, 'City');
        thePayload += buildXmlAttribute(this.state, 'State');
        thePayload += buildXmlAttribute(this.zipCode.zip5, 'Zip5');
        thePayload += buildXmlAttribute(this.zipCode.zip4, 'Zip4');
        thePayload += '</Address>';
        return thePayload;
    }

    @testVisible
    private static String buildXmlAttribute(String value, String tagName) {
        if (tagName == null || tagName == '') {
            return '';
        } else if (value != null && value != '') {
            return '<' + tagName + '>' + value + '</' + tagName + '>';
        } 
        return '<' + tagName + '/>';
    }
}