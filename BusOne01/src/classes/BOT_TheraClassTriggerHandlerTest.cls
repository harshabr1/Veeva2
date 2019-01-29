/*
Name            : BOT_TheraClassTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 25-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc. It is a test class of BOT_TheraClassTriggerHandler class.
*/
@isTest(seeAllData = false)
private class BOT_TheraClassTriggerHandlerTest 
{
    @testSetup static void createTestData()
    {
    	//To create the Account records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'Specialty Provider');
    }
    
    //Testing while creating a Thera class record
    static testMethod void createTheraClassRecord()
    {
       	Account objSpecialtyProvider;     //To store a Specilary provider Account record
        BOT_Thera_Class__c objTheraClass; //To store a Thera class record
        
        //To create a Thera class record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1, 'Specialty Provider');
        Test.startTest();
        clsTestDataFactory.createTheraClassWithSpecialtyId(1,1);
        Test.stopTest();
        
        //Querying the created test data
        objSpecialtyProvider = [SELECT Id FROM Account ORDER BY BOT_Entity_ID__c LIMIT 1];
        objTheraClass = [SELECT Id, BOT_Specialty_Provider__c FROM BOT_Thera_Class__c];
        
        //Test data validation
        System.assertEquals(objTheraClass.BOT_Specialty_Provider__c, objSpecialtyProvider.Id);
    }
    
    //To create a list of Thera class records
    static testMethod void createTheraClassRecords()
    {
       	List<Account> lstSpecialtyProvider;     //To store a list of Specilary provider Account records
        List<BOT_Thera_Class__c> lstTheraClass; //To store a list of Thera class records
        Integer i, j, temp = 0;
        
        //To create a list of Thera class records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(5, 'Specialty Provider');
        Test.startTest();
        clsTestDataFactory.createTheraClassWithSpecialtyId(5,5);
        Test.stopTest();
        
        //Querying the created test data
        lstSpecialtyProvider = [SELECT Id FROM Account ORDER BY BOT_Entity_ID__c];
        lstTheraClass = [SELECT Id, BOT_Specialty_Provider__c FROM BOT_Thera_Class__c ORDER BY BOT_Specialty_Provider_ID__c];
        
        //Test data validation
       	System.assertEquals(lstSpecialtyProvider.size(), 5);
        System.assertEquals(lstTheraClass.size(), 25);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
            {
	        	System.assertEquals(lstTheraClass[temp].BOT_Specialty_Provider__c, lstSpecialtyProvider[i].Id);
                temp++;
            }
        }
    }
    
    //Testing while creating a Thera class record without Specialty provider Id
    static testMethod void singleRecordNegativeScenario()
    {
       	//To create a Thera class record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();

        Test.startTest();
        try {
        	clsTestDataFactory.createTheraClassWithoutSpecialtyId(1,1);
        }
        catch(DMLException e) {
            System.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, '+
                                'Specialty provider Id field is mandatory to save the record: []', e.getMessage());
        }
        Test.stopTest();
    }
}