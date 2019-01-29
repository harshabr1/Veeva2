/*
Name            : BOT_AddressTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 20-SEP-2018
Overview        : it is implemented by BusinessOne Technologies Inc. It is a test class of BOT_AddressTriggerHandler class.
*/
@isTest(seeAllData=false)
private class BOT_AddressTriggerHandlerTest 
{
    @testSetup static void createTestData()
    {
    	//To create the Account records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(5,'MCO');
    }
    
    //Testing while creating an Address record
    static testMethod void createAddressRecord()
    {
        Account objAccount;                 //To store an Account record
        Address_vod__c objAddress;          //To store an Address record
        
        //To create an address record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(1,'MCO');
        Test.startTest();
        clsTestDataFactory.createAddressRecords(1,1);
        Test.stopTest();
        
        //Querying the created test data
        objAccount = [SELECT Id FROM Account ORDER BY BOT_Entity_Id__c LIMIT 1];
        objAddress = [SELECT Id, Account_vod__c, RecordTypeId FROM Address_vod__c];
       	
        //Test data validation
        System.assert(objAccount != null);
        System.assert(objAddress != null);
        System.assertEquals(objAddress.Account_vod__c , objAccount.Id);
        System.assertEquals(objAddress.RecordTypeId , Schema.SObjectType.Address_vod__c.getRecordTypeInfosByName().get('BOT Address').getRecordTypeId());
    }
    
    //Testing while creating a list of Address records
    static testMethod void createAddressRecords()
    {
        List<Account> lstAccount;           //To store a list of Account records
        List<Address_vod__c> lstAddress;   	//To store a list of Address records
        integer i, j, temp = 0;
        Id BOTAddressRecordTypeId = Schema.SObjectType.Address_vod__c.getRecordTypeInfosByName().get('BOT Address').getRecordTypeId();
        
        //To create a list of address records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        //clsTestDataFactory.createAccountRecords(5,'MCO');
        Test.startTest();
        clsTestDataFactory.createAddressRecords(5,1);
        Test.stopTest();
        
        //Querying the created test data
        lstAccount = [SELECT Id FROM Account ORDER BY BOT_Entity_Id__c];
        lstAddress = [SELECT Id, Account_vod__c, RecordTypeId FROM Address_vod__c ORDER By BOT_Entity_Id__c];
       	
        //Test data validation
        System.assertEquals(lstAccount.size(), 5);
        System.assertEquals(lstAddress.size(), 5);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 1; j++)
            {
            	System.assertEquals(lstAddress[temp].Account_vod__c , lstAccount[i].Id);
                System.assertEquals(lstAddress[temp].RecordTypeId , BOTAddressRecordTypeId);
                temp++;
			}
        }
    }
}