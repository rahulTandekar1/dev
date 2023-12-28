/**
* @author Andrés Catalán, Slalom
* @date 2023-11-08
* @description Represents a result returned by the USPS Address Validation API, which can be either a validated address or an error, and it contains all methods necessary to process the XML in the API's response
*/

public with sharing class UspsAddressValidationResult {

    public final String id;
    public final UspsValidatedAddress validatedAddress;
    public final UspsAddressValidationError error;


    public UspsAddressValidationResult(Map<String,String> resultData) {

        this.id = Strings.denullify(resultData.get('ID')?.trim());

        switch on resultData.get('Result') {
            when 'Validation' {
                error = null;
                validatedAddress = new UspsValidatedAddress(resultData);
            }
            when 'Error' {
                error = new UspsAddressValidationError(resultData);
                validatedAddress = null;
            }
        }
    }

    public static List<UspsAddressValidationResult> fromUspsXml(XmlStreamReader xmlReader) {

        List<UspsAddressValidationResult> results = new List<UspsAddressValidationResult>();

        advanceUntilNextStartTagNamed('Address', xmlReader);

        while (xmlReader.hasNext()) {
            results.add(new UspsAddressValidationResult(getAddressData(xmlReader)));
            advanceUntilNextStartTagNamed('Address', xmlReader);
        }

        return results;
    }

    private static void advanceUntilNextStartTagNamed(String tagName, XmlStreamReader xmlReader) {

        while (
            xmlReader.hasNext() && (
                xmlReader.getEventType() != XmlTag.START_ELEMENT 
                || xmlReader.getLocalName() != tagName
            )
        ) {
            xmlReader.next();
        }
    }

    private static Map<String,String> getAddressData(XmlStreamReader xmlReader) {

        Map<String,String> resultDataByField = new Map<String,String>();

        resultDataByField.put(
            xmlReader.getAttributeLocalName(0), 
            xmlReader.getAttributeValueAt(0)
        );
        
        xmlReader.next();

        if (XmlReader.getLocalName() == 'Error') {
            resultDataByField.put('Result', 'Error');
            if (xmlReader.hasNext()) {
                xmlReader.next();
            }
        } else {
            resultDataByField.put('Result', 'Validation');
        }
        while (xmlReader.hasNext()&& (
            xmlReader.getEventType() != XmlTag.START_ELEMENT 
            || xmlReader.getLocalName() != 'Address')
        ) {
            String fieldName = '';
            String value = '';

            if (xmlReader.getEventType() == XmlTag.START_ELEMENT) {
                
                fieldName = xmlReader.getLocalName();
                xmlReader.next();

                if (xmlReader.getEventType() == XmlTag.CHARACTERS) {
                    value = xmlReader.getText();
                    resultDataByField.put(fieldName, value);
                }
            }
            xmlReader.next();
        }

        return resultDataByField;
    }

}