/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Mock of the USPS Address Validation API that returns a well formatted response
*/

@isTest
public with sharing class UspsAddressValidationApiMock implements HttpCalloutMock{

    public HttpResponse respond(HttpRequest theRequest) {

        Assert.isTrue(
            theRequest.getEndpoint().startsWith(Parameter__mdt.getInstance('UspsAddressValidationApiUrl').Value__c),
            'The request should be sent to the API URL defined in the parameters.'
        );

        Assert.areEqual(
            'POST',
            theRequest.getMethod(),
            'The request should be sent using a POST call.'
        );

        HttpResponse theResponse = new HttpResponse();

        theResponse.setStatus('OK');
        theResponse.setStatusCode(200);

        theResponse.setBody(UspsAddressValidationResultTest.SAMPLE_RESPONSE);

        theResponse.setHeader('Server', 'Microsoft-IIS/10.0');
        theResponse.setHeader('Access-Control-Allow-Origin', '*');
        theResponse.setHeader('X-Backside-Transport', 'OK OK');
        theResponse.setHeader('x-ruleset-version', '1.0');
        theResponse.setHeader('X-Global-Transaction-ID', 'e41d61746545589a70ae0551');
        theResponse.setHeader('X-FRAME-OPTIONS', 'SAMEORIGIN');
        theResponse.setHeader('Date', 'Fri, 03 Nov 2023 20:31:07 GMT');
        theResponse.setHeader('Strict-Transport-Security', 'max-age=31536000 ; includeSubDomains');
        theResponse.setHeader('Cache-Control', 'private');
        theResponse.setHeader('X-AspNet-Version', '4.0.30319');
        theResponse.setHeader('Content-Length', '579');
        theResponse.setHeader('X-Powered-By', 'ASP.NET');
        theResponse.setHeader('Content-Type', 'text/xml');

        return theResponse;
    }
}