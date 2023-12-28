public class TestUspsCallout {
    public static String parseSuggestion(String respBody){
        
        //Created subclass and Object to manage his address data structure
        Address objAddress = new Address();
        
        // added respBody.substringAfter('<Address1>').substringBefore('</Address1>') to parse data in single line
        // AC - Even better: could we replace all 9 instances of this with a method?
        
        if(respBody.containsIgnoreCase('<Address1>') && respBody.containsIgnoreCase('</Address1>')){
            objAddress.street = respBody.substringBefore('</Address1>').substringAfter('<Address1>');
        }
        if(respBody.containsIgnoreCase('<Address2>') && respBody.containsIgnoreCase('</Address2>')){
            objAddress.street  += '\r' + respBody.substringBefore('</Address2>').substringAfter('<Address2>');
        }
        if(respBody.containsIgnoreCase('<City>') && respBody.containsIgnoreCase('</City>')){
            objAddress.city = respBody.substringBefore('</City>').substringAfter('<City>');
        } 
        if(respBody.containsIgnoreCase('<State>') && respBody.containsIgnoreCase('</State>')){
            objAddress.State = respBody.substringBefore('</State>').substringAfter('<State>');
        } 
        
        if(respBody.containsIgnoreCase('<Zip5>') && respBody.containsIgnoreCase('</Zip5>')){
            objAddress.postalCode = respBody.substringBefore('</Zip5>').substringAfter('<Zip5>');
        } 
        
        
        //parse DeliveryPoint from response
        if(respBody.containsIgnoreCase('<DeliveryPoint>') && respBody.containsIgnoreCase('</DeliveryPoint>')){
            //objAddress.DeliveryPoint = respBody.substringBefore('</DeliveryPoint>').substringAfter('<DeliveryPoint>');
        }
        
        //parse DPVFootnotes from response
        if(respBody.containsIgnoreCase('<DPVFootnotes>') && respBody.containsIgnoreCase('</DPVFootnotes>')){
            //objAddress.DPVFootnotes = respBody.substringBefore('</DPVFootnotes>').substringAfter('<DPVFootnotes>');
        }
        //parse Error message from response
        if(respBody.containsIgnoreCase('<Error>') && respBody.containsIgnoreCase('</Error>')){
            //objAddress.ReturnText = respBody.substringBefore('</Description>').substringAfter('<Description>');
        }
        
        //parse ReturnText message from response
        if(respBody.containsIgnoreCase('<ReturnText>') && respBody.containsIgnoreCase('</ReturnText>')){
            //objAddress.ReturnText = respBody.substringBefore('</ReturnText>').substringAfter('<ReturnText>');
        }
        
        return JSON.serialize (objAddress);
    }
    
    
    /***
* Apex Wrapper Class to store Address
* ***/
    Public class Address{
        String street{get;set;}
        String city {get;set;}
        String state {get;set;}
        String postalCode {get;set;}
        String country {get;set;}
        
        //String DeliveryPoint {get;set;}
        //String ReturnText {get;set;}
        //String Footnotes {get;set;}
        //String DPVFootnotes {get;set;}
    }
    
    public static void doUspsValidation(String addressType,String street,String street2, String city, String state, String postalCOde){
        String userId = '94727DRLICO89';//{!$Credential.Username}';  //using named credentials throwing Authentication error
        String baseUrl = 'callout:Credential'; 
        
        
        // Construct the XML payload by passing address type as a Id (billing,shipping,personal)
        String xmlPayload = '<AddressValidateRequest USERID="'+userId+'"><Revision>1</Revision>';
        xmlPayload += '<Address ID="'+addressType+'">';
        
        //set Street
        if(String.isNotBlank(street)){
            xmlPayload += '<Address1>' + street + '</Address1>';
        }else{
            xmlPayload += '<Address1/>';
        }
        
        //set Street2
        if(String.isNotBlank(street2)){
            xmlPayload += '<Address2>' + street2 + '</Address2>';
        }else{
            xmlPayload += '<Address2/>';
        }
        
        //set city
        if(String.isNotBlank(city)){
            xmlPayload += '<City>' + city + '</City>';
        }else{
            xmlPayload += '<City/>';
        }
        
        //set State
        if(String.isNotBlank(state)){
            xmlPayload += '<State>' + state + '</State>';
        }else{
            xmlPayload += '<State/>';
        }        
        
        //set zip code
        if(String.isNotBlank(postalCOde)){
            xmlPayload += '<Zip5>' + postalCOde + '</Zip5>';
        }else{
            xmlPayload += '<Zip5/>';
        }        
        xmlPayload += '<Zip4/></Address></AddressValidateRequest>';
        
        // Define the endpoint URL
        String endpoint = baseUrl+'?API=Verify&XML=' + EncodingUtil.urlEncode(xmlPayload, 'UTF-8');
        //String endpoint = 'https://typedwebhook.tools/webhook/71169f51-9cc4-4da1-98c0-fd569939052d?API=Verify&XML=' + EncodingUtil.urlEncode(xmlPayload, 'UTF-8');
        
        // Set up the HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(120000); // Set timeout to 20 seconds
        System.debug('request '+req);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        String respBody = res.getBody();
        if(respBody.containsIgnoreCase('AddressValidateResponse')){
            String xmlResponse = respBody; 
            
            //split address by ids
            if(respBody.containsIgnoreCase('</Address>')){
                String billingAddressSuggestions = parseSuggestion( respBody);
                System.debug('== '+billingAddressSuggestions);
            }
        }
    }
    
}