public with sharing class IdToNumericStringInvocable {
    public class Data{
        @InvocableVariable(
            label='Record ID' 
            description='Used to store the record Id' 
            required=true
        ) 
        public String id;
        @InvocableVariable(
            label='Numeric String' 
            description='Variable to store the generated response from Id value' 
            required=false
        )    
        public String numericString;
    }
    
    
    @InvocableMethod( label='Generate numric String from record id')
    public static List<Data> numericStringGenerator(List<Data>recodDataList){
        for(Data dataObj : recodDataList){
            SalesforceId theId = new SalesforceId(dataObj.id);
            dataObj.numericString = theId.numericString;
        }
        
        return recodDataList;
    }
}