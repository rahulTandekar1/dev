@isTest(isParallel=true)
private with sharing class SalesforceIdTest {

    private static final Id SAMPLE_ID = '0013C00000sIVB1QAO';

    @isTest private static void id() {
        Assert.areEqual(SAMPLE_ID, new SalesforceId(SAMPLE_ID).id, 'The attribute id should return the initialized value.');
    }

    @isTest private static void caseSensitiveCode() {
        Assert.areEqual('sIVB1', new SalesforceId(SAMPLE_ID).caseSensitiveCode, 'The attribute id should return the initialized value.');
    }

    @isTest private static void code() {
        Assert.areEqual('SIVB1QAO', new SalesforceId(SAMPLE_ID).code, 'The attribute id should return the initialized value.');
    }

    @isTest private static void valueOf() {
        string ALL_CHARACTERS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

        Assert.areEqual(62, ALL_CHARACTERS.length());

        Decimal previousValue = -1;

        for (Integer thisCharacter: ALL_CHARACTERS.getChars()) {
            Decimal thisValue = SalesforceId.valueOf(thisCharacter);
            Assert.areEqual(previousValue + 1, thisValue);
            previousValue = thisValue;
        }

        Assert.areEqual(61, previousValue);
    }

    @isTest private static void numericString1z() {
        SalesforceId theId = new SalesforceId('0013C000000000zQAO');
        Assert.areEqual('z', theId.caseSensitiveCode);
        Assert.areEqual('61', theId.numericString);
    }

    @isTest private static void numericString2z() {
        SalesforceId theId = new SalesforceId('0013C00000000zzQAO');
        Assert.areEqual('zz', theId.caseSensitiveCode);
        Assert.areEqual('3843', theId.numericString);
    }

    @isTest private static void numericString3z() {
        SalesforceId theId = new SalesforceId('0013C0000000zzzQAO');
        Assert.areEqual('zzz', theId.caseSensitiveCode);
        Assert.areEqual('238327', theId.numericString);
    }

    @isTest private static void numericString4z() {
        SalesforceId theId = new SalesforceId('0013C000000zzzzQAO');
        Assert.areEqual('zzzz', theId.caseSensitiveCode);
        Assert.areEqual('14776335', theId.numericString);
    }

    @isTest private static void numericString5z() {
        SalesforceId theId = new SalesforceId('0013C00000zzzzzQAO');
        Assert.areEqual('zzzzz', theId.caseSensitiveCode);
        Assert.areEqual('916132831', theId.numericString);
    }

    @isTest private static void numericString6z() {
        SalesforceId theId = new SalesforceId('0013C0000zzzzzzQAO');
        Assert.areEqual('zzzzzz', theId.caseSensitiveCode);
        Assert.areEqual('56800235583', theId.numericString);
    }

    @isTest private static void numericString7z() {
        SalesforceId theId = new SalesforceId('0013C000zzzzzzzQAO');
        Assert.areEqual('zzzzzzz', theId.caseSensitiveCode);
        Assert.areEqual('3521614606207', theId.numericString);
    }

    @isTest private static void numericString8z() {
        SalesforceId theId = new SalesforceId('0013C00zzzzzzzzQAO');
        Assert.areEqual('zzzzzzzz', theId.caseSensitiveCode);
        Assert.areEqual('218340105584895', theId.numericString);
    }
}