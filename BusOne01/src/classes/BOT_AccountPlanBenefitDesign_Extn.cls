/* 
Name 	   	 : BOT_AccountPlanBenefitDesign_Extn
Created By 	 : Harsha BR
Created Date : 14-Dec-2018
Description  : It is  written by BusinessOne Technologies Inc.
			   It displays the Benefit design line (Drug) records associated to selected Benefit Design and Market . 
*/
public class BOT_AccountPlanBenefitDesign_Extn {
    
    ID accountId; 																	//To store the Account ID
    public string selectedBD {get;set;}                        						//To store user selected Benefit Design
    public string selectedMarket {get;set;}											//To store the selected market by the end user
    set<ID> setBDIds=new Set<ID>();													//To store the Benefit Design IDs
    set<String> setMarkets = new set<String>();										//To store all the market values
    Private string strFilter;                                              			//To store the condition to run the query
    Private string strExeQuery;                                            			//To store the query to get the details of the drugs
    Public Integer intMarketsSize{set;get;}											//To store the number of markets
    Public List<Benefit_Design_vod__c> lstBenefitDesigns {get;set;}     			//To store list of Benefit Design records
    Public List<Benefit_Design_Line_vod__c> lstBenefitDesignLines {get;set;}     	//To store list of Benefit Design line records
    
    Public BOT_AccountPlanBenefitDesign_Extn(ApexPages.StandardController controller)
    {
        strFilter='';
        
        accountId=[SELECT ID,Account_vod__c
                   FROM Account_Plan_vod__c
                   WHERE ID=:controller.getId() AND Account_vod__c!=null].Account_vod__c;
        
        if(accountId!=null)
        {
        	 lstBenefitDesigns=[SELECT Id,Name,BOT_Formulary_Name__c,Lives_vod__c
                                FROM Benefit_Design_vod__c
                                WHERE Account_vod__c=:accountId 
                                LIMIT 50000];   
        }

        for(Benefit_Design_vod__c objDB:lstBenefitDesigns)
        {
            setBDIds.add(objDB.Id);
        }
        
        /*for(Benefit_Design_Line_vod__c objBDL:[SELECT Id, Product_vod__r.Market_vod__c FROM Benefit_Design_Line_vod__c WHERE Benefit_Design_vod__c IN:setBDIds AND BOT_Is_BOT_Data__c=true AND Product_vod__r.Market_vod__c!=null LIMIT 50000])
        {
        	setMarkets.add(objBDL.Product_vod__r.Market_vod__c);    
        } */
        
         for(AggregateResult res : [SELECT Product_vod__r.Market_vod__c market FROM Benefit_Design_Line_vod__c GROUP BY Product_vod__r.Market_vod__c, Benefit_Design_vod__c HAVING Benefit_Design_vod__c IN:setBDIds ])
        {
        	setMarkets.add(String.valueOf(res.get('market')));    
        }
        
        intMarketsSize=setMarkets.size();
        selectedMarket = 'Immunology';
        selectedBD=lstBenefitDesigns[0].Id;
        marketFilterRetrieve();
    }
    
    //To retrieve all the Benefit Design records
    Public List<selectOption> getPullBenefitDesign()
    {
        Integer intLast3numbers;
        Integer increment;
        
        String strLivesCount='';
        
        List<selectOption> options = new List<selectOption>();
        
        for(Benefit_Design_vod__c objBD:lstBenefitDesigns)
        {
            if(objBD.Lives_vod__c==null)
            {
                strLivesCount='';		   
            }
            else if(objBD.Lives_vod__c.format().remove(',').length()>3)
            {
                intLast3numbers=Integer.Valueof(objBD.Lives_vod__c.format().right(3));
                if(intLast3numbers>=500)
                {
                 	increment=Integer.valueOf(objBD.Lives_vod__c.format().remove(',').substring(0,(objBD.Lives_vod__c.format().remove(',').length()-3)))+1;
                    strLivesCount=' ('+increment+'K)';    
                }
                else
                {
                 	strLivesCount=' ('+objBD.Lives_vod__c.format().remove(',').substring(0,(objBD.Lives_vod__c.format().remove(',').length()-3))+'K)';   
                }		   
            }
            else
            {
            	strLivesCount=' ('+objBD.Lives_vod__c.format()+')';  
            }
                
            options.add(new selectOption(objBD.Id,(objBD.Name+strLivesCount)));
            options.sort();
        }
        return options;
    }
    
     //To retrieve all the Market values
   	Public List<selectOption> getPullMarket()
    {
        List<selectOption> options = new List<selectOption>();
        if(intMarketsSize>0)
        {
            if(intMarketsSize>1)
            {
             	options.add(new selectOption('All','All'));
                options.add(new selectOption('All Company Products','All Company Products'));   
            }
         	for(String market:setMarkets)
        	{
            	options.add(new selectOption(market,market));
            	options.sort();
        	}   
        }  
        return options;
    }
    
    
    //To get list of benefit design records associated with selected formulary and selected market
    public void marketFilterRetrieve()
    {
         
        if(selectedMarket == 'All')
        {
            strFilter='Benefit_Design_vod__c =: selectedBD';    
        }
        else if(selectedMarket == 'All Company Products')
        {
            strFilter='Benefit_Design_vod__c =: selectedBD AND Competitor_vod__c = false';
        }
        else
        {
            strFilter='Benefit_Design_vod__c =: selectedBD AND Product_vod__r.Market_vod__c =: selectedMarket';   
        }
        
        strExeQuery ='SELECT Id, Product_vod__r.Market_vod__c, Product_vod__r.Name, Status_Source_vod__c, Restrictions_Source_vod__c, Copay_Source_vod__c, Notes_Source_vod__c,Competitor_vod__c FROM Benefit_Design_Line_vod__c WHERE '+ strFilter+' ORDER BY Product_vod__r.Name LIMIT 50000';

        lstBenefitDesignLines= database.query(strExeQuery);  
    }
}