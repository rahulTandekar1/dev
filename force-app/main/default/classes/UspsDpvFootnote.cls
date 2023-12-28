/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Enum-like class that allows us to translate the DPV footnotes in the XML response of the USPS Address Validation API into readable strings
*/

public with sharing class UspsDpvFootnote {
    @AuraEnabled public String description;


    private UspsDpvFootnote(String description) {
        this.description = description;
    }

    public static final UspsDpvFootnote INPUT_MATCHED_TO_ZIP_FOUR = new UspsDpvFootnote(
        'Input address matched to the ZIP+4 file.'
    );

    public static final UspsDpvFootnote INPUT_NOT_MATCHED_TO_ZIP_FOUR = new UspsDpvFootnote(
        'Input address not matched to the ZIP+4 file.'
    );

    public static final UspsDpvFootnote MATCHED_TO_DPV = new UspsDpvFootnote(
        'Matched to DPV (all components).'
    );

    public static final UspsDpvFootnote SECONDARY_NUMBER_NOT_MATCHED = new UspsDpvFootnote(
        'Secondary number not matched (present but invalid).'
    );

    public static final UspsDpvFootnote HIGH_RISE_MISSING_SECONDARY_NUMBER = new UspsDpvFootnote(
        'High-rise address missing secondary number.'
    );

    public static final UspsDpvFootnote PRIMARY_NUMBER_MISSING = new UspsDpvFootnote(
        'Primary number missing.'
    );

    public static final UspsDpvFootnote PRIMARY_NUMBER_INVALID = new UspsDpvFootnote(
        'Primary number invalid.'
    );

    public static final UspsDpvFootnote BOX_NUMBER_MISSING = new UspsDpvFootnote(
        'Input Address RR or HC Box number Missing.'
    );

    public static final UspsDpvFootnote BOX_NUMBER_INVALID = new UspsDpvFootnote(
        'Input Address PO, RR, or HC Box number Invalid.'
    );

    public static final UspsDpvFootnote MILITARY_ADDRESS = new UspsDpvFootnote(
        'Input Address Matched to a Military Address.'
    );

    public static final UspsDpvFootnote GENERAL_DELIVERY_ADDRESS = new UspsDpvFootnote(
        'Input Address Matched to a General Delivery Address.'
    );

    public static final UspsDpvFootnote UNIQUE_ZIP_CODE = new UspsDpvFootnote(
        'Input Address Matched to a Unique ZIP Code™.'
    );

    public static Map<String,UspsDpvFootnote> byCode = new Map<String,UspsDpvFootnote>{
        'AA' => INPUT_MATCHED_TO_ZIP_FOUR,
        'A1' => INPUT_NOT_MATCHED_TO_ZIP_FOUR,
        'BB' => MATCHED_TO_DPV,
        'CC' => SECONDARY_NUMBER_NOT_MATCHED,
        'N1' => HIGH_RISE_MISSING_SECONDARY_NUMBER,
        'M1' => PRIMARY_NUMBER_MISSING,
        'M3' => PRIMARY_NUMBER_INVALID,
        'P1' => BOX_NUMBER_MISSING,
        'P3' => BOX_NUMBER_INVALID,
        'F1' => MILITARY_ADDRESS,
        'G1' => GENERAL_DELIVERY_ADDRESS,
        'U1' => UNIQUE_ZIP_CODE
    };

    public static List<UspsDpvFootnote> fromString(String theString) {
        List<UspsDpvFootnote> footnotes = new List<UspsDpvFootnote>();

        List<String> characters = theString.split('');

        for (Integer cursor = 0; cursor < characters.size(); cursor += 2) {
            String substring = characters[cursor] + characters[cursor + 1];
            footnotes.add(UspsDpvFootnote.byCode.get(substring));
        }

        return footnotes;
    }


}