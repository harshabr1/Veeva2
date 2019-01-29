/*
Name            : BOT_AccountTriggerHandler
Created By      : Sreenivasulu A
Created Date    : 05-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is used to update the RecordType ID's and
                  parent Salesforce ID's on the Child accounts.

Modified By 	:Harsha BR
Modified date 	:12-SEP-2018
Reason 			:Added comments and modified the code to follow the salesforce standard best practices.
*/
public with sharing class BOT_AccountTriggerHandler 
{
    //Used to autopoplate the record type Id and SFDC Parent Id.
    public static void updateRecordtypeAndParentIDs(List<Account> lstAccounts)
    {
        Set<Integer> setEntityParentIds = new Set<Integer>();			//Used to store the BOT parent Entity ID's
        Map<String, Id> mapRecordtypeIds = new Map<String, Id>();		//Used to store the Record type name and its associated salesforce ID
        Map<Integer, Id> mapEntityParentIds = new Map<Integer, Id>();	//Used to store the BOT Entity ID and its associated salesforce ID
        
        //Creating a set of channels and a set of BOT Entity Ids
        for(Account objAccount : lstAccounts)
        {
            if(objAccount.BOT_Parent_Entity_ID__c != null)
            {
                setEntityParentIds.add(Integer.valueOf(objAccount.BOT_Parent_Entity_ID__c));
            }
        }
        
        //To Retrieve SFDC RecordTypeId by comparing Account, Channel and put in a map
        for(RecordType objRecordTypeId : [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Account' AND Name LIKE 'BOT%' LIMIT 50000])
        {
            mapRecordtypeIds.put(objRecordTypeId.Name, objRecordTypeId.Id);
        }
		
        if(setEntityParentIds != null)
        {
        	//To Retrieve SFDC Parent Id by comparing BOT parent Entity Id and put in a map
        	for(Account objAccount : [SELECT Id, BOT_Entity_Id__c FROM Account WHERE BOT_Entity_Id__c in : setEntityParentIds LIMIT 50000])
        	{
            	mapEntityParentIds.put(Integer.valueOf(objAccount.BOT_Entity_Id__c), objAccount.Id);
        	}
        }
       	//Updating appropriate reoctdTypeId by comparing the channel
        for(Account objAccount : lstAccounts)
        {             
            if(objAccount.Account_Type__c == 'Medicare' || objAccount.Account_Type__c == 'MCO' || objAccount.Account_Type__c == 'Stand-Alone Medicare' || objAccount.Account_Type__c == 'EGWP' || objAccount.Account_Type__c == 'Stand Alone Hix')
            {
                objAccount.RecordTypeId=mapRecordtypeIds.get('BOT Commercial');
                //objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('BOT Commercial').getRecordTypeId();
            }
            else
            {
                objAccount.RecordTypeId = mapRecordtypeIds.get('BOT '+objAccount.Account_Type__c);
                //objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('BOT '+objAccount.Account_Type__c).getRecordTypeId();
            }

            if(objAccount.BOT_Parent_Entity_ID__c != null)
            {
            	objAccount.ParentId = mapEntityParentIds.get(Integer.valueOf(objAccount.BOT_Parent_Entity_ID__c));
            	objAccount.Primary_Parent_vod__c = objAccount.ParentId;
            }
        }
    }
    
    /*
    public static void updateIdnIds()
    {
        List<Account> lstAccounts = new List<Account>();	//To store the list of Accounts where Account Type is ACO or Hospital
        lstAccounts = [SELECT Id, Account_Type__c, BOT_ACO_IDN__c, BOT_Hospital_IDN__c, ParentId FROM Account WHERE Account_Type__c IN ('ACO','HOSPITAL')];
        for(Account objAccount : lstAccounts)
        {
			if(objAccount.Account_Type__c == 'ACO')
            {
				objAccount.BOT_ACO_IDN__c = objAccount.ParentId;
            }
            else
            {
                objAccount.BOT_Hospital_IDN__c = objAccount.ParentId;
            }
        }
        update lstAccounts;
    }
    */
    
    //Used to populate the SFDC Parent Id's.
	public static void updateParentIDs()
    {
        Set<Integer> setEntityParentIds = new Set<Integer>();			//Used to store the BOT parent Entity ID's
        Map<Integer, Id> mapEntityParentIds = new Map<Integer, Id>();	//Used to store the BOT Entity ID and its associated salesforce ID
        List<Account> lstAccounts;										//Used to store the list of Accounts

		try{
			lstAccounts = [select Id, Primary_Parent_vod__c, BOT_Parent_Entity_ID__c from Account where BOT_Parent_Entity_ID__c != null and Primary_Parent_vod__c = null];
		}
        
        catch(Exception e){
			System.debug(e.getMessage());
		}
		
        if(lstAccounts.size() > 0)
        {
        //Creating a set of of BOT Parent Entity Ids
        for(Account objAccount : lstAccounts)
        {
            if(objAccount.BOT_Parent_Entity_ID__c != null)
            {
                setEntityParentIds.add(Integer.valueOf(objAccount.BOT_Parent_Entity_ID__c));
            }
        }
        
		try{
			//To Retrieve SFDC Parent Id by comparing BOT parent Entity Id and put it in the map
        	for(Account objAccount : [SELECT Id, BOT_Entity_Id__c FROM Account WHERE BOT_Entity_Id__c in : setEntityParentIds LIMIT 50000])
        	{
            	mapEntityParentIds.put(Integer.valueOf(objAccount.BOT_Entity_Id__c), objAccount.Id);
        	}
		}

		catch(Exception e){
			System.debug(e.getMessage());
		}
        
        //Updating appropriate SFDC Parent ID by comparing the BOT_Entity_Parent_ID__c
        for(Account objAccount : lstAccounts)
        {             
            objAccount.Primary_Parent_vod__c = mapEntityParentIds.get(Integer.valueOf(objAccount.BOT_Parent_Entity_ID__c));
        }
        update lstAccounts;
        }
    }
}