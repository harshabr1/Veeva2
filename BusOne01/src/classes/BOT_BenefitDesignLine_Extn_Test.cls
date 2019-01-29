/*
Name            : BOT_BenefitDesignLine_Extn_Test
Created date    : 29/08/2018
Created by      : Sreenivasulu Adipudi
Description     : This class is written by BusinessOne Technologies Inc. It is test class for BOT_BenefitDesignLine_Extn class.
*/
@isTest(seeAllData=false)
private class BOT_BenefitDesignLine_Extn_Test
{
    //Testing BOT_BenefitDesignLine_Extn standard controller class
    static testMethod void BOT_BenefitDesignLine_Extn()
    {
        Benefit_Design_vod__c objBenefitDesign;           		//To store a Benefit design record
        Benefit_Design_Line_vod__c objBenefitDesignLine;  		//To store a Benefit design line record
        List<Benefit_Design_Line_vod__c> lstBenefitDesignLine;	//To store a list if Benefit design records
        Integer i, j, temp = 0;
        
        //To create Benefit design Line records
        BOT_TestDataFactory clsTestDataFactory = new BOT_TestDataFactory();
        clsTestDataFactory.createAccountRecords(1,'MCO');
        clsTestDataFactory.createBenefitDesignRecords(1,1,'Commercial');
        clsTestDataFactory.createFormularyProductRecords(5);
        lstBenefitDesignLine = clsTestDataFactory.createBenefitDesignLineRecords(1,5);
        insert lstBenefitDesignLine;
        
        //Querying the created test data
        objBenefitDesign = [SELECT Id FROM Benefit_Design_vod__c LIMIT 1];
        
        Test.startTest();
        //Creating instance for Benefit design standard controller class
        ApexPages.StandardController controller = new ApexPages.StandardController(objBenefitDesign);
        BOT_BenefitDesignLine_Extn clsBenefitDesignLine= new BOT_BenefitDesignLine_Extn(controller);
        
        //Test data validation
        System.assertEquals(clsBenefitDesignLine.getDynamicList().size(), 7);
        
        //Calling marketFilterRetrieve method with selected market as 'Market 1'
        clsBenefitDesignLine.selectedMarket = 'Test Market 1';
        clsBenefitDesignLine.marketFilterRetrieve();
        System.assertEquals(clsBenefitDesignLine.lstBenefitDesignLine.size(), 1);
        
        //Calling marketFilterRetrieve method with selected market as 'ALL'
        clsBenefitDesignLine.selectedMarket = 'ALL';
        clsBenefitDesignLine.marketFilterRetrieve();
        System.assertEquals(clsBenefitDesignLine.lstBenefitDesignLine.size(), 5);
        
        //Calling marketFilterRetrieve method with selected market as 'All Company Products'
        clsBenefitDesignLine.selectedMarket = 'All Company Products';
        clsBenefitDesignLine.marketFilterRetrieve();
        System.assertEquals(clsBenefitDesignLine.lstBenefitDesignLine.size(), 5);
        Test.stopTest();
    }
}