/*
Name			: BOT_BenefitDesignTriggerHandler
Created By		: Sreenivasulu A
Created Date	: 28-AUG-2018
Overview		: This class is written by BusinessOne Technologies Inc. It performs below functionalities:-
				1.	It is used to truncate the name of the Benefit Design if the characters is more than 80. Append the channel at the end of the name.
				2.	It is used to populate the parent SFDC ID by using BOT Entity ID.
*/
public with sharing class BOT_BenefitDesignTriggerHandler 
{
	public static void manageNameAndPopulateAccountId(List<Benefit_Design_vod__c> lstBenefitDesign, Set<Integer> setAccountIds)
    {
        Integer channelLength = 0;									//To store length of channel value
        Map<Integer, ID> mapAccountIds = new Map<Integer, ID>();	//To store BOT Entity Ids and SFDC Ids of Account object
        
        //To Retrieve SFDC Account Ids by comparing BOT Entity Ids and put in map
        for(Account objAccount : [SELECT Id, BOT_Entity_ID__c FROM Account WHERE BOT_Entity_ID__c in : setAccountIds])
        {
            mapAccountIds.put(Integer.valueOf(objAccount.BOT_Entity_ID__c), objAccount.Id);
        }
		
        for(Benefit_Design_vod__c objBenefitDesign : lstBenefitDesign)
        {
            //To update related SFDC Account ID
            objBenefitDesign.Account_vod__c = mapAccountIds.get(Integer.valueOf(objBenefitDesign.BOT_Entity_ID__c));
            
            //To handle name field
            if(objBenefitDesign.BOT_Formulary_Name__c != Null && objBenefitDesign.Type_vod__c != Null)
            {
                //To append ' - ' and channel to the BOT_Formulary_Name field make channelLength as 80 - (3 + channel value length)
                channelLength = 77 - objBenefitDesign.Type_vod__c.length();
                
                //Check weather BOT_Formulary_Name field value length is lessthan or equal to channelLength
                //If it is true then append channel to BOT_Formulary_Name field value and store it in name field
                if(objBenefitDesign.BOT_Formulary_Name__c.length() <= channelLength)
                {
                	objBenefitDesign.Name = objBenefitDesign.BOT_Formulary_Name__c + ' - '+ objBenefitDesign.Type_vod__c;   
                }
                
                //If name field more than channelLength trim the BOT_Formulary_Name field value
                //Append '.. - ' + channel to BOT_Formulary_Name field value and store it in name field 
                else
                {
                    channelLength = channelLength - 2;
                	objBenefitDesign.Name = objBenefitDesign.BOT_Formulary_Name__c.subString(0,channelLength) + '.. - '+ objBenefitDesign.Type_vod__c;  
                }
            }
        }
    }
    
    //To update the total roll up plan lives of associated formulary records on Account
    public static void updatePlanLivesOnAccount(Set<Id> setAccountIds)
    {
        Map<String,Decimal> lstPlanLives = new Map<String,Decimal>();	//To store the Entity Id and total formulary lives
        List<Account> lstAccount;										//To store a list of Account records
        
        //Query of total lives associated to each entity and put it in the map
        for(AggregateResult res : [SELECT Account_vod__c accountId, SUM(Lives_vod__c) total FROM Benefit_Design_vod__c GROUP BY Account_vod__c HAVING Account_vod__c IN : setAccountIds])
        {
            lstPlanLives.put(String.valueOf(res.get('accountId')), Integer.valueOf(res.get('total')));
        }
		
        //Query of Accounts need to be update the lvies
        lstAccount = [SELECT Id, BOT_Plan_Lives__c FROM Account WHERE Id IN : setAccountIds];
        for(Account objAccount : lstAccount)
        {
            //To update the plan lives on Account
            objAccount.BOT_Plan_Lives__c = lstPlanLives.get(objAccount.Id);
        }
		update lstAccount;       
    }
}