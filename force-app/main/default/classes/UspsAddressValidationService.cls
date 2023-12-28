/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Orchestrates everything necessary to call the USPS Address Validation API
*/

public with sharing class UspsAddressValidationService {

    // Source: https://www.usps.com/business/web-tools-apis/address-information-api.pdf (version 6.1)
    // "The Verify API supports up to five lookups per transaction." (page 3, section 2.1)
    final public static Integer MAX_ADDRESSES_PER_VALIDATION = 5;

    @testVisible final private static String ERROR_TOO_MANY_ADDRESSES = 'A call to the USPS Address Validation API cannot contain more than ' + MAX_ADDRESSES_PER_VALIDATION + ' addresses.';

    public class AddressValidationException extends Exception {}

    public static List<UspsAddressValidationResult> validate(List<UspsAddress> addresses) {

        String username = Parameter__mdt.getInstance('UspsWebToolsUsername').Value__c;
        String targetUrl = Parameter__mdt.getInstance('UspsAddressValidationApiUrl').Value__c;

        String payload = buildPayload(addresses, username);

        HttpRequest theRequest = new HttpRequest();
        theRequest.setEndpoint(targetUrl + EncodingUtil.urlEncode(payload,'UTF-8'));
        theRequest.setMethod('POST');

        HttpResponse theResponse = (new Http()).send(theRequest);

        return UspsAddressValidationResult.fromUspsXml(theResponse.getXmlStreamReader());
    }

    @testVisible private static String buildPayload(List<UspsAddress> addresses, String userId) {

        String thePayload = '';

        if (addresses == null || addresses.isEmpty()) {
            return thePayload;
        } else if (addresses.size() > MAX_ADDRESSES_PER_VALIDATION) {
            throw new AddressValidationException(ERROR_TOO_MANY_ADDRESSES);
        }

        thePayload += '<AddressValidateRequest USERID="' + userId + '"><Revision>1</Revision>';
        for (UspsAddress thisAddress : addresses) {
            thePayload += thisAddress.toUspsXml();
        }
        thePayload += '</AddressValidateRequest>';

        return thePayload;
    }
}