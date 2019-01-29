/*
Name            : BOT_AccountPlanBenefitDesign_Extn_Test
Created date    : 18-Dec-2018
Created by      : Harsha B R
Description     : This class is written by BusinessOne Technologies Inc. 
					It is test class for BOT_AccountPlanBenefitDesign_Extn class.
*/
@isTest(seeAllData=false)
private class BOT_AccountPlanBenefitDesign_Extn_Test {
    
     static testMethod void BOT_APBenefitDesignLine_Extn()
    {
        Test.startTest();
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine=new List<Benefit_Design_Line_vod__c>();
        List<Account_Plan_vod__c> lstAccountPlan=new List<Account_Plan_vod__c>();
        ID accID;
        
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        accID=[SELECT Id,Name FROM Account].Id;
        
        lstAccountPlan=clsTestDataFactory.createAccountPlanRecords(accID, 1);
        insert lstAccountPlan;
        
        clsTestDataFactory.createBenefitDesignRecords(1,3,'Commercial');
        List<Benefit_Design_vod__c> lstBD=[SELECT Id,Lives_vod__c FROM Benefit_Design_vod__c];
        system.debug('***SIZE***'+lstBD.size());
        system.debug('***SIZE1***'+lstBD[0].Lives_vod__c);
        system.debug('***SIZE2***'+lstBD[1].Lives_vod__c);
        system.debug('***SIZE3***'+lstBD[2].Lives_vod__c);
        clsTestDataFactory.createFormularyProductRecords(5);
        lstBenefitDesignLine = clsTestDataFactory.createBenefitDesignLineRecords(1,5); 
        insert lstBenefitDesignLine;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(lstAccountPlan[0]);
        BOT_AccountPlanBenefitDesign_Extn clsAPBenefitDesign= new BOT_AccountPlanBenefitDesign_Extn(controller);
        clsAPBenefitDesign.getPullMarket(); 
        clsAPBenefitDesign.getPullBenefitDesign();
        
        //Calling marketFilterRetrieve method with selected market as 'ALL'
        clsAPBenefitDesign.selectedMarket = 'All';
        clsAPBenefitDesign.marketFilterRetrieve();
        System.assertEquals(lstBenefitDesignLine.size(), 5);
       
        //Calling marketFilterRetrieve method with selected market as 'All Company Products'
        clsAPBenefitDesign.selectedMarket = 'All Company Products';
        clsAPBenefitDesign.marketFilterRetrieve();
        System.assertEquals(lstBenefitDesignLine.size(), 5);
        
        Test.stopTest(); 
    }

}