/*
Name            : BOT_DrugAccessDashboard_Extn
Created by      : Sreenivasulu Adipudi
Created date    : 07-SEP-2018
Description     : This class is created by BusinessOneTechnologies Inc.
				  It is an externsion class for BOT_DrugAccessDashboard visualforce page.
*/
public with sharing class BOT_DrugAccessDashboard_Extn 
{
    public Id accountId {get;set;}					//To store Account Id
    public Boolean renderChart {get;set;}			//Used to render the dashboard
    public String selectedMarket {get;set;}			//To store user selected market
    Set<String> setMarkets = new Set<String>();		//To store unique markets
    
    //Constructor
    public BOT_DrugAccessDashboard_Extn(ApexPages.StandardController controller)
    {
        accountId = controller.getId();
        //Setting 'Immunology' as a default market
        selectedMarket = 'Immunology';
        //renderChart = true;
        
        //To Get Market field values from Drug access and store into a set
        for(AggregateResult res : [SELECT Name FROM BOT_Drug_Access__c GROUP BY Name, BOT_Account__c HAVING BOT_Account__c =: accountId ORDER BY Name])
        {
        	setMarkets.add(String.valueOf(res.get('Name')));    
        }
        marketFilterRetrieve();
    }

    public void marketFilterRetrieve()
    {
        if(selectedMarket == 'ALL' || selectedMarket == Null)
        {
            renderChart = true;
        }
        else
        {
            renderChart = false;
        }
    }
    
    //To create dynamic picklist values
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