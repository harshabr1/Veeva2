/*
Name			: BOT_Mass_Delete_Controller
Created By		: Sreenivasulu A
Created Date	: 09-JAN-2019
Overview		: This class is written by BusinessOne Technologies Inc. It is a controller class for BOT_Mass_Delete Page.
*/
public class BOT_Mass_Delete_Controller {
    
    Integer recordCount = 0;
    //Public Integer accountCount {get;set;}
    Public Integer planProductCount {get;set;}
    Public Integer benefitDesignCount {get;set;}
    Public Integer pharmacyServiceCount {get;set;}
    Public Integer specialtyProviderJOCount {get;set;}
    Public Integer drugAccessCount {get;set;}
    Public Integer theraClassCount {get;set;}
    Public Integer productFormularyCount {get;set;}
    String queryString;
    ID batchJobID;
    //Public Integer coveragePolicyCount {get;set;}
    
    public BOT_Mass_Delete_Controller() {
    	//accountCount = [SELECT count() FROM Account WHERE BOT_Is_BOT_Data__c = true];
        planProductCount = [SELECT count() FROM BOT_Plan_Product__c];
        benefitDesignCount = [SELECT count() FROM Benefit_Design_vod__c WHERE BOT_Is_BOT_Data__c = true];
        pharmacyServiceCount = [SELECT count() FROM BOT_Pharmacy_Service__c];
        specialtyProviderJOCount = [SELECT count() FROM BOT_Specialty_Provider_JO__c];
        drugAccessCount = [SELECT count() FROM BOT_Drug_Access__c];
        theraClassCount = [SELECT count() FROM BOT_Thera_Class__c];
        productFormularyCount = [SELECT Count() FROM BOT_Product_Formulary_JO__c];
        //coveragePolicyCount = [SELECT count() FROM BOT_Coverage_Policy__c];
    }
    
    /*
    public void deleteAccounts() {
        try {
            recordCount = [SELECT count() FROM Account WHERE BOT_Is_BOT_Data__c = true];
            
			if(recordCount > 0)
        	{
                delete [SELECT Id FROM Account WHERE Account_Type__c NOT IN ('IDN','ACO','Hospital') AND BOT_Is_BOT_Data__c = true LIMIT 10000];
                
                if(recordCount > 10000)
                {
                    accountCount = recordCount-10000;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, '10,000 Account records are deleted successfully.\nPlease Click on \'Delete Account\' button to Delete Remaining'));
                }
                else
                {
                    accountCount = 0;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, recordCount +' Account records are deleted successfully'));    
                }
        	}
        }
        catch(System.NullPointerException e) {}
    }
	*/
    /*
    public void deleteBenefitDesign() {
        try{
            recordCount = [SELECT count() FROM Benefit_Design_vod__c WHERE BOT_Is_BOT_Data__c = true];
            
            if(recordCount > 0)
        	{
                delete [SELECT Id FROM Benefit_Design_vod__c WHERE BOT_Is_BOT_Data__c = true LIMIT 10000];
                
                if(recordCount > 10000)
                {
                    benefitDesignCount = recordCount - 10000;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, '10,000 Benefit Design records are deleted successfully.\nPlease Click on \'Delete Benefit Design\' button to Delete Remaining'));
                }
                else
                {
                    benefitDesignCount = 0;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, recordCount +' Benefit Design records are deleted successfully'));    
                }
        	}
        	
        	else 
            {
            	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Benefit Design records not found'));
        	}
        }
        catch(System.NullPointerException e) {}
    }
    */
    
    public void deleteBenefitDesign() {
        try {
            recordCount = [SELECT count() FROM Benefit_Design_vod__c WHERE BOT_Is_BOT_Data__c = true];
        }
        catch(System.NullPointerException e) {}
        
        if(recordCount > 0)
        {
        	queryString = 'SELECT Id FROM Benefit_Design_vod__c WHERE BOT_Is_BOT_Data__c = true';
            BOT_MassDeleteBatch clsMassDeleteBatch = new BOT_MassDeleteBatch(queryString);
            Database.executeBatch(clsMassDeleteBatch);
			ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Benefit Design Records Processed, it may take couple of Minutes to complete'));
        }
    }
    
    /*
    public void deletePharmacyService() {
        try {
            recordCount = [SELECT count() FROM BOT_Pharmacy_Service__c];
            
            if(recordCount > 0)
        	{
                delete [SELECT Id FROM BOT_Pharmacy_Service__c LIMIT 10000];
                
                if(recordCount > 10000)
                {
                    pharmacyServiceCount = recordCount - 10000;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, '10,000 Pharmacy Service records are deleted successfully.\nPlease Click on \'Delete Pharmacy Service\' button to Delete Remaining'));
                }
                else
                {
                    pharmacyServiceCount = 0;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, recordCount +' Pharmacy Service records are deleted successfully'));    
                }
        	}
            
        	else 
            {
            	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Pharmacy Service records not found'));
       		}  
        }
        catch(System.NullPointerException e) {}
    }
    */
    public void deletePharmacyService() {
        try {
            recordCount = [SELECT count() FROM BOT_Pharmacy_Service__c];        	            	
        }
        catch(System.NullPointerException e) {}
        
        if(recordCount > 0)
        {
        	queryString = 'SELECT Id FROM BOT_Pharmacy_Service__c';
            BOT_MassDeleteBatch clsMassDeleteBatch = new BOT_MassDeleteBatch(queryString);
            Database.executeBatch(clsMassDeleteBatch);
			ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Pharmacy Service Records Processed, it may take couple of Minutes to complete'));
        }
	}
    
    /*
    public void deleteSpecialtyProviderJO() {
         try {
             recordCount = [SELECT count() FROM BOT_Specialty_Provider_JO__c];
        	 
            if(recordCount > 0)
        	{
                delete [SELECT Id FROM BOT_Specialty_Provider_JO__c LIMIT 10000];
                
                if(recordCount > 10000)
                {
                    specialtyProviderJOCount = recordCount - 10000;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, '10,000 Specialty Provider JO records are deleted successfully.\nPlease Click on \'Delete Specialty Provider JO\' button to Delete Remaining'));
                }
                else
                {
                    specialtyProviderJOCount = 0;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, recordCount +' Specialty Provider JO records are deleted successfully'));    
                }
        	}
            
        	else 
            {
            	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Specialty Providers JO records not found'));
            }
         }
         catch(System.NullPointerException e) {}
    }
	*/
    
    public void deleteSpecialtyProviderJO() {
        try {
            recordCount = [SELECT count() FROM BOT_Specialty_Provider_JO__c];        	            	
        }
        catch(System.NullPointerException e) {}
        
        if(recordCount > 0)
        {
        	queryString = 'SELECT Id FROM BOT_Specialty_Provider_JO__c';
            BOT_MassDeleteBatch clsMassDeleteBatch = new BOT_MassDeleteBatch(queryString);
            Database.executeBatch(clsMassDeleteBatch);
			ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Specialty Provider JO Records Processed, it may take couple of Minutes to complete'));
        }
	}
    /*
    public void deleteCoveragePolicy() {
        try {
            recordCount = [SELECT count() FROM BOT_Coverage_Policy__c];
        	
            if(recordCount > 0)
        	{
                delete [SELECT Id FROM BOT_Coverage_Policy__c LIMIT 10000];
                
                if(recordCount > 10000)
                {
                    coveragePolicyCount = recordCount - 10000;
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, '10,000 Coverage Policy records are deleted successfully.\nPlease Click on \'Delete Coverage Policy\' button to Delete Remaining'));
                }
                else
                {
                    coveragePolicyCount = 0;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, recordCount +' Coverage Policy records are deleted successfully'));    
                }
        	}
            
            else 
            {
            	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Coverage Policy records not found'));
        	}
        }
        catch(System.NullPointerException e) {}
    }
	*/
    /*
    public void deleteDrugAccess() {
        try {
            recordCount = [SELECT count() FROM BOT_Drug_Access__c];        	            	
        	
            if(recordCount > 0)
        	{
                delete [SELECT Id FROM BOT_Drug_Access__c LIMIT 10000];
        		
                if(recordCount > 10000)
                {
                    drugAccessCount = recordCount - 10000;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, '10,000 Drug Access records are deleted successfully.\nPlease Click on \'Delete Drug Access\' button to Delete Remaining'));
                }
                else
                {
                    drugAccessCount = 0;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, recordCount +' Drug Access records are deleted successfully'));
                }
        	}
            
        	else 
            {
        		ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Drug Access records not found'));
        	}
        }
        catch(System.NullPointerException e) {}
    }
    */
	    
	public void deleteDrugAccess() {
        try {
            recordCount = [SELECT count() FROM BOT_Drug_Access__c];        	            	
        }
        catch(System.NullPointerException e) {}
        
        if(recordCount > 0)
        {
        	queryString = 'SELECT Id FROM BOT_Drug_Access__c';
            BOT_MassDeleteBatch clsMassDeleteBatch = new BOT_MassDeleteBatch(queryString);
            Database.executeBatch(clsMassDeleteBatch);
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Drug Access Records Processed, it may take couple of Minutes to complete'));
        }
    }
    
    /*
    public void deleteTheraClass() {
        try {
            recordCount = [SELECT count() FROM BOT_Thera_Class__c];
            
            if(recordCount > 0)
        	{
                delete [SELECT Id FROM BOT_Thera_Class__c LIMIT 10000];
        		
                if(recordCount > 10000)
                {
                    theraClassCount = recordCount - 10000;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, '10,000 Thera Class records are deleted successfully.\nPlease Click on \'Delete Thera Class\' button to Delete Remaining'));
                }
                else
                {
                    theraClassCount = 0;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, recordCount +' Thera Class records are deleted successfully'));    
                }
        	}
            
            else 
            {
            	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Thera Class records not found'));
        	}
        }
        catch(System.NullPointerException e) {}
    }
	*/

    public void deleteTheraClass() {
        try {
            recordCount = [SELECT count() FROM BOT_Thera_Class__c];        	            	
        }
        catch(System.NullPointerException e) {}
        
        if(recordCount > 0)
        {
        	queryString = 'SELECT Id FROM BOT_Thera_Class__c';
            BOT_MassDeleteBatch clsMassDeleteBatch = new BOT_MassDeleteBatch(queryString);
            Database.executeBatch(clsMassDeleteBatch);
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Thera Class Records Processed, it may take couple of Minutes to complete'));
        }
    }
        
    /*
    public void deletePlanProduct() {
        try {
            recordCount = [SELECT count() FROM BOT_Plan_Product__c];
            
            if(recordCount > 0)
        	{
                delete [SELECT Id FROM BOT_Plan_Product__c LIMIT 10000];
                
                if(recordCount > 10000)
                {
                    planProductCount = recordCount - 10000;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, '10,000 Plan Product records are deleted successfully.\nPlease Click on the \'Delete Product\' record button to Delete Remaining'));
                }
                else
                {
                    planProductCount = 0;
                	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, recordCount +' Plan Product records are deleted successfully'));    
                }
        	}
            
        	else 
            {
            	ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Plan Product records not found'));
        	}
        }
        catch(System.NullPointerException e) {}
    }
	*/    
    
    public void deletePlanProduct() {
        try {
            recordCount = [SELECT count() FROM BOT_Plan_Product__c];        	            	
        }
        catch(System.NullPointerException e) {}
        
        if(recordCount > 0)
        {
        	queryString = 'SELECT Id FROM BOT_Plan_Product__c';
            BOT_MassDeleteBatch clsMassDeleteBatch = new BOT_MassDeleteBatch(queryString);
            Database.executeBatch(clsMassDeleteBatch);
			ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Plan Product Records Processed, it may take couple of Minutes to complete'));
        }
	}
    
    public void deleteProductFormulary() {
        try {
            recordCount = [SELECT count() FROM BOT_Product_Formulary_JO__c];        	            	
        }
        catch(System.NullPointerException e) {}
        
        if(recordCount > 0)
        {
        	queryString = 'SELECT Id FROM BOT_Product_Formulary_JO__c';
            BOT_MassDeleteBatch clsMassDeleteBatch = new BOT_MassDeleteBatch(queryString);
            Database.executeBatch(clsMassDeleteBatch);
			ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Product Formulary Records Processed, it may take couple of Minutes to complete'));
        }
    }
    
    public void deleteAll() {
    	deleteTheraClass();
        deleteDrugAccess();
        deleteSpecialtyProviderJO();
        deletePharmacyService();
        deleteBenefitDesign();
        deletePlanProduct();
    }
}