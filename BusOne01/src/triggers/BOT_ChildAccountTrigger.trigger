/*
Name            : BOT_ChildAccountTrigger
Created By      : Sreenivasulu A
Created Date    : 05-DEC-2018
Overview        : This trigger is written by BusinessOne Technologies Inc. It is used to pull the SFDC Account Id and SFDC Person Account ID (Contact ID)
				  from Account object and update in child Account object.
*/
trigger BOT_ChildAccountTrigger on Child_Account_vod__c (before insert) 
{
	List<Child_Account_vod__c> lstChildAccount = new List<Child_Account_vod__c>();	//To store a list of Child Accounts
    Set<Integer> setEntityIds = new Set<Integer>();									//To store unique BOT Account and BOT Person Account Ids
    for(Child_Account_vod__c objChildAccount : Trigger.new)
    {
        if(objChildAccount.BOT_Entity_ID__c != null && objChildAccount.BOT_Personnel_ID__c != null)
        {
        	//Creating a list of valid Child Account records
            lstChildAccount.add(objChildAccount);
            //Creating a set of BOT Entity and Person Account Ids
            setEntityIds.add(Integer.valueOf(objChildAccount.BOT_Entity_ID__c));
            setEntityIds.add(Integer.valueOf(objChildAccount.BOT_Personnel_ID__c));
        }        
    }
    
    //Calling helper class method where list have atleast one records 
    if(lstChildAccount.size() > 0 && lstChildAccount != null)
    {
    	BOT_ChildAccountTriggerHandler.updateAccountAndPersonAccountIds(lstChildAccount, setEntityIds);  
    }
}