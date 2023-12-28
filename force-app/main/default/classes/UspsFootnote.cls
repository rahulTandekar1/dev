/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Enum-like class that allows us to translate the footnotes in the XML response of the USPS Address Validation API into readable strings
*/

public with sharing class UspsFootnote {

    @AuraEnabled public String description;
    @AuraEnabled public String explanation;

    private UspsFootnote(String description, String explanation) {
        this.description = description;
        this.explanation = explanation;
    }

    public static final UspsFootnote ZIP_CODE_CORRECTED = new UspsFootnote(
        'Zip Code Corrected',
        'The address was found to have a different 5-digit Zip Code than given in the submitted list. The correct Zip Code is shown in the output address.'
    );

    public static final UspsFootnote CITY_STATE_SPELLING_CORRECTED = new UspsFootnote(
        'City / State Spelling Corrected',
        'The spelling of the city name and/or state abbreviation in the submitted address was found to be different than the standard spelling. The standard spelling of the city name and state abbreviation are shown in the output address.'
    );

    public static final UspsFootnote INVALID_CITY_STATE_ZIP = new UspsFootnote(
        'Invalid City / State / Zip',
        'The Zip Code in the submitted address could not be found because neither a valid city, state, nor valid 5-digit Zip Code was present. It is also recommended that the requestor check the submitted address for accuracy.'    
    );

    public static final UspsFootnote NO_ZIP_PLUS_FOUR_ASSIGNED = new UspsFootnote(
        'No Zip+4 Assigned',
        'This is a record listed by the United States Postal Service on the national Zip+4 file as a non-deliverable location. It is recommended that the requestor verify the accuracy of the submitted address.'
    );

    public static final UspsFootnote ZIP_CODE_ASSIGNED_FOR_MULTIPLE_RESPONSE = new UspsFootnote(
        'Zip Code Assigned for Multiple Response',
        'Multiple records were returned, but each shares the same 5-digit Zip Code.'
    );

    public static final UspsFootnote ADDRESS_COULD_NOT_BE_FOUND_IN_THE_NATIONAL_DIRECTORY_FILE_DATABASE = new UspsFootnote(
        'Address Could Not Be Found in The National Directory File Database',
        'The address, exactly as submitted, could not be found in the city, state, or Zip Code provided.'
    );

    public static final UspsFootnote INFORMATION_IN_FIRM_LINE_USED_FOR_MATCHING = new UspsFootnote(
        'Information In Firm Line Used for Matching',
        'Information in the firm line was determined to be a part of the address. It was moved out of the firm line and incorporated into the address line.'
    );

    public static final UspsFootnote MISSING_SECONDARY_NUMBER = new UspsFootnote(
        'Missing Secondary Number',
        'Zip+4 information indicated this address is a building. The address as submitted does not contain an apartment/suite number.'
    );

    public static final UspsFootnote INSUFFICIENT_INCORRECT_ADDRESS_DATA = new UspsFootnote(
        'Insufficient / Incorrect Address Data',
        'More than one Zip+4 was found to satisfy the address as submitted. The submitted address did not contain sufficiently complete or correct data to determine a single Zip+4 Code.'
    );

    public static final UspsFootnote DUAL_ADDRESS = new UspsFootnote(
        'Dual Address',
        'The input contained two addresses.'
    );

    public static final UspsFootnote MULTIPLE_RESPONSE_DUE_TO_CARDINAL_RULE = new UspsFootnote(
        'Multiple Response Due to Cardinal Rule',
        'CASS rule does not allow a match when the cardinal point of a directional changes more than 90%.'
    );

    public static final UspsFootnote ADDRESS_COMPONENT_CHANGED = new UspsFootnote(
        'Address Component Changed',
        'An address component was added, changed, or deleted in order to achieve a match.'
    );

    public static final UspsFootnote STREET_NAME_CHANGED = new UspsFootnote(
        'Street Name Changed',
        'The spelling of the street name was changed in order to achieve a match.'
    );

    public static final UspsFootnote ADDRESS_STANDARDIZED = new UspsFootnote(
        'Address Standardized',
        'The delivery address was standardized.'
    );

    public static final UspsFootnote LOWEST_PLUS_FOUR_TIE_BREAKER = new UspsFootnote(
        'Lowest +4 Tie-Breaker',
        'More than one Zip+4 Code was found to satisfy the address as submitted. The lowest Zip+4 addon may be used to break the tie between the records.'
    );

    public static final UspsFootnote BETTER_ADDRESS_EXISTS = new UspsFootnote(
        'Better Address Exists',
        'The delivery address is matchable, but is known by another (preferred) name.'
    );

    public static final UspsFootnote UNIQUE_ZIP_CODE_MATCH = new UspsFootnote(
        'Unique Zip Code Match',
        'Match to an address with a unique Zip Code.'
    );

    public static final UspsFootnote NO_MATCH_DUE_TO_EWS = new UspsFootnote(
        'No Match Due To EWS',
        'The delivery address is matchable, but the EWS file indicates that an exact match will be available soon.'
    );

    public static final UspsFootnote INCORRECT_SECONDARY_ADDRESS = new UspsFootnote(
        'Incorrect Secondary Address',
        'The secondary information does not match that on the national Zip+4 file. This secondary information, although present on the input address, was not valid in the range found on the national Zip+4 file.'
    );

    public static final UspsFootnote MULTIPLE_RESPONSE_DUE_TO_MAGNET_STREET_SYNDROME = new UspsFootnote(
        'Multiple Response Due to Magnet Street Syndrome',
        'The search resulted on a single response; however, the record matched was flagged as having magnet street syndrome.'
    );

    public static final UspsFootnote UNOFFICIAL_POST_OFFICE_NAME = new UspsFootnote(
        'Unofficial Post Office Name',
        'The city or post office name in the submitted address is not recognized by the United States Postal Service as an official last line name (preferred city name) and is not acceptable as an alternate name.'
    );

    public static final UspsFootnote UNVERIFIABLE_CITY_STATE = new UspsFootnote(
        'Unverifiable City / State',
        'The city and state in the submitted address could not be verified as corresponding to the given 5-digit Zip Code.'
    );

    public static final UspsFootnote INVALID_DELIVERY_ADDRESS = new UspsFootnote(
        'Invalid Delivery Address',
        'The input address record contains a delivery address other than a PO BOX, General Delivery, or Postmaster with a 5-digit Zip Code that is identified as a “small town default.” The United States Postal Service does not provide street delivery for this Zip Code. The United States Postal Service requires use of a PO BOX, General Delivery, or Postmaster for delivery within this Zip Code.'
    );

    public static final UspsFootnote UNIQUE_ZIP_CODE_GENERATED = new UspsFootnote(
        'Unique Zip Code Generated',
        'Default match inside a unique Zip Code.'
    );

    public static final UspsFootnote MILITARY_MATCH = new UspsFootnote(
        'Military Match',
        'Match made to a record with a military Zip Code.'
    );

    public static final UspsFootnote MATCH_MODE_USING_THE_ZIPMOVE_PRODUCT_DATA = new UspsFootnote(
        'Match Mode Using the ZIPMOVE Product Data',
        'The ZIPMOVE product shows which Zip+4 records have moved from one Zip Code to another.'
    );

    public static Map<String,UspsFootnote> byCode = new Map<String,UspsFootnote>{
        'A' => ZIP_CODE_CORRECTED,
        'B' => CITY_STATE_SPELLING_CORRECTED,
        'C' => INVALID_CITY_STATE_ZIP,
        'D' => NO_ZIP_PLUS_FOUR_ASSIGNED,
        'E' => ZIP_CODE_ASSIGNED_FOR_MULTIPLE_RESPONSE,
        'F' => ADDRESS_COULD_NOT_BE_FOUND_IN_THE_NATIONAL_DIRECTORY_FILE_DATABASE,
        'G' => INFORMATION_IN_FIRM_LINE_USED_FOR_MATCHING,
        'H' => MISSING_SECONDARY_NUMBER,
        'I' => INSUFFICIENT_INCORRECT_ADDRESS_DATA,
        'J' => DUAL_ADDRESS,
        'K' => MULTIPLE_RESPONSE_DUE_TO_CARDINAL_RULE,
        'L' => ADDRESS_COMPONENT_CHANGED,
        'M' => STREET_NAME_CHANGED,
        'N' => ADDRESS_STANDARDIZED,
        'O' => LOWEST_PLUS_FOUR_TIE_BREAKER,
        'P' => BETTER_ADDRESS_EXISTS,
        'Q' => UNIQUE_ZIP_CODE_MATCH,
        'R' => NO_MATCH_DUE_TO_EWS,
        'S' => INCORRECT_SECONDARY_ADDRESS,
        'T' => MULTIPLE_RESPONSE_DUE_TO_MAGNET_STREET_SYNDROME,
        'U' => UNOFFICIAL_POST_OFFICE_NAME,
        'V' => UNVERIFIABLE_CITY_STATE,
        'W' => INVALID_DELIVERY_ADDRESS,
        'X' => UNIQUE_ZIP_CODE_GENERATED,
        'Y' => MILITARY_MATCH,
        'Z' => MATCH_MODE_USING_THE_ZIPMOVE_PRODUCT_DATA
    };

    public static List<UspsFootnote> fromString(String theString) {
        List<UspsFootnote> footnotes = new List<UspsFootnote>();

        if (theString != null) {
            for (String theCharacter: theString.split('')) {
                footnotes.add(UspsFootnote.byCode.get(theCharacter));
            }
        }
        return footnotes;
    }
}