/*
Name			: BOT_PlanProductTriggerHandler
Created By		: Sreenivasulu A
Created Date	: 14-AUG-2018
Overview		: This class is written by BusinessOne Technologies Inc. It is helper class of BOT_PlanProductTrigger trigger.
				  1. It is used to handle the name where having morethan 80 characters.
				  2. It updates the BOT_Account__c field dynamically.

Modified By 	:Harsha BR
Modified date 	:12-SEP-2018
Reason 			:Added comments and modified the code to follow the salesforce standard best practices.

Modified by		: Sreenivasulu A
Modified date	: 09-OCT-2018
Reason			: Added data update functionility. It updates the BOT_Account__c field and BOT_Medical_Admin__c field when the record is created or updated.
*/
public with sharing class BOT_PlanProductTriggerHandler 
{
    //When record is created
    public static void manageNameAndPopulateAccountId(List<BOT_Plan_Product__c> lstPlanProducts, Set<Integer> setEntityIds)
    {
        Map<Integer, ID> mapAccountIds = new Map<Integer,ID>();				//To store BOT Entity Ids and SFDC Ids of Account object
        
        //To Retrieve SFDC Account Id by comparing BOT Entity Id and put in a map
        for(Account objAccount : [SELECT Id, BOT_Entity_ID__c FROM Account WHERE BOT_Entity_ID__c in : setEntityIds])
        {
            mapAccountIds.put(Integer.valueOf(objAccount.BOT_Entity_ID__c), objAccount.Id);
        }
		
        for(BOT_Plan_Product__c objPlanProduct : lstPlanProducts)
        {
            //Updating BOT_Account__c field 
            objPlanProduct.BOT_Account__c = mapAccountIds.get(Integer.valueOf(objPlanProduct.BOT_Entity_ID__c));
            
            //To handle name field
            if(objPlanProduct.BOT_Product_Name__c != Null )
            {
                if(objPlanProduct.BOT_Product_Name__c.length() < 78)
            	{
            	    //Copying the Product name to Name field where no of characters lessthan 78
                    objPlanProduct.Name = objPlanProduct.BOT_Product_Name__c;
            	}
                else
                {
                    //To truncate and copy the Product name to Name field where no of characters greater than or equal to 78
                    objPlanProduct.Name = objPlanProduct.BOT_Product_Name__c.subString(0,77) + '...';
                }
            }
        }
    }
    
    //When related Medical Admin Id is updated
    public static void updateMedicalAdminIds(List<BOT_Plan_Product__c> lstPlanProducts, set<Integer> setMedicalAdminIds)
    {
        Map<Integer, ID> mapAccountIds = new Map<Integer,ID>();				//To store BOT Entity Ids and SFDC Account Ids of Account object

        //To Retrieve SFDC Account Id by comparing BOT Entity Id and put in map
        for(Account objAccount : [SELECT Id, BOT_Entity_ID__c FROM Account WHERE BOT_Entity_ID__c in : setMedicalAdminIds])
        {
            mapAccountIds.put(Integer.valueOf(objAccount.BOT_Entity_ID__c), objAccount.Id);
        }
		
        for(BOT_Plan_Product__c objPlanProduct : lstPlanProducts)
        {
            //Updating BOT_Medical_Admin__c field
            objPlanProduct.BOT_Medical_Admin__c = mapAccountIds.get(Integer.valueOf(objPlanProduct.BOT_Medical_Admin_ID__c));
        }   
    }
}