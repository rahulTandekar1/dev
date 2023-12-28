/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Represents a zip code, and includes a constructor method that is robust to a variety of input formats
*/

public with sharing class UspsZipCode {

    private final static String ZIP_UP_TO_FIVE = '\\d{1,5}';
    private final static String ZIP_NINE = '\\d{9}';
    private final static String ZIP_FIVE_PLUS_FOUR = '\\d{1,5}-\\d{1,4}';

    @AuraEnabled public String zip5 = '';
    @AuraEnabled public String zip4 = '';

    @AuraEnabled public String zip{
        get {
            if (zip4 == '') {
                return zip5;
            }
            return zip5 + '-' + zip4;
        }
        set {
            if (value == null) {
                this.zip5 = '';
                this.zip4 = '';
            } else if (Pattern.matches(ZIP_FIVE_PLUS_FOUR, value)) {
                this.zip5 = value.split('-')[0];
                this.zip4 = value.split('-')[1];
            } else if (Pattern.matches(ZIP_NINE, value)) {
                this.zip5 = value.left(5);
                this.zip4 = value.right(4);
            } else if (Pattern.matches(ZIP_UP_TO_FIVE, value)) {
                this.zip5 = value.leftPad(5, '0');
                this.zip4 = '';
            } else {
                this.zip5 = '';
                this.zip4 = '';
            }    
        }
    }

    public UspsZipCode() {}

    public UspsZipCode(String zipCode) {
        this.zip = zipCode;
    }
}