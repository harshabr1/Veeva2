/*
Name            : BOT_ChildAccountTriggerHandlerTest
Created By      : Sreenivasulu A
Created Date    : 05-DEC-2018
Overview        : This class is written by BusinessOne Technologies Inc. It is a test class for BOT_ChildAccountTriggerHandler class.
*/
@isTest(seeAllData = false)
class BOT_ChildAccountTriggerHandlerTest 
{
	//Testing while creating a single Child Account record
    static testMethod void createChildAccount()
    {
    	Account objAccount;						//To store an Account record
        Account objPersonAccount;				//To store a Person Account record
        Child_Account_vod__c objChildAccount;	//To store a Child Account record
        
        //To create a Person Account record
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1, 'MCO');
        clsTestDataFactory.createPersonAccountRecords(1);
       	Test.startTest();
        clsTestDataFactory.createChildAccountRecords(1,1);
        Test.stopTest();
        
        //Querying the created test data
       	objAccount = [SELECT Id from Account WHERE Account_Type__c = 'MCO'];
        objPersonAccount = [SELECT Id from Account WHERE Account_Type__c <> 'MCO'];
        objChildAccount = [SELECT Parent_Account_vod__c, Child_Account_vod__c FROM Child_Account_vod__c];
        
        //Test data validation
        System.assertEquals(objChildAccount.Child_Account_vod__c, objPersonAccount.Id);
        System.assertEquals(objChildAccount.Parent_Account_vod__c, objAccount.Id);
    }
    
    //Testing while creating a list of Child Account records
    static testMethod void createChildAccounts()
    {
    	List<Account> lstAccount;					//To store a list of Account records
        List<Account> lstPersonAccount;				//To store a list of Person Account records
        List<Child_Account_vod__c> lstChildAccount;	//To store a list of Child Account records
        Integer i, j, temp = 0;
        
        //To create a list of Person Account records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
       	clsTestDataFactory.createAccountRecords(5, 'MCO');
        clsTestDataFactory.createPersonAccountRecords(5);
       	Test.startTest();
        clsTestDataFactory.createChildAccountRecords(5,5);
        Test.stopTest();
        
        //Querying the created test data
       	lstAccount = [SELECT Id from Account WHERE Account_Type__c = 'MCO' ORDER BY BOT_Entity_Id__c];
        lstPersonAccount = [SELECT Id from Account WHERE Account_Type__c <> 'MCO' ORDER BY BOT_Entity_Id__c];
        lstChildAccount = [SELECT Parent_Account_vod__c, Child_Account_vod__c FROM Child_Account_vod__c ORDER BY BOT_Entity_Id__c, BOT_Personnel_ID__c];
        
        //Test data validation
        System.assertEquals(lstAccount.size(), 5);
        System.assertEquals(lstPersonAccount.size(), 5);
        System.assertEquals(lstChildAccount.size(), 25);
        for(i = 0; i < 5; i++)
        {
            for(j = 0; j < 5; j++)
            {
            	System.assertEquals(lstChildAccount[temp].Child_Account_vod__c, lstPersonAccount[j].Id);
        		System.assertEquals(lstChildAccount[temp].Parent_Account_vod__c, lstAccount[i].Id);
                temp++;
            }
        }
    }
}