/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for UspsZipCode
*/

@isTest(isParallel=true)
private with sharing class UspsZipCodeTest {

    private static void assertion(String scenario, String attributeName, String shouldBe, String actualValue, String expectedValue) {
        String assertionMessage = scenario + ', attribute ' + attributeName + ' should be ' + shouldBe + '.';
        Assert.areEqual(expectedValue, actualValue, assertionMessage);
    }

    @isTest private static void emptyConstructor() {
        Assert.isNotNull(new UspsZipCode(), 'The empty constructor should initialize the instance so it is not null.');
    }

    @isTest private static void onNullZipcode() {
        String scenario = 'When the input to the constructor is null';

        UspsZipCode theZipCode = new UspsZipCode(null);

        assertion(scenario, 'zip5', 'empty', theZipCode.zip5, '');
        assertion(scenario, 'zip4', 'empty', theZipCode.zip4, '');
        assertion(scenario, 'zip', 'empty', theZipCode.zip, '');
    }

    @isTest private static void onEmptyZipcode() {
        String scenario = 'When the input to the constructor is an empty string';

        UspsZipCode theZipCode = new UspsZipCode('');

        assertion(scenario, 'zip5', 'empty', theZipCode.zip5, '');
        assertion(scenario, 'zip4', 'empty', theZipCode.zip4, '');
        assertion(scenario, 'zip', 'empty', theZipCode.zip, '');
    }

    @isTest private static void onAlphanumericalZipcode() {
        String scenario = 'When the input to the constructor is an alphanumerical string';

        UspsZipCode theZipCode = new UspsZipCode('SW1A 1AA'); // Postal code to Buckingham Palace

        assertion(scenario, 'zip5', 'empty', theZipCode.zip5, '');
        assertion(scenario, 'zip4', 'empty', theZipCode.zip4, '');
        assertion(scenario, 'zip', 'empty', theZipCode.zip, '');
    }

    @isTest private static void onNonconformingNumericalZipcode() {
        String scenario = 'When the input to the constructor is an alphanumerical string';

        UspsZipCode theZipCode = new UspsZipCode('507025'); // Postal code to Vlad Tepeş's Castle in Bran, Romania

        assertion(scenario, 'zip5', 'empty', theZipCode.zip5, '');
        assertion(scenario, 'zip4', 'empty', theZipCode.zip4, '');
        assertion(scenario, 'zip', 'empty', theZipCode.zip, '');
    }

    @isTest private static void onShortNumericalZipcode() {
        String scenario = 'When the input to the constructor is a short numerical string';

        UspsZipCode theZipCode = new UspsZipCode('123');

        assertion(scenario, 'zip5', 'the five-digit left-padded version of that string', theZipCode.zip5, '00123');
        assertion(scenario, 'zip4', 'empty', theZipCode.zip4, '');
        assertion(scenario, 'zip', 'the five-digit left-padded version of that string, no zip4', theZipCode.zip, '00123');
    }

    @isTest private static void onFiveDigitZipcode() {
        String scenario = 'When the input to the constructor is a five-digit string';

        UspsZipCode theZipCode = new UspsZipCode('12345');

        assertion(scenario, 'zip5', 'that string', theZipCode.zip5, '12345');
        assertion(scenario, 'zip4', 'empty', theZipCode.zip4, '');
        assertion(scenario, 'zip', 'that string, no zip4', theZipCode.zip, '12345');
    }

    @isTest private static void onFiveDashFourDigitZipcode() {
        String scenario = 'When the input to the constructor is a string with five digits, a dash, and four more digits';

        UspsZipCode theZipCode = new UspsZipCode('12345-6789');

        assertion(scenario, 'zip5', 'the first part that string', theZipCode.zip5, '12345');
        assertion(scenario, 'zip4', 'the second part of that string', theZipCode.zip4, '6789');
        assertion(scenario, 'zip', 'the whole zip code', theZipCode.zip, '12345-6789');
    }

    @isTest private static void onNineDigitZipcode() {
        String scenario = 'When the input to the constructor is a nine-digit string';

        UspsZipCode theZipCode = new UspsZipCode('123456789');

        assertion(scenario, 'zip5', 'the first five digits in that string', theZipCode.zip5, '12345');
        assertion(scenario, 'zip4', 'the last four digits in that string', theZipCode.zip4, '6789');
        assertion(scenario, 'zip', 'the whole zip code', theZipCode.zip, '12345-6789');
    }

}