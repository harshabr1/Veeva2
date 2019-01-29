/*
Name            : BOT_PlanProductTrigger
Created By      : Sreenivasulu A
Created Date    : 14-AUG-2018
Overview        : This trigger is written by BusinessOne Technologies Inc. 
                  1. It is used to truncate the name of the plan product if the characters are more than 80.
                  2. It populate the related SFDC Account ID into BOT_Account__c filed by comparing BOT_Entity_ID__c.

Modified by     : Sreenivasulu A
Modified date   : 09-OCT-2018
Reason          : Added update functionility. To update the BOT_Account__c field and BOT_Medical_Admin__c field when the record is created or updated.
*/
trigger BOT_PlanProductTrigger on BOT_Plan_Product__c (before insert, before update) 
{
    if(Trigger.isBefore && Trigger.isInsert)
    {
        Set<Integer> setEntityIds = new Set<Integer>();                     //To store Account BOT Entity Ids
        Set<Integer> setMedicalAdminIds = new Set<Integer>();               //To store Account BOT Medical Admin Ids
        List<BOT_Plan_Product__c> lstPlanProductWithEntityId = new List<BOT_Plan_Product__c>();     //To store a list of plan product records with BOT Entity ID
        List<BOT_Plan_Product__c> lstPlanProductWithMedicalAdminId = new List<BOT_Plan_Product__c>();   //To store a list of plan product records with BOT Medical Admin ID
        
        for(BOT_Plan_Product__c objPlanProduct : Trigger.new)
        {
            //Validating the BOT_Entity_ID__c field value
            if(objPlanProduct.BOT_Entity_ID__c != null && objPlanProduct.BOT_Product_ID__c != null)
            {
                lstPlanProductWithEntityId.add(objPlanProduct);
                setEntityIds.add(Integer.valueOf(objPlanProduct.BOT_Entity_ID__c));                
            }
            else
            {
                objPlanProduct.addError('Entity ID and Plan Product ID field is required to save the record');
            }
            
            //Validating the BOT_Medical_Admin_ID__c field value
            if(objPlanProduct.BOT_Medical_Admin_ID__c != null)
            {
                lstPlanProductWithMedicalAdminId.add(objPlanProduct);
                setMedicalAdminIds.add(Integer.valueOf(objPlanProduct.BOT_Medical_Admin_ID__c));
            }
        }
        
        //Calling a handler class method to populate SFDC Account ID when the list is having at least 1 record.
        if(lstPlanProductWithEntityId.size() > 0)
        {
            BOT_PlanProductTriggerHandler.manageNameAndPopulateAccountId(lstPlanProductWithEntityId,setEntityIds);    
        }
        
        //Calling a handler class method to populate SFDC Medical Admin ID when the list is having at least 1 record.
        if(lstPlanProductWithMedicalAdminId.size() > 0)
        {
            BOT_PlanProductTriggerHandler.updateMedicalAdminIds(lstPlanProductWithMedicalAdminId,setMedicalAdminIds);    
        }
    }
    
    else if(Trigger.isBefore && Trigger.isUpdate)
    {
        Set<Integer> setMedicalAdminIds = new Set<Integer>();               //To store Account BOT Medical Admin Ids
        List<BOT_Plan_Product__c> lstPlanProductWithUpdatedMedicalAdminId = new List<BOT_Plan_Product__c>();    //To store a list of plan product records where Medical Admin ID is updated
        Integer planProductCount;                                           //To store total number of plan products getting updated
        Integer temp;                                                       //Temporary variable used to iterate the for loop
        
        planProductCount = Trigger.new.size();
        for(temp = 0; temp < planProductCount; temp++)
        {
            //To check where Entity Id is updated
            if(Trigger.new[temp].BOT_Medical_Admin_ID__c != null)
            {
                //To check where Medical Admin Id is updated
                if(Trigger.old[temp].BOT_Medical_Admin_ID__c != Trigger.new[temp].BOT_Medical_Admin_ID__c)
                {
                    //Creating a set of BOT Medical Admin Ids
                    setMedicalAdminIds.add(Integer.valueOf(Trigger.new[temp].BOT_Medical_Admin_ID__c));
                    //Creating a list of plan product records where Medical Admin ID is updated
                    lstPlanProductWithUpdatedMedicalAdminId.add(Trigger.new[temp]);
                }
            }
        }
        if(setMedicalAdminIds != Null)
        {
            BOT_PlanProductTriggerHandler.updateMedicalAdminIds(lstPlanProductWithUpdatedMedicalAdminId,setMedicalAdminIds);   
        }
    }
}