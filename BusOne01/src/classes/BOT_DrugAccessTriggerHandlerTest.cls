/*
Name            : BOT_DrugAccessTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 21-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is a test class of BOT_DrugAccessTriggerHandler class.
*/
@isTest(seeAllData=false)
private class BOT_DrugAccessTriggerHandlerTest 
{
    @testSetup static void createTestData()
    {
    	//To create the Account and Fromulary product records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'Employer');
        clsTestDataFactory.createFormularyProductRecords(5);   
    }
    
    //Testing while creating a single Drug Access record
    static testMethod void createDrugAccessRecord()
    {
        Account objAccount;                                 //To store an Account record with commercial channel       
        Formulary_Products_vod__c objFormularyProduct;      //To store a formulary product record
        BOT_Drug_Access__c objDrugAccess;                   //To store a drug access record
        List<BOT_Drug_Access__c> lstDrugAccess;             //To store a list of drug access records
        
        //To create a Drug access record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1, 'MCO');
        //clsTestDataFactory.createFormularyProductRecords(1);
        lstDrugAccess = clsTestDataFactory.createDrugAccessRecords(1, 1);
        Test.startTest();
        insert lstDrugAccess;
        Test.stopTest();
        
        //Querying the created test data
        objAccount = [SELECT Id FROM Account ORDER BY BOT_Entity_Id__c LIMIT 1];
        objFormularyProduct = [SELECT Id, Market_vod__c FROM Formulary_products_vod__c ORDER BY BOT_Formulary_Product_ID__c LIMIT 1];
        objDrugAccess = [SELECT Id, Name, BOT_Account__c, BOT_Formulary_Product__c FROM BOT_Drug_Access__c];
        
        //Test data validation
        System.assert(objAccount != null);
        System.assert(objFormularyProduct != null);
        System.assertEquals(objDrugAccess.Name,objFormularyProduct.Market_vod__c);
        System.assertEquals(objDrugAccess.BOT_Account__c, objAccount.Id);
        System.assertEquals(objDrugAccess.BOT_Formulary_Product__c, objFormularyProduct.Id);
    }
    
    //Testing while creating a list of Drug Access records
    static testMethod void createDrugAccessRecords()
    {
        List<Account> lstAccount;                           	//To store a list of Account records
        List<Formulary_Products_vod__c> lstFormularyProduct;    //To store a list of formulary product records
        List<BOT_Drug_Access__c> lstDrugAccess;                 //To store a list of drug access records
        Integer i, j, temp = 0;
        
        //To create a list of Drug access records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(5, 'MCO');
        //clsTestDataFactory.createFormularyProductRecords(5);
        lstDrugAccess = clsTestDataFactory.createDrugAccessRecords(5, 5);
        Test.startTest();
        insert lstDrugAccess;
        Test.stopTest();
        
        //Querying the created test data
        lstAccount = [SELECT Id FROM Account ORDER BY BOT_Entity_Id__c];
        lstFormularyProduct = [SELECT Id, Market_vod__c FROM Formulary_products_vod__c ORDER BY BOT_Formulary_Product_ID__c];
        lstDrugAccess = [SELECT Id, Name, BOT_Account__c, BOT_Formulary_Product__c FROM BOT_Drug_Access__c ORDER BY BOT_Entity_Id__c];
        
        //Test data validation
        System.assertEquals(lstAccount.size(), 5);
        System.assertEquals(lstFormularyProduct.size(), 5);
        System.assertEquals(lstDrugAccess.size(), 25);
        for(i = 0; i < 5; i++)
        {
        	for(j = 0; j < 5; j++)
            {
            	System.assertEquals(lstDrugAccess[temp].BOT_Account__c, lstAccount[i].Id);
                System.assertEquals(lstDrugAccess[temp].BOT_Formulary_Product__c, lstFormularyProduct[j].Id);    
                System.assertEquals(lstDrugAccess[temp].Name,lstFormularyProduct[j].Market_vod__c);
                temp++;
            }
        }
    }
    
    //Testing while creating a Drug access record with out Entity Id
    static testMethod void singleRecordNegativeScenario()
    {	
    	List<BOT_Drug_Access__c> lstDrugAccess;                 //To store a list of drug access records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        
        lstDrugAccess = clsTestDataFactory.createDrugAccessWithoutEntityID(1,1);
        
        Test.startTest();
        try {
        	insert lstDrugAccess;    
        }
        catch(DMLException e) {
            System.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, '+
                                'Entity Id and Formulary Product Id fields are required to save the record: []', e.getMessage());
        }
        Test.stopTest();
    }    
}