/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Test class for UspsDpvFootnote
*/

@isTest(isParallel=true)
private with sharing class UspsDpvFootnoteTest {

    @isTest private static void fromStringWithTwoCharacters() {
        List<UspsDpvFootnote> footnotes = UspsDpvFootnote.fromString('AABB');

        Assert.areEqual(2, footnotes.size(), 'When called with a string with two different blocks of characters, the method fromString() should return two footnotes.');

        Assert.areEqual(UspsDpvFootnote.byCode.get('AA'), footnotes[0], 'When called with a string in which the first block is AA, the method fromString() should return a list in which the first element is the corresponding footnote.');
        Assert.areEqual(UspsDpvFootnote.byCode.get('BB'), footnotes[1], 'When called with a string in which the second block is BB, the method fromString() should return a list in which the second element is the corresponding footnote.');
    }
}