/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for Strings
*/

@isTest(isParallel=true)
private with sharing class StringsTest {

    @isTest private static void denullifyWithNullString() {
        Assert.areEqual(
            '', 
            Strings.denullify(null),
            'Denullifying a null string should return an empty string.');
    }

    @isTest private static void denullifyWithEmptyString() {
        Assert.areEqual(
            '', 
            Strings.denullify(''),
            'Denullifying an empty string should return an empty string.');
    }

    @isTest private static void denullifyWithNonemptyString() {
        Assert.areEqual(
            'A trivial string', 
            Strings.denullify('A trivial string'),
            'Denullifying an nonempty string should return the string itself.');
    }

}