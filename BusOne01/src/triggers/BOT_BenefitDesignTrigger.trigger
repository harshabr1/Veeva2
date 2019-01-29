/*
Name            : BOT_BenefitDesignTrigger
Created By      : Sreenivasulu A
Created Date    : 28-AUG-2018
Overview        : This trigger is written by BusinessOne Technologies Inc. 
                  1. It is used to truncate the name of the Benefit Design if the characters are more than 80 and Append the channel at the end of the name.
                  2. It also populate the related SFDC Account ID into BOT_Account__c filed by comparing BOT_Entity_ID__c.
*/
trigger BOT_BenefitDesignTrigger on Benefit_Design_vod__c (before insert, after insert, after update) 
{
    if(Trigger.isInsert && Trigger.isBefore)
    {
        List<Benefit_Design_vod__c> lstBenefitDesign = new List<Benefit_Design_vod__c>();
        Set<Integer> setAccountIds = new Set<Integer>();            //To store Account BOT Entity Ids
        
        for(Benefit_Design_vod__c objBenefitDesign : trigger.new)
        {
            //Verifying the incomimg record whether it is created by BOT or not
            if(objBenefitDesign.BOT_Is_BOT_Data__c == true)
            {
                //Creating set of BOT Entity Ids
                if(objBenefitDesign.BOT_Entity_ID__c != null && objBenefitDesign.BOT_Benefit_Design_ID__c != null)               
                {
                    setAccountIds.add(Integer.valueOf(objBenefitDesign.BOT_Entity_ID__c));       
                    lstBenefitDesign.add(objBenefitDesign);
                }
                else
                {
                    objBenefitDesign.addError('Entity ID and Benefit Design Id fields are mandatory for BOT records');
                }
            }
        }
        
        //Calling a handler class method when the list is having at least 1 record.
        if(lstBenefitDesign.size() > 0)
        {
            BOT_BenefitDesignTriggerHandler.manageNameAndPopulateAccountId(lstBenefitDesign, setAccountIds);
        }
    }
    
    //To update the total plan lives of associated formulary records on Account
    else if(Trigger.isAfter)
    {
        if(Trigger.isInsert || Trigger.isUpdate)
        {
            Set<Id> setAccountIds = new Set<Id>();            //To store SFDC Account Ids
            for(Benefit_Design_vod__c objBenefitDesign : trigger.new)
            {
                //Verifying the incomimg record whether it is created by BOT or not
                if(objBenefitDesign.BOT_Is_BOT_Data__c == true)
                {
                    //Creating set of BOT Entity Ids
                    if(objBenefitDesign.BOT_Entity_ID__c != null && objBenefitDesign.BOT_Benefit_Design_ID__c != null)               
                    {
                        setAccountIds.add(objBenefitDesign.Account_vod__c);
                    }
                }
            }
        
            //Calling a handler class method when the list is having at least 1 record.
            if(setAccountIds.size() > 0)
            {
                BOT_BenefitDesignTriggerHandler.updatePlanLivesOnAccount(setAccountIds);
            }
        }
    }
}