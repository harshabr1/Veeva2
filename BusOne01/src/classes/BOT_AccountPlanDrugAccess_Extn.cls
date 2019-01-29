/*
Name            : BOT_AccountPlanDrugAccess_Extn
Created by      : Sreenivasulu Adipudi
Created date    : 14-DEC-2018
Description     : This class is created by BusinessOneTechnologies Inc.
				  It is an externsion class for BOT_AccountPlanDrugAccess visualforce page.
*/
public with sharing class BOT_AccountPlanDrugAccess_Extn {
	Public Id accountId {get;set;}					//To store Account Id
    Public Id accountPlanId {get;set;}				//To store Account Plan Id
    Public String selectedMarket {get;set;}			//To store user selected market
    Public Boolean renderChart {get;set;}			//Used to render the dashboard
    Set<String> setMarkets = new Set<String>();		//To store unique markets
    
    //Constructor
    public BOT_AccountPlanDrugAccess_Extn(Apexpages.StandardController controller) {
        accountPlanId = controller.getId();
        //Getting assoicated Paret Account Id of Account plan
        accountId = [SELECT Account_vod__c FROM Account_Plan_vod__c WHERE Id =: accountPlanId].Account_vod__c;
    	
        //Setting 'immunology' as a default market
        selectedMarket = 'Immunology';
        
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
    	List<selectOption> options = new List<selectOption>();
        if(setMarkets.size()>0 && setMarkets != null)
        {
            if(setMarkets.size()>1)
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