/*
Name			: BOT_AccountCoveragePolicy_Extn_Test
Created date	: 12/20/2018
Created by		: Sreenivasulu Adipudi
Description		: This class is written by BusinessOne Technologies Inc. It is a test class for BOT_AccountCoveragePolicy_Extn Visualforce page.
*/
@isTest
class BOT_AccountCoveragePolicy_Extn_Test 
{
	static testMethod void AccountCoveragePolicy()
    {
    	//Testing BOT_AccountCoveragePolicy_Extn standard controller class
        List<BOT_Coverage_Policy__c> lstCoveragePolicy;	//To store the list of coverage policy records
        Account objAccount;								//To an account record
        
        //To create Coverage policy records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        objAccount = [SELECT Id FROM Account LIMIT 1];
        lstCoveragePolicy = clsTestDataFactory.createCoveragePolicyRecords(objAccount.Id, 5);
        insert lstCoveragePolicy;
        
        Test.startTest();
        //Creating an instance for Account converage policy Extension class
        ApexPages.StandardController controller = new ApexPages.StandardController(objAccount);
        BOT_AccountCoveragePolicy_Extn clsAccountCoveragePolicy = new BOT_AccountCoveragePolicy_Extn(controller);
        
        //Test data validation
        System.assertEquals(clsAccountCoveragePolicy.getDynamicList().size(), 3);
        System.assertEquals(clsAccountCoveragePolicy.lstCoveragePolicy.size(), 5);
        
        //Calling clsAccountCoveragePolicy method with selected market as 'Immunology'
        clsAccountCoveragePolicy.selectedMarket = 'Immunology';
        clsAccountCoveragePolicy.getCoveragePolicy();
        System.assertEquals(clsAccountCoveragePolicy.lstCoveragePolicy.size(), 5);
        
        //Calling getCoveragePolicy method with selected market as 'ALL'
        clsAccountCoveragePolicy.selectedMarket = 'ALL';
        clsAccountCoveragePolicy.getCoveragePolicy();
        System.assertEquals(clsAccountCoveragePolicy.lstCoveragePolicy.size(), 5);
        Test.stopTest();
    }
}