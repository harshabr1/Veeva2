/*
Name            : BOT_PharmacyServicesTriggerHandler
Created By      : Sreenivasulu A
Created Date    : 07-SEP-2018
Overview        : it is implemented by BusinessOne Technologies Inc.It is used to populate the SFDC Entity ID by using BOT Entity ID.

Modified By   : Harsha BR
Modified Date : 14-SEP-2018
Reason        : To move the business logic to the Apex class and to follow the naming conventions.
*/

public with sharing class BOT_PharmacyServicesTriggerHandler 
{
	public static void populateAccountAndPbmIds(List<BOT_Pharmacy_Service__c> lstPharmacyServices, Set<Integer> setBOTAccountIds)
    {
        Map<Integer, Id> mapAccountIds = new Map<Integer, Id>();	//To store the map of BOT Entity ID and Salesforce account ID
        
    	//Retrieving SFDC Account Id by comparing BOT Entity Id or BOT PBM Id 
        for(Account objAccount : [SELECT Id, BOT_Entity_Id__c FROM Account WHERE BOT_Entity_Id__c in : setBOTAccountIds])
        {
        	mapAccountIds.put(Integer.valueOf(objAccount.BOT_Entity_Id__c), objAccount.Id);   
        }
        
        //Updating BOT_Account__c and BOT_PBM_Name__c fileds
        for(BOT_Pharmacy_Service__c objPharmacyService : lstPharmacyServices)
        {
        	objPharmacyService.BOT_Account__c = mapAccountIds.get(Integer.valueOf(objPharmacyService.BOT_Entity_ID__c));
            
            if(objPharmacyService.BOT_PBM_ID__c != Null)
            {
            	objPharmacyService.BOT_PBM_Name__c = mapAccountIds.get(Integer.valueOf(objPharmacyService.BOT_PBM_ID__c));
            }
        }
    }
    
    //To create child account records with PBM ID as Parent and Account ID as Child(For view Hierarchy functionality)
    public static void createChildAccounts(List<BOT_Pharmacy_Service__c> lstPharmacyServices)
    {
    	List<Child_Account_vod__c> lstChildAccount = new List<Child_Account_vod__c>();
       
       	for(BOT_Pharmacy_Service__c objPharmacyServices : lstPharmacyServices)
        {
        	lstChildAccount.add(new Child_Account_vod__c(Parent_Account_vod__c = objPharmacyServices.BOT_PBM_Name__c, Child_Account_vod__c = objPharmacyServices.BOT_Account__c));    
        }
        if(lstChildAccount.size() > 0)
        {
        	Database.insert(lstChildAccount, false);    
        }
    }
    
    //To delete child account record associated with current pharmacy service records
	public static void deleteChildAccounts(List<BOT_Pharmacy_Service__c> lstPharmacyServices)
    {
    	Set<Integer> setBOTAccountIds = new Set<Integer>();			//To store the BOT Entity IDs
        Set<Integer> setPBMAccountIds = new Set<Integer>();			//To store the BOT PBM Entity IDs
        List<Id> lstSFDCAccountIds = new List<Id>();
        List<Id> lstSFDCPBMAccountIds = new List<Id>();
        List<Child_Account_vod__c> lstChildAccount = new List<Child_Account_vod__c>();
        
    	//Creating set of BOT entity Ids and PBM Ids
    	for(BOT_Pharmacy_Service__c objPharmacyService : lstPharmacyServices)
        {
        	setBOTAccountIds.add(Integer.valueOf(objPharmacyService.BOT_Entity_ID__c));
            setPBMAccountIds.add(Integer.valueOf(objPharmacyService.BOT_PBM_ID__c));
        }
    	
        for(AggregateResult res : [select Count(Id), BOT_Account__c, BOT_PBM_Name__c 
                                   from BOT_Pharmacy_Service__c group by BOT_Account__c, BOT_PBM_Name__c, BOT_Entity_ID__c, BOT_PBM_ID__c, name 
                                   having BOT_Entity_ID__c in : setBOTAccountIds and BOT_PBM_ID__c in : setPBMAccountIds and name = 'Formulary development/Admin'])
        {
            if(Integer.valueOf(res.get('Count')) == 1)
            {
            	lstSFDCAccountIds.add('BOT_Account__c');
                lstSFDCPBMAccountIds.add('BOT_PBM_Name__c');
            }
        }
        lstChildAccount = [select Id from Child_Account_vod__c where Parent_Account_vod__c in : lstSFDCPBMAccountIds and Child_Account_vod__c in : lstSFDCPBMAccountIds];
        if(lstChildAccount.size() > 0)
        {
            delete lstChildAccount;
        }
    }
}