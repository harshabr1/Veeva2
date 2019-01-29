/*
Name            : BOT_AddressTriggerHandler
Created By      : Sreenivasulu A
Created Date    : 06-SEP-2018
Overview        : it is implemented by BusinessOne Technologies Inc.1.	It is used to populate the SFDC Entity ID by using BOT Entity ID.

Modified By 	:Harsha BR
Modified date 	:14-SEP-2018
Reason 			:Added comments and modified the code to follow the salesforce standard best practices.
*/
public with sharing class BOT_AddressTriggerHandler 
{
	public static void populateAccountId(List<Address_vod__c> lstAddress, Set<Integer> setAccountIds)
    {
    	Map<Integer, Id> mapAccountIds = new Map<Integer, Id>();	//Map of BOT Entity Ids and associated SFDC Account IDs
        //To get the BOT Address record type ID
        Id BOTAddressRecordTypeId = Schema.SObjectType.Address_vod__c.getRecordTypeInfosByName().get('BOT Address').getRecordTypeId();
        
        //To retrieve SFDC Account Ids by comparing BOT Entity Ids
        for(Account objAccount : [SELECT Id, BOT_Entity_Id__c FROM Account WHERE BOT_Entity_Id__c in : setAccountIds LIMIT 50000])
        {
        	mapAccountIds.put(Integer.valueOf(objAccount.BOT_Entity_Id__c), objAccount.Id); 
        }
        
        //Updating BOT_Entity_ID__c field and RecordType ID
        for(Address_vod__c objAddress : lstAddress)
        {
        	objAddress.Account_vod__c = mapAccountIds.get(Integer.valueOf(objAddress.BOT_Entity_ID__c));
            objAddress.RecordTypeId = BOTAddressRecordTypeId;
        }
    }
}