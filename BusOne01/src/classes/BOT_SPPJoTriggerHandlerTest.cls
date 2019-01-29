/*
Name            : BOT_SPPJoTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 25-SEP-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is a test class for BOT_SpecialtyProviderJoTriggerHandler class.
*/
@isTest(seeAllData=false)
private class BOT_SPPJoTriggerHandlerTest 
{
    @testSetup static void createTestData()
    {
    	//To create the Account records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'MCO');
		clsTestDataFactory.createAccountRecords(5,'Specialty Provider');        
    }
    
    //Testing while creating a Specialty provider JO Record
    static testMethod void createSpecialtyProviderJORecord()
    {
    	Account objAccount;                                         //To store an Account record
        Account objSpecialtyprovider;								//To store a specialty provider Account
        BOT_Specialty_Provider_JO__c objSpecialtyProviderJO;        //To store a Junction object record
        
        //To create a Specialty Provider to Account Junction object record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1, 'MCO');
        Test.startTest();
        clsTestDataFactory.createSPPToAccountRecords(1,1);
        Test.stopTest();
        
        //Querying the created test data
        objAccount = [SELECT Id FROM Account WHERE Account_type__c = 'MCO' ORDER BY BOT_Entity_ID__c LIMIT 1];
        objSpecialtyprovider = [SELECT Id FROM Account WHERE Account_type__c = 'Specialty Provider' ORDER BY BOT_Entity_ID__c LIMIT 1];
        objSpecialtyProviderJO = [SELECT Id, BOT_Account__c, BOT_Specialty_Provider__c FROM BOT_Specialty_Provider_JO__c];
        
        //Test data validation
        System.assert(objAccount != null);
        System.assert(objSpecialtyprovider != null);
        System.assertEquals(objSpecialtyProviderJO.BOT_Account__c, objAccount.Id);
        System.assertEquals(objSpecialtyProviderJO.BOT_Specialty_Provider__c, objSpecialtyprovider.Id);
    }
    
    //Testing while creating a list of Specialty provider JO Records
    static testMethod void createSpecialtyProviderJORecords()
    {
    	List<Account> lstAccount;                                   //To store a list of Account records
        List<Account> lstSpecialtyprovider;							//To store a list of specialty provider Account records
        List<BOT_Specialty_Provider_JO__c> lstSpecialtyProviderJO;  //To store a list of Junction object records
        Integer i, j, temp = 0;
        
        //To create a list of Specialty Provider to Account Junction object records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(5, 'MCO');
        Test.startTest();
        clsTestDataFactory.createSPPToAccountRecords(5, 5);
        Test.stopTest();
        
        //Querying the created test data
        lstAccount = [SELECT Id FROM Account WHERE Account_type__c = 'MCO' ORDER BY BOT_Entity_ID__c];
        lstSpecialtyprovider = [SELECT Id FROM Account WHERE Account_type__c = 'Specialty Provider' ORDER BY BOT_Entity_ID__c];
        lstSpecialtyProviderJO = [SELECT Id, BOT_Account__c, BOT_Specialty_Provider__c FROM BOT_Specialty_Provider_JO__c ORDER BY BOT_Entity_ID__c];
        
        //Test data validation
        System.assertEquals(lstAccount.size(), 5);
        System.assertEquals(lstSpecialtyprovider.size(), 5);
        System.assertEquals(lstSpecialtyProviderJO.size(), 25);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
            {
        		System.assertEquals(lstSpecialtyProviderJO[temp].BOT_Account__c, lstAccount[i].Id);
        		System.assertEquals(lstSpecialtyProviderJO[temp].BOT_Specialty_Provider__c, lstSpecialtyprovider[j].Id);
                temp++;
            }
        }
    }
    
    //Testing while creating a Specialty provider JO Record without Entity Id
    static testMethod void singleRecordNegativeScenario()
    {
    	//To create a Specialty Provider to Account Junction object record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        
        Test.startTest();
        try {
        	clsTestDataFactory.createSPPToAccountWithoutEntityID(1,1);
        }
        catch(DMLException e) {
            System.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, '+
                                'Entity Id and Specialty provider ID fields are mandatory to save the record: []', e.getMessage());
        }
        Test.stopTest();
    }
}