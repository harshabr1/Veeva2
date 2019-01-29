/*
Name            : BOT_AccountPlanDrugAccess_Extn_Test
Created by      : Sreenivasulu Adipudi
Created date    : 18-DEC-2018
Description     : This class is created by BusinessOneTechnologies Inc.
				  It is a test class for BOT_AccountPlanDrugAccess_Extn class.
*/
@isTest
class BOT_AccountPlanDrugAccess_Extn_Test 
{
	//Testing BOT_AccountPlanDrugAccess_Extn standard controller class
    static testMethod void AccountPlanDrugAccess_Extn()
    {
    	List<Account_Plan_vod__c> lstAccountPlans;	//To store the list of Account Plan records
        List<BOT_Drug_Access__c> lstDrugAccess;		//To store list of Drug access records
        Id accountId;								//To store Account Id of selected Account plan
        
        //To create Drug access records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        clsTestDataFactory.createFormularyProductRecords(5);
        lstDrugAccess = clsTestDataFactory.createDrugAccessRecords(1, 5);
        insert lstDrugAccess;
        
        accountId = [SELECT Id FROM Account].Id;
        //To create an Account plan with associated Account Id
        lstAccountPlans = clsTestDataFactory.createAccountPlanRecords(accountId, 1);
        insert lstAccountPlans;
        
        Test.startTest();
        //Creating an instance for AccountPlanDrugAccess controller class
        ApexPages.StandardController controller = new ApexPages.StandardController(lstAccountPlans[0]);
        BOT_AccountPlanDrugAccess_Extn clsAccountPlanDrugAccess = new BOT_AccountPlanDrugAccess_Extn(controller);
        
        System.assertEquals(clsAccountPlanDrugAccess.getDynamicList().size(), 6);
        
        //Calling marketFilterRetrieve method with selected market as 'Market 1'
        clsAccountPlanDrugAccess.selectedMarket = 'Test Market 1';
        clsAccountPlanDrugAccess.marketFilterRetrieve();
        
        //Calling marketFilterRetrieve method with selected market as 'ALL'
        clsAccountPlanDrugAccess.selectedMarket = 'ALL';
        clsAccountPlanDrugAccess.marketFilterRetrieve();
        Test.stopTest();
    }
}