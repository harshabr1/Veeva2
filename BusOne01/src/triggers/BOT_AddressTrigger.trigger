/*
Name            : BOT_AddressTrigger
Created By      : Sreenivasulu A
Created Date    : 06-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is used to populate the SFDC Account ID by comparing BOT Entity ID and Record Type ID.

Modified By     :Harsha BR
Modified date   :14-SEP-2018
Reason          :Added comments and modified the code to follow the salesforce standard best practices.
*/
trigger BOT_AddressTrigger on Address_vod__c (before insert) 
{
    if(Trigger.isBefore && Trigger.isInsert)
    {
        List<Address_vod__c> lstAddress = new List<Address_vod__c>();	//To store a list of Address records
        Set<Integer> setAccountIds = new Set<Integer>();				//To store unique BOT Entity Ids
        
        for(Address_vod__c objAddress : Trigger.new)
        {
            //Validating the required field values 
            if(objAddress.BOT_Entity_ID__c != null)
            {
                setAccountIds.add(Integer.valueOf(objAddress.BOT_Entity_ID__c));
                //Creating a list of valid records
                lstAddress.add(objAddress);
            }
        }
        
        //Calling a handler class method when the list is having at least 1 record.
        if(lstAddress.size() > 0)
        {
        	BOT_AddressTriggerHandler.populateAccountId(lstAddress, setAccountIds);  
        }
	}
}