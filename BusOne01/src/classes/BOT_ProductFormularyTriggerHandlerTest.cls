/*
Name			: BOT_ProductFormularyTriggerHandlerTest
Created by		: Sreenivasulu Adipudi
Created date	: 05-nov-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is a test class for BOT_ProductFormularyTriggerHandler class.
*/
@isTest
class BOT_ProductFormularyTriggerHandlerTest 
{
    @testSetup static void createTestData()
    {
    	//To create the Account records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        clsTestDataFactory.createPlanProductRecords(1,5,'Commercial');
        clsTestDataFactory.createBenefitDesignRecords(1,5,'Commercial');
    }
    
    //Testing while creating a Product Formulary record
    static testMethod void createProductFormularyRecord()
    {
        BOT_Plan_Product__c objPlanProduct;						//To store a Plan product record
        Benefit_Design_vod__c objBenefitDesign;					//To store a Benefit design record
        BOT_Product_Formulary_JO__c objProductFormulary;		//To store a Product formulary record
        List<BOT_Product_Formulary_JO__c> lstProductFormulary;	//To store a list of Product formulary records
        
        //To create a Benefit design Line record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1,'MCO');
        //clsTestDataFactory.createPlanProductRecords(1,1,'Commercial');
        //clsTestDataFactory.createBenefitDesignRecords(1,1,'Commercial');
        lstProductFormulary = clsTestDataFactory.createProductFormularyRecords(1,1);
        Test.startTest();
        insert lstProductFormulary;
        Test.stopTest();
        
        //Querying the created test data
        objPlanProduct = [SELECT Id FROM BOT_Plan_Product__c ORDER BY BOT_Product_ID__c LIMIT 1];
        objBenefitDesign = [SELECT Id FROM Benefit_Design_vod__c ORDER BY BOT_Benefit_Design_ID__c LIMIT 1];
        objProductFormulary = [SELECT Id, BOT_Plan_Product__c, BOT_Benefit_Design__c FROM BOT_Product_Formulary_JO__c];
        
        //Test data validation
        System.assertEquals(objProductFormulary.BOT_Plan_Product__c , objPlanProduct.Id);
        System.assertEquals(objProductFormulary.BOT_Benefit_Design__c , objBenefitDesign.Id);
    }
    
    //Testing while creating a list of Product Formulary records
    static testMethod void createProductFormularyRecords()
    {
       	List<BOT_Plan_Product__c> lstPlanProduct;				//To store a list of Plan product records
        List<Benefit_Design_vod__c> lstBenefitDesign;			//To store a list of Benefit design records
        List<BOT_Product_Formulary_JO__c> lstProductFormulary;	//To store a list of Product formulary records
        Integer i, j, temp = 0;
        
        //To create a list of Benefit design Line records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1,'Employer');
        //clsTestDataFactory.createPlanProductRecords(1,5,'Employer');
        //clsTestDataFactory.createBenefitDesignRecords(1,5,'Employer');
        lstProductFormulary = clsTestDataFactory.createProductFormularyRecords(5,5);
        Test.startTest();
        insert lstProductFormulary;
        Test.stopTest();
        
        //Querying the created test data
        lstPlanProduct = [SELECT Id FROM BOT_Plan_Product__c ORDER BY BOT_Product_ID__c];
        lstBenefitDesign = [SELECT Id FROM Benefit_Design_vod__c ORDER BY BOT_Benefit_Design_ID__c];
        lstProductFormulary = [SELECT Id, BOT_Plan_Product__c, BOT_Benefit_Design__c FROM BOT_Product_Formulary_JO__c ORDER BY BOT_Plan_Product_ID__c];
        
        //Test data validation
        System.assertEquals(lstPlanProduct.size(), 5);
        System.assertEquals(lstBenefitDesign.size(), 5);
        System.assertEquals(lstProductFormulary.size(), 25);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
            {
                System.assertEquals(lstProductFormulary[temp].BOT_Plan_Product__c , lstPlanProduct[i].Id);
        		System.assertEquals(lstProductFormulary[temp].BOT_Benefit_Design__c , lstBenefitDesign[j].Id);
                temp++;
            }
        }
    }
    
    //Testing while creating a Product Formulary record without product Id 
    static testMethod void createProductFormularyWithoutPrdouctId()
    {
        List<BOT_Product_Formulary_JO__c> lstProductFormulary;	//To store a list of Product formulary records
        
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        
        lstProductFormulary = clsTestDataFactory.createProductFormularyWithoutProductId(1,1);
        
        Test.startTest();
        try {
        	insert lstProductFormulary;
        }
        catch(DMLException e) {
            System.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, '+
                                'Product Id and Benefit design Id fields are mandatory: []', e.getMessage());
        }
        Test.stopTest();
    }
}