/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for UspsFootnote
*/

@isTest(isParallel=true)
private with sharing class UspsFootnoteTest {

    @isTest private static void fromStringWithTwoCharacters() {
        List<UspsFootnote> footnotes = UspsFootnote.fromString('AN');

        Assert.areEqual(2, footnotes.size(), 'When called with a string with two different characters, the method fromString() should return two footnotes.');

        Assert.areEqual(UspsFootnote.byCode.get('A'), footnotes[0], 'When called with a string in which the first character is A, the method fromString() should return a list in which the first element is the corresponding footnote.');
        Assert.areEqual(UspsFootnote.byCode.get('N'), footnotes[1], 'When called with a string in which the second character is N, the method fromString() should return a list in which the second element is the corresponding footnote.');
    }

}