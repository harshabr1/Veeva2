/*
Name            : BOT_PharmacyServicesTrigger
Created By      : Sreenivasulu A
Created Date    : 07-SEP-2018
Overview        : it is implemented by BusinessOne Technologies Inc. It is used to populate the SFDC Entity ID by comparing BOT Entity ID.
				  It also creates junction object records (Account to PBM linking) on child account object.
*/

trigger BOT_PharmacyServicesTrigger on BOT_Pharmacy_Service__c (before insert, after insert) 
{
    //To populate the SFDC Entity ID by comparing BOT Entity ID.
    if(Trigger.isInsert && Trigger.isBefore)
    {
    	Set<Integer> setBOTAccountIds = new Set<Integer>();			//To store the BOT Entity IDs
       	List<BOT_Pharmacy_Service__c> lstPharmacyServices = new List<BOT_Pharmacy_Service__c>();	//To store the list of pharmacy service records
        
    	//Creating set of BOT entity Ids and PBM Ids
    	for(BOT_Pharmacy_Service__c objPharmacyService : Trigger.new)
    	{
    		if(objPharmacyService.BOT_Entity_ID__c != Null)
        	{
        		setBOTAccountIds.add(Integer.valueOf(objPharmacyService.BOT_Entity_ID__c));
                lstPharmacyServices.add(objPharmacyService);
            }
            else
            {
                objPharmacyService.addError('Entity Id field is mandatory to save the record');
            }
            if(objPharmacyService.BOT_PBM_ID__c != Null)
            {
            	setBOTAccountIds.add(Integer.valueOf(objPharmacyService.BOT_PBM_ID__c));
			}
		}
        
        //Calling a handler class method when the list is having at least 1 record.
        if(lstPharmacyServices.size() > 0)
        {
        	BOT_PharmacyServicesTriggerHandler.populateAccountAndPbmIds(lstPharmacyServices, setBOTAccountIds);     
        }
        
    }
    
    //To create junction object records (Account to PBM linking) on child account object.
    //Criteria is where Pharmacy service name equals to 'Formulary development/Admin'
    if(Trigger.isInsert && Trigger.isAfter)
    {
        List<BOT_Pharmacy_Service__c> lstPharmacyServices = new List<BOT_Pharmacy_Service__c>();	//To store a list of Pharmacy Services records
    	for(BOT_Pharmacy_Service__c objPharmacyServices : Trigger.new)
    	{
        	if(objPharmacyServices.name == 'Formulary development/Admin' && objPharmacyServices.BOT_Account__c != null && objPharmacyServices.BOT_PBM_Name__c != null)
        	{
        		//Creating a list of valid records
                lstPharmacyServices.add(objPharmacyServices);   
        	}
        }
    	
        //Calling a handler class method when the list is having at least 1 record.
        if(lstPharmacyServices.size() > 0)
    	{
        	BOT_PharmacyServicesTriggerHandler.createChildAccounts(lstPharmacyServices); 
    	}
    }
}