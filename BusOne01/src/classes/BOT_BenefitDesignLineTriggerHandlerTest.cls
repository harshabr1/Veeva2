/*
Name            : BOT_BenefitDesignLineTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 20-sep-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is a test class of BOT_BenefitDesignLineTriggerHandler class.
*/
@isTest(seeAllData=false)
private class BOT_BenefitDesignLineTriggerHandlerTest 
{
    @testSetup static void createTestData()
    {
    	//To create the Account, Benefit design and Fromulary product records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'Employer');
        clsTestDataFactory.createBenefitDesignRecords(1,5,'Employer');
        clsTestDataFactory.createFormularyProductRecords(5);   
    }
    //Testing while creating a Benefit design Line record
    static testMethod void createBenefitDesignLineRecord()
    {
        Benefit_Design_vod__c objBenefitDesign;           		//To store a Benefit design record
        Formulary_Products_vod__c objFormularyProduct;    		//To store a Formulary product record
        Benefit_Design_Line_vod__c objBenefitDesignLine;		//To store a Benefit design line record
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine;	//To store a return data from test data factory class.
        
        //To create a Benefit design Line record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1,'Employer');
        //clsTestDataFactory.createBenefitDesignRecords(1,1,'Employer');
        //clsTestDataFactory.createFormularyProductRecords(1);
        lstBenefitDesignLine = clsTestDataFactory.createBenefitDesignLineRecords(1,1);
        Test.startTest();
        insert lstBenefitDesignLine;
        Test.stopTest();
        
        //Querying the created test data
        objBenefitDesign = [SELECT Id FROM Benefit_Design_vod__c ORDER BY BOT_Benefit_Design_ID__c LIMIT 1];
        objFormularyProduct = [SELECT Id FROM Formulary_Products_vod__c ORDER BY BOT_Formulary_Product_ID__c LIMIT 1];
        objBenefitDesignLine = [SELECT Id, Benefit_Design_vod__c, Product_vod__c FROM Benefit_Design_Line_vod__c];        
        
        //Test data validation
        System.assertEquals([SELECT count() FROM Account], 1);
        System.assertEquals(objBenefitDesignLine.Benefit_Design_vod__c, objBenefitDesign.Id);
        System.assertEquals(objBenefitDesignLine.Product_vod__c, objFormularyProduct.Id);
	}
    
    //Testing while creating a list of Benefit design Line records
    static testMethod void createBenefitDesignLineRecords()
    {
        List<Benefit_Design_vod__c> lstBenefitDesign;           //To store list of Benefit design records
        List<Formulary_Products_vod__c> lstFormularyProduct;    //To store list of Formulary product records
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine;  //To store list of Benefit design line records
        integer i, j, temp = 0;
        
        //To create a list of Benefit design Line records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1,'Employer');
        //clsTestDataFactory.createBenefitDesignRecords(1,5,'Employer');
        //clsTestDataFactory.createFormularyProductRecords(5);
        lstBenefitDesignLine = clsTestDataFactory.createBenefitDesignLineRecords(5,5);
        Test.startTest();
        insert lstBenefitDesignLine;
        Test.stopTest();
        
        //Querying the created test data
        lstBenefitDesign = [SELECT Id FROM Benefit_Design_vod__c ORDER BY BOT_Benefit_Design_ID__c];
        lstFormularyProduct = [SELECT Id FROM Formulary_Products_vod__c ORDER BY BOT_Formulary_Product_ID__c];
        lstBenefitDesignLine = [SELECT Id, Benefit_Design_vod__c, Product_vod__c FROM Benefit_Design_Line_vod__c ORDER BY BOT_Benefit_Design_ID__c,BOT_Formulary_Product_ID__c];        
        
        //Test data validation
        System.assertEquals(lstBenefitDesign.size(), 5);
        System.assertEquals(lstFormularyProduct.size(), 5);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
            {
            	System.assertEquals(lstBenefitDesignLine[temp].Benefit_Design_vod__c, lstBenefitDesign[i].Id);
        		System.assertEquals(lstBenefitDesignLine[temp].Product_vod__c, lstFormularyProduct[j].Id);
                temp++;
            }
        }
	}
    
    //Testing while creating a Benefit design Line record with out Formulary Product Id
    static testMethod void singleRecordNegativeScenario()
    {	
    	List<Benefit_Design_Line_vod__c> lstBenefitDesignLine;	//To store a return data from test data factory class.
        
        //To create a Benefit design Line record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        lstBenefitDesignLine = clsTestDataFactory.benefitDesignLineWithoutFormularyProductId(1,1);
        
        Test.startTest();
        try {
        	insert lstBenefitDesignLine;    
        }
        catch(DMLException e) {
            System.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, '+
                                'Benefit Design Id and Formulary Product Id fields are mandatory for BOT records: []', e.getMessage());
        }
        Test.stopTest();
    }
}