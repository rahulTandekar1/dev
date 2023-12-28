/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for UspsAddress
*/

@isTest(isParallel=true)
private with sharing class UspsAddressTest {

    final static String ID = '0';
    final static String STREET_LINE_1 = '3740 Walnut St';
    final static String STREET_LINE_2 = 'Suite 5123';
    final static String STREET = STREET_LINE_1 + '\n' + STREET_LINE_2;
    final static String CITY = 'Philadelphia';
    final static String STATE = 'PA';
    final static String ZIP_CODE = '19104';

    @isTest private static void emptyConstructor() {
        Assert.isNotNull(new UspsAddress(), 'The empty constructor should initialize the instance so it is not null.');
    }

    @isTest private static void constructorWithAllFields() {
        UspsAddress theAddress = new UspsAddress(ID, STREET, CITY, STATE, ZIP_CODE);

        Assert.areEqual(ID, theAddress.id, 'Attribute id should match the value in the constructor.');
        Assert.areEqual(STREET, theAddress.street, 'Attribute street should match the value in the constructor.');
        Assert.areEqual(CITY, theAddress.city, 'Attribute city should match the value in the constructor.');
        Assert.areEqual(STATE, theAddress.state, 'Attribute state should match the value in the constructor.');
        Assert.areEqual(ZIP_CODE, theAddress.zipCode.zip5, 'Attribute zip5 in the address\' zip code should match the value in the constructor.');

        Assert.areEqual(STREET_LINE_1, theAddress.addressLine1, 'Attribute addressLine1 should match the value in the constructor.');
        Assert.areEqual(STREET_LINE_2, theAddress.addressLine2, 'Attribute addressLine2 should match the value in the constructor.');
    }

    @isTest private static void constructorWithNullId() {
        UspsAddress theAddress = new UspsAddress(null, STREET, CITY, STATE, ZIP_CODE);

        Assert.isTrue(theAddress.id.length() > 0, 'Attribute id should be nonempty if the value in the constructor is null.');
    }

    @isTest private static void constructorWithEmptyId() {
        UspsAddress theAddress = new UspsAddress('', STREET, CITY, STATE, ZIP_CODE);

        Assert.isTrue(theAddress.id.length() > 0, 'Attribute id should be nonempty if the value in the constructor is an empty string.');
    }

    @isTest private static void constructorWithNullStreet() {
        UspsAddress theAddress = new UspsAddress(ID, null, CITY, STATE, ZIP_CODE);

        Assert.areEqual('', theAddress.street, 'Attribute street should be empty if the value in the constructor is null.');
        Assert.areEqual('', theAddress.addressLine1, 'Attribute addressLine1 should be empty if the value of street in the constructor is null.');
        Assert.areEqual('', theAddress.addressLine2, 'Attribute addressLine2 should be empty if the value of street in the constructor is null.');
    }

    @isTest private static void constructorWithEmptyStreet() {
        UspsAddress theAddress = new UspsAddress(ID, '', CITY, STATE, ZIP_CODE);

        Assert.areEqual('', theAddress.street, 'Attribute street should be empty if the value in the constructor is empty.');
        Assert.areEqual('', theAddress.addressLine1, 'Attribute addressLine1 should be empty if the value of street in the constructor is empty.');
        Assert.areEqual('', theAddress.addressLine2, 'Attribute addressLine2 should be empty if the value of street in the constructor is empty.');
    }

    @isTest private static void constructorWithNoStreetLineSeparator() {
        UspsAddress theAddress = new UspsAddress(ID, STREET_LINE_1, CITY, STATE, ZIP_CODE);

        Assert.areEqual(STREET_LINE_1, theAddress.street, 'Attribute street should be empty if the value in the constructor is empty.');
        Assert.areEqual(STREET_LINE_1, theAddress.addressLine1, 'Attribute addressLine1 should be empty if the value of street in the constructor is empty.');
        Assert.areEqual('', theAddress.addressLine2, 'Attribute addressLine2 should be empty if the value of street in the constructor is empty.');
    }

    @isTest private static void constructorWithFirstLineStreetOnly() {
        UspsAddress theAddress = new UspsAddress(ID, STREET_LINE_1 + '\n', CITY, STATE, ZIP_CODE);

        Assert.areEqual(STREET_LINE_1 + '\n', theAddress.street, 'Attribute street should be empty if the value in the constructor is empty.');
        Assert.areEqual(STREET_LINE_1, theAddress.addressLine1, 'Attribute addressLine1 should be empty if the value of street in the constructor is empty.');
        Assert.areEqual('', theAddress.addressLine2, 'Attribute addressLine2 should be empty if the value of street in the constructor is empty.');
    }

    @isTest private static void constructorWithSecondLineStreetOnly() {
        UspsAddress theAddress = new UspsAddress(ID, '\n' + STREET_LINE_2 , CITY, STATE, ZIP_CODE);

        Assert.areEqual('\n' + STREET_LINE_2, theAddress.street, 'Attribute street should be empty if the value in the constructor is empty.');
        Assert.areEqual('', theAddress.addressLine1, 'Attribute addressLine1 should be empty if the value of street in the constructor is empty.');
        Assert.areEqual(STREET_LINE_2, theAddress.addressLine2, 'Attribute addressLine2 should be empty if the value of street in the constructor is empty.');
    }

    @isTest private static void constructorWithNullCity() {
        UspsAddress theAddress = new UspsAddress(ID, STREET, null, STATE, ZIP_CODE);

        Assert.areEqual('', theAddress.city, 'Attribute city should be empty if the value in the constructor is null.');
    }

    @isTest private static void constructorWitEmptyCity() {
        UspsAddress theAddress = new UspsAddress(ID, STREET, '', STATE, ZIP_CODE);

        Assert.areEqual('', theAddress.city, 'Attribute city should be empty if the value in the constructor is empty.');
    }

    @isTest private static void constructorWithNullState() {
        UspsAddress theAddress = new UspsAddress(ID, STREET, CITY, null, ZIP_CODE);

        Assert.areEqual('', theAddress.state, 'Attribute state should be empty if the value in the constructor is null.');
    }

    @isTest private static void constructorWitEmptyState() {
        UspsAddress theAddress = new UspsAddress(ID, STREET, CITY, '', ZIP_CODE);

        Assert.areEqual('', theAddress.state, 'Attribute state should be empty if the value in the constructor is empty.');
    }

    @isTest private static void buildXmlAttributeWhenTagNameIsNull() {
        Assert.areEqual(
            '', 
            UspsAddress.buildXmlAttribute('someValue', null),
            'When tagName is null, buildXmlAttribute should return an empty string.'
        );
    }

    @isTest private static void buildXmlAttributeWhenTagNameIsEmpty() {
        Assert.areEqual(
            '', 
            UspsAddress.buildXmlAttribute('someValue', ''),
            'When tagName is an empty string, buildXmlAttribute should return an empty string.'
        );
    }

    @isTest private static void buildXmlAttributeWhenValueIsNull() {
        Assert.areEqual(
            '<SomeTag/>', 
            UspsAddress.buildXmlAttribute(null, 'SomeTag'),
            'When value is null, buildXmlAttribute should return an empty tag for the tagname.'
        );
    }

    @isTest private static void buildXmlAttributeWhenValueIsEmpty() {
        Assert.areEqual(
            '<SomeTag/>', 
            UspsAddress.buildXmlAttribute('', 'SomeTag'),
            'When value is an empty string, buildXmlAttribute should return an empty tag for tagName.'
        );
    }

    @isTest private static void buildXmlAttributeWhenTagNameAndValueArePopulated() {
        Assert.areEqual(
            '<SomeTag>someValue</SomeTag>', 
            UspsAddress.buildXmlAttribute('someValue', 'SomeTag'),
            'When tagName and value are populated, buildXmlAttribute should return the value wrapped between tagName tags.'
        );
    }

    @isTest private static void toUspsXmlWithUspsSampleRequest() {
        UspsAddress theAddress = new UspsAddress(
            '0',
            'SUITE K\n29851 Aventura',
            '',
            'CA',
            '92688'
        );

        Assert.areEqual(
            '<Address ID="0"><FirmName/><Address1>SUITE K</Address1><Address2>29851 Aventura</Address2><City/><State>CA</State><Zip5>92688</Zip5><Zip4/></Address>', 
            theAddress.toUspsXml(),
            'When invoked with the necessary parameters, the toXml() method builds an XML that is equivalent to USPS\'s sample request.'
        );
    }
}