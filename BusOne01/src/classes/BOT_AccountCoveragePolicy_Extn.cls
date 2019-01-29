/*
Name			: BOT_AccountCoveragePolicy_Extn
Created date	: 12/20/2018
Created by		: Sreenivasulu Adipudi
Description		: This class is written by BusinessOne Technologies Inc. It is an extension for BOT_AccountCoveragePolicy Visualforce page.
*/
public with sharing class BOT_AccountCoveragePolicy_Extn 
{
	ID accountId;														//To store the ID of selected Account
    Public List<BOT_Coverage_Policy__c> lstCoveragePolicy {get;set;}	//To store the coverage policy records
    public String selectedMarket {get; set;}							//To store user selected market
    Set<String> setMarkets = new Set<String>();							//To store unique markets
    
    //Constructor
    public BOT_AccountCoveragePolicy_Extn(ApexPages.StandardController controller)
    {
    	accountId = controller.getId();
        //Setting 'Immunology' as a default market
        selectedMarket = 'Immunology';
        
        lstCoveragePolicy = [SELECT BOT_Formulary_Product__r.Market_vod__c FROM BOT_Coverage_Policy__c WHERE BOT_Account__c =: accountId LIMIT 50000];
        
        if(!lstCoveragePolicy.isEmpty())
        {
        	for(BOT_Coverage_Policy__c objCoveragePolicy : lstCoveragePolicy)
        	{
            	setMarkets.add(objCoveragePolicy.BOT_Formulary_Product__r.Market_vod__c);
        	}
        }
		
    	getCoveragePolicyFilteredByMarket();
	}
    
    public void getCoveragePolicy()
    {
    	if(selectedMarket == 'ALL')
        {
        	//To get Coverage policy records related to selected account
        	lstCoveragePolicy = [SELECT Id, BOT_Channel__c, BOT_Drug__c,BOT_Formulary_Product__r.Name, BOT_Score__c, BOT_Indication__c, BOT_Sub_Indication__c, (SELECT Id, Name FROM Attachments LIMIT 2) 
                             	 FROM BOT_Coverage_Policy__c WHERE BOT_Account__c =: accountId ORDER BY BOT_Drug__c];
        }
        else
        {
        	getCoveragePolicyFilteredByMarket();    
        }
    }
    
    public void getCoveragePolicyFilteredByMarket()
    {
        //To get Plan products records filtered by selected channel
	    lstCoveragePolicy = [SELECT Id, BOT_Channel__c, BOT_Drug__c,BOT_Formulary_Product__r.Name, BOT_Score__c, BOT_Indication__c, BOT_Sub_Indication__c, 
                             (SELECT Id, Name FROM Attachments LIMIT 2) FROM BOT_Coverage_Policy__c 
                             WHERE BOT_Account__c =: accountId AND BOT_Formulary_Product__r.Market_vod__c =: selectedMarket ORDER BY BOT_Drug__c];
    }
    
    //To create dynamic market picklist values
    public List<selectOption> getDynamicList()
    {
    	//return BOT_CreatePickListValues.getDynamicList(setMarkets);
        Integer marketsCount = setMarkets.size();
        List<selectOption> options = new List<selectOption>();
        if(marketsCount > 0 && setMarkets != null)
        {
            if(marketsCount > 1)
        	{
        		options.add(new selectOption('ALL','ALL'));
        	}
            for(String c : setMarkets)
        	{
        		options.add(new selectOption(c,c));
        	}            
        }
        return options;
    }
}