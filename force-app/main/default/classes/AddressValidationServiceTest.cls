@istest
public class AddressValidationServiceTest {
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        // Implement the mock HTTP response
        public HTTPResponse respond(HTTPRequest req) {
            // Create a new HTTPResponse object
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/xml');
            res.setBody('<?xml version="1.0" encoding="UTF-8"?>\n<AddressValidateResponse>\n<Address ID="0">\n<Address1>STE K</Address1>\n<Address2>29851 AVENTURA</Address2>\n<City>RANCHO SANTA MARGARITA</City>\n<CityAbbreviation>RCHO STA MARG</CityAbbreviation>\n<State>CA</State>\n<Zip5>92688</Zip5>\n<Zip4>2014</Zip4>\n<DeliveryPoint>83</DeliveryPoint>\n<CarrierRoute>C057</CarrierRoute>\n<Footnotes>N</Footnotes>\n<DPVConfirmation>Y</DPVConfirmation>\n<DPVCMRA>N</DPVCMRA>\n<DPVFootnotes>AABB</DPVFootnotes>\n<Business>Y</Business>\n<CentralDeliveryPoint>N</CentralDeliveryPoint>\n<Vacant>N</Vacant>\n</Address>\n</AddressValidateResponse>');
            res.setStatus('OK');
            return res;
        }
    }
    
    @isTest
    static void createAcccount(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Account acc = (Account)TestDataFactory.createSObject('Account',new Map<String,Object> {
            'Name' => 'test',
                'Description' => 'test',
                'BillingStreet' => '123 main street',
                'BillingCity' => 'nyc',
                'BillingState' => 'Florida',
                'BillingPostalCode' => '1235',
                'BillingCountry' =>'United States'
                },true);
        
        Account accObj = [Select id,name from account];
        System.assertEquals(accObj.name,'test');
        System.assertEquals(accObj.id,acc.id);
        Test.stopTest();
        List<UspsAddressValidationAction.Request>reqLst = new List<UspsAddressValidationAction.Request>();
        UspsAddressValidationAction.Request req = new UspsAddressValidationAction.Request();
        req.city = 'test Cty';
        req.id = accObj.Id;
        req.state = 'CA';
        req.street = 'test street';
        req.zipCode = '12312';
        req.firmName = accObj.Name;
        reqLst.add(req);
        List<UspsAddressValidationAction.Result>resLst = UspsAddressValidationAction.validateAddresses(reqLst);
        
    }
    
    @isTest
    static void createAccountBulk(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<Account> accList = TestDataFactory.createSObjectList('Account',new Map<String,Object> {
            'Name' => 'test',
                'Description' => 'test',
                'Description' => 'test',
                'BillingStreet' => '123 main street',
                'BillingCity' => 'nyc',
                'BillingState' => 'Florida',
                'BillingPostalCode' => '1235',
                'BillingCountry' =>'United States'
                },2);
        
        List<Account> accountList = [select id from Account];
        System.assertEquals(accList.size(),accountList.size());
        
        Test.stopTest();
        
    }
    @isTest
    static void deleteAcccount(){
        Test.startTest();
        Account acc = (Account)TestDataFactory.createSObject('Account',new Map<String,Object> {
            'Name' => 'test',
                'Description' => 'test',
                'BillingStreet' => '123 main street',
                'BillingCity' => 'nyc',
                'BillingState' => 'Florida',
                'BillingPostalCode' => '1235',
                'BillingCountry' =>'United States'
                },true);
        
        Account accObj = [Select id,name from account];
        System.assertEquals(accObj.name,'test');
        System.assertEquals(accObj.id,acc.id);
        update accObj;
        delete accObj;
        undelete accObj;
        Test.stopTest();
         
    }
    
}