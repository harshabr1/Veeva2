/*
Name            : BOT_AccountTrigger
Created By      : Sreenivasulu A
Created Date    : 05-SEP-2018
Overview        : This trigger is written by BusinessOne Technologies Inc. It is used to update Record type Ids by the Account type (channel) and
                  update the salesforce parent Ids for the affiliated plans.                 
*/
trigger BOT_AccountTrigger on Account (before insert) 
{
    if(Trigger.isInsert || Trigger.isBefore)
    {
        List<Account> lstAccounts = new List<Account>();		//To store the list of Accounts where Entity Id and Account type not Null
        
        for(Account objAccount : Trigger.new)
        {
            //To verify record belongs to BOT or not
            if(objAccount.BOT_Is_BOT_Data__c == true)
            {
                //Validating the required field values 
            	if(objAccount.BOT_Entity_ID__c != null && String.isNotBlank(objAccount.Account_Type__c))
            	{
                	//Creating a list of valid records
                    lstAccounts.add(objAccount);
            	}
                else
                {
                    objAccount.addError('Entity Id and Account type fields are mandatory for BOT records');
                }
            }
        }
        
        //Calling a handler class method when the list is having at least 1 record.
        if(lstAccounts.size() > 0 && lstAccounts != null)
        {
        	BOT_AccountTriggerHandler.updateRecordtypeAndParentIDs(lstAccounts);   
        }
    }
    
    /*
    if(Trigger.isInsert || Trigger.isAfter)
    {
    	//BOT_AccountTriggerHandler.updateIdnIds();
		BOT_AccountTriggerHandler.updateParentIDs();
    }
	*/
}