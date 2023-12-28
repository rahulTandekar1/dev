public with sharing class SalesforceId {

    static final Integer VALUE_OF_0 = '0'.charAt(0);
    static final Integer VALUE_OF_9 = '9'.charAt(0);
    static final Integer DIGIT_DELTA = VALUE_OF_9 - VALUE_OF_0 + 1;
    static final Integer VALUE_OF_UPPERCASE_A = 'A'.charAt(0);
    static final Integer VALUE_OF_UPPERCASE_Z = 'Z'.charAt(0);
    static final Integer UPPERCASE_DELTA = VALUE_OF_UPPERCASE_Z - VALUE_OF_UPPERCASE_A + 1;
    static final Integer VALUE_OF_LOWERCASE_A = 'a'.charAt(0);
    static final Integer VALUE_OF_LOWERCASE_Z = 'z'.charAt(0);
    static final Integer LOWERCASE_DELTA = VALUE_OF_LOWERCASE_Z - VALUE_OF_LOWERCASE_A + 1;
    
    private final Id theId;

    public Id id {
        get{
            return this.theId;
        }
    }

    public String caseSensitiveCode {
        get {
            String code = String.valueOf(theId).substring(7, 15);
            while (code.startsWith('0')) {
                code = code.right(code.length() - 1);
            }
            return code;
        }
    }

    public String code {
        get {
            String code = String.valueOf(theId).substring(7, 18).toUpperCase();
            while (code.startsWith('0')) {
                code = code.right(code.length() - 1);
            }
            return code;
        }
    }

    public String numericString {
        get {
            List<Integer> reversedCharacterCodes = this.caseSensitiveCode.reverse().getChars();
            Decimal theValue = 0;
            for (Integer position = 0; position < reversedCharacterCodes.size(); position++) {
                theValue += valueOf(reversedCharacterCodes[position]) * Math.pow(62, position);
            }
            return theValue.toPlainString().split('\\.')[0];
        }
    }

    public SalesforceId(Id theId) {
        this.theId = theId;
    }

    @testVisible private static Integer valueOf(Integer character) {
        Integer theValue;
        if (character >= VALUE_OF_0 && character <= VALUE_OF_9) {
            theValue = character - VALUE_OF_0;
        } else if (character >= VALUE_OF_UPPERCASE_A && character <= VALUE_OF_UPPERCASE_Z) {
            theValue = character - VALUE_OF_UPPERCASE_A + DIGIT_DELTA;
        } else if (character >= VALUE_OF_LOWERCASE_A && character <= VALUE_OF_LOWERCASE_Z) {
            theValue = character - VALUE_OF_LOWERCASE_A + DIGIT_DELTA + UPPERCASE_DELTA;
        }
        return theValue;
    }
}