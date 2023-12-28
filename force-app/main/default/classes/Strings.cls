/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Utility class for strings
*/

public with sharing class Strings {

    public static String denullify(String theString) {
        return theString == null ? '' : theString;
    }
}