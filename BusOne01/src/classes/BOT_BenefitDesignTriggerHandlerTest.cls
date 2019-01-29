/*
Name            : BOT_BenefitDesignTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 19-SEP-2018
Overview        : This class is writtern by BusinessOne Technologies Inc. It is a test class for BOT_BenefitDesignTriggerHandler class.
*/
@isTest(seeAllData=false)
private class BOT_BenefitDesignTriggerHandlerTest 
{
    @testSetup static void createTestData()
    {
    	//To create the Account records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'MCO');        
    }
    //Testing while creating a Benefit design record with Medicare channel and name morethan 80 characters
    static testMethod void createBenefitDesignWithMedicareChannel()
    {
    	Account objAccount;							//To store an Account record
        Benefit_Design_vod__c objBenefitDesign;		//To store a Benefit design record
        
        //To create a benefit design record with Medicare channel and name morethan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1,'Medicare');
        clsTestDataFactory.createBenefitDesignRecords(1,1,'Medicare');
        
        //Querying the created test data
        objAccount = [SELECT Id FROM Account ORDER BY BOT_Entity_Id__c LIMIT 1];
        objBenefitDesign = [SELECT id, Name, Account_vod__c FROM Benefit_Design_vod__c];
        
        //Test data validation
        System.assertEquals(objBenefitDesign.Name, 'BOT Test Formulary Name where name is morethan 80 Characters BOT Te.. - Medicare');
        System.assertEquals(objBenefitDesign.Account_vod__c, objAccount.Id);
    }
    
    //Testing while creating a Benefit design record with Employer channel and name lessthan 80 characters
    static testMethod void createBenefitDesignWithEmployerChannel()
    {
    	Account objAccount;							//To store an Account record
        Benefit_Design_vod__c objBenefitDesign;		//To store a Benefit design record
        
        //To create a benefit design record with Employer channel and name lessthan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1,'Employer');
        clsTestDataFactory.createBenefitDesignRecords(1,1,'Employer');
        
        //Querying the created test data
        objAccount = [SELECT id FROM Account ORDER BY BOT_Entity_Id__c LIMIT 1];
        objBenefitDesign = [SELECT id, Name, Account_vod__c FROM Benefit_Design_vod__c];
        
        //Test data validation
        System.assertEquals(objBenefitDesign.Name, 'BOT Test Formulary Name 0 - Employer');
        System.assertEquals(objBenefitDesign.Account_vod__c, objAccount.Id);        
    }
    
    //Testing while creating a list of Benefit design records with Medicare channel and name morethan 80 characters
    static testMethod void createBenefitDesignsWithMedicareChannel()
    {
        //To create a benefit design record with Medicare channel and name morethan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(5,'Medicare');
        clsTestDataFactory.createBenefitDesignRecords(5,5,'Medicare');
        
        //Test data validation
        System.assertEquals([SELECT count() FROM Account], 5);
        System.assertEquals([SELECT count() FROM Benefit_Design_vod__c WHERE name = 'BOT Test Formulary Name where name is morethan 80 Characters BOT Te.. - Medicare'], 25);
        
        //To verify the number of Benefit design records created for each Account
        for(AggregateResult res : [SELECT count(Id) sum FROM Benefit_Design_vod__c GROUP BY Account_vod__c])
        {
            System.assertEquals(res.get('sum'), 5);
        }
    }
    
    //Testing while creating a list of Benefit design records with Employer channel and name lessthan 80 characters
    static testMethod void createBenefitDesignsWithEmployerChannel()
    {
        List<Benefit_Design_vod__c> lstBenefitDesign;	//To store a list of Benefit design records
        Integer temp;									//Temporary variable used to iterate the loop
        
        //To create a benefit design record with Employer channel and name lessthan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(5,'Employer');
        clsTestDataFactory.createBenefitDesignRecords(5,5,'Employer');
        
        //Querying the created test data
        lstBenefitDesign = [SELECT id, Name FROM Benefit_Design_vod__c ORDER BY Account_vod__c];
        
        //Test data validation
        System.assertEquals([SELECT count() FROM Account], 5);
        System.assertEquals(lstBenefitDesign.size(), 25);
        for(temp = 0; temp < 25; temp++)
        {
            System.assertEquals(lstBenefitDesign[temp].Name, 'BOT Test Formulary Name '+ temp +' - Employer');
        }
        
        //To verify the number of Benefit design records created for each Account
        for(AggregateResult res : [SELECT count(Id) sum FROM Benefit_Design_vod__c GROUP BY Account_vod__c])
        {
            System.assertEquals(res.get('sum'), 5);
        }
    }
    
    //Testing while creating a Benefit design record without Entity Id
    static testMethod void singleRecordNegativeScenario()
    {
    	Account objAccount;								//To store an Account record
        Benefit_Design_vod__c objBenefitDesign;			//To store a Benefit design record
        List<Benefit_Design_vod__c> lstBenefitDesign;	//To store a list of Benefit design records
        
        //To create a benefit design record with Medicare channel and name morethan 80 charcters
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1,'Medicare');
        lstBenefitDesign = clsTestDataFactory.benefitDesignRecordsWithoutEntityID(1,1);
        
        Test.startTest();
        try {
        	insert lstBenefitDesign;    
        }
        catch(DMLException e) {
            System.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, '+
                                'Entity ID and Benefit Design Id fields are mandatory for BOT records: []', e.getMessage());
        }
        Test.stopTest();
    }
}