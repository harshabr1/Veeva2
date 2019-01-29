/*
Name            : BOT_ProductFormularyTrigger
Created by      : Sreenivasulu Adipudi
Created date    : 05-nov-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is used to populate the SFDC plan product Id and SFDC Benefit Design Id on Product formulary object.
*/
trigger BOT_ProductFormularyTrigger on BOT_Product_Formulary_JO__c (before insert) 
{
    if(Trigger.isBefore && Trigger.isInsert)
    {
        Set<Double> setPlanProductIds = new Set<Double>();          //To store a list of Plan products records
        Set<Double> setBenefitDesignIds = new Set<Double>();        //To store a list of Benefit design records
        List<BOT_Product_Formulary_JO__c> lstProductFormulary = new List<BOT_Product_Formulary_JO__c>();    //To store a list of Junction object records
        
        for(BOT_Product_Formulary_JO__c objProductFormulary : Trigger.new)
        {
            //Validating the required field values
            if(objProductFormulary.BOT_Plan_Product_ID__c != null && objProductFormulary.BOT_Benefit_Design_ID__c != null)
            {
                setPlanProductIds.add(objProductFormulary.BOT_Plan_Product_ID__c);
                setBenefitDesignIds.add(objProductFormulary.BOT_Benefit_Design_ID__c);
                //Creating a list of valid records
                lstProductFormulary.add(objProductFormulary);
            }
            else
            {
                objProductFormulary.addError('Product Id and Benefit design Id fields are mandatory');
            }
        }
        
        //Calling a handler class method when the list is having at least 1 record.
        if(lstProductFormulary.size() > 0)
        {
            BOT_ProductFormularyTriggerHandler.populateProductIdAndFormularyId(lstProductFormulary, setPlanProductIds, setBenefitDesignIds);    
        }
    }
}