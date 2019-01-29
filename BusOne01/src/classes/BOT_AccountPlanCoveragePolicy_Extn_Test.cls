/*
Name			: BOT_AccountPlanCoveragePolicy_Extn_Test
Created date	: 21-Dec-2018
Created by		: Sreenivasulu Adipudi
Description		: This class is created by BusinessOneTechnologies Inc.
				  It is a test class for BOT_AccountPlanCoveragePolicy_Extn class.
*/
@isTest
class BOT_AccountPlanCoveragePolicy_Extn_Test 
{
	//Testing BOT_AccountPlanCoveragePolicy_Extn standard controller class
    static testMethod void AccountPlanCoveragePolicy()
    {
        List<BOT_Coverage_Policy__c> lstCoveragePolicy;	//To store the list of coverage policy records
        Id accountId;									//To the SFDC Account Id
        List<Account_Plan_vod__c> lstAccountPlans;		//To store the list of Account Plan records
        
        //To create Coverage policy records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        accountId = [SELECT Id FROM Account LIMIT 1].Id;
        lstCoveragePolicy = clsTestDataFactory.createCoveragePolicyRecords(accountId, 5);
        insert lstCoveragePolicy;
        
        //To create an Account plan with associated Account Id
        lstAccountPlans = clsTestDataFactory.createAccountPlanRecords(accountId, 1);
        insert lstAccountPlans;
        
        Test.startTest();
        //Creating an instance for AccountPlanconveragepolicy Extension class
        ApexPages.StandardController controller = new ApexPages.StandardController(lstAccountPlans[0]);
        BOT_AccountPlanCoveragePolicy_Extn clsAccountPlanCoveragePolicy = new BOT_AccountPlanCoveragePolicy_Extn(controller);
        
        //Test data validation
        System.assertEquals(clsAccountPlanCoveragePolicy.getDynamicList().size(), 3);
        System.assertEquals(clsAccountPlanCoveragePolicy.lstCoveragePolicy.size(), 5);
        
        //Calling clsAccountPlanCoveragePolicy method with selected market as 'Immunology'
        clsAccountPlanCoveragePolicy.selectedMarket = 'Immunology';
        clsAccountPlanCoveragePolicy.getCoveragePolicy();
        System.assertEquals(clsAccountPlanCoveragePolicy.lstCoveragePolicy.size(), 5);
        
        //Calling clsAccountPlanCoveragePolicy method with selected market as 'ALL'
        clsAccountPlanCoveragePolicy.selectedMarket = 'ALL';
        clsAccountPlanCoveragePolicy.getCoveragePolicy();
        System.assertEquals(clsAccountPlanCoveragePolicy.lstCoveragePolicy.size(), 5);
        Test.stopTest();
    }
}