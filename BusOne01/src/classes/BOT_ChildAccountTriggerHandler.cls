/*
Name            : BOT_ChildAccountTriggerHandler
Created By      : Sreenivasulu A
Created Date    : 05-DEC-2018
Overview        : This class is written by BusinessOne Technologies Inc. It is a helper class for BOT_ChildAccountTrigger.
*/
public with sharing class BOT_ChildAccountTriggerHandler 
{
	public static void updateAccountAndPersonAccountIds(List<Child_Account_vod__c> lstChildAccount, Set<Integer> setEntityIds)
    {
        Map<Integer, Id> mapAccountIds = new Map<Integer, Id>();	//To store BOT Entity Ids and SFDC Account Ids
        //Querying SFDC Account Ids by comparing BOT Entity Ids and put into a map
        for(Account objAccount : [SELECT Id, BOT_Entity_Id__c FROM Account WHERE BOT_Entity_Id__c IN : setEntityIds])
        {
            mapAccountIds.put(Integer.valueOf(objAccount.BOT_Entity_Id__c), objAccount.Id);
        }
        //Iterating child account and updae SFDC Parent Account Id and SFDC Child Account Ids
        for(Child_Account_vod__c objChildAccount : lstChildAccount)
        {
            objChildAccount.Parent_Account_vod__c = mapAccountIds.get(Integer.valueOf(objChildAccount.BOT_Entity_ID__c));
            objChildAccount.Child_Account_vod__c = mapAccountIds.get(Integer.valueOf(objChildAccount.BOT_Personnel_ID__c));
        }
    }
}