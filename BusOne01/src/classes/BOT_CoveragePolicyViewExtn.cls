/*
Name 		 : BOT_CoveragePolicyViewExtn
Created Date : 12-Nov-2018
Created By   : Harsha BR
Overview 	 : It is written by BusinessOne Technologies Inc. It is used to fetch the details reagrding the Coverage Policy. 
*/
public class BOT_CoveragePolicyViewExtn
{   
    /*Public String strRichText{get;set;}
    Public String strRichText1{get;set;}*/
    Public List<BOT_Coverage_Policy__c> lstCoveragePolicy{get;set;}
    Public BOT_CoveragePolicyViewExtn(ApexPages.StandardController controller)
    {
     	//coveragePolicyId = controller.getId();
        lstCoveragePolicy=[SELECT Id,BOT_STDetail__c,BOT_DRC__c,BOT_DRI__c,BOT_PADetail__c,BOT_Policy_Detail__c
                           FROM BOT_Coverage_Policy__c
                           WHERE ID=:controller.getId()
                           LIMIT 1];
        /*strRichText=lstCoveragePolicy[0].Test__c.replace('*','<br>');
        system.debug('***Before strRichText***'+strRichText);
        strRichText=strRichText.replace('>>', '<ul><li>');
        strRichText=strRichText.replace('|', '</li><li>');
        strRichText=strRichText.replace('<<', '</ul></li>');
        system.debug('***After strRichText***'+strRichText);
        
         strRichText1=lstCoveragePolicy[0].Test1__c.replace('*','<br>');
        system.debug('***Before strRichText1***'+strRichText1);
        strRichText1=strRichText1.replace('>>', '<ul><li>');
        strRichText1=strRichText1.replace('|', '</li><li>');
        strRichText1=strRichText1.replace('<<', '</ul></li>');
        system.debug('***After strRichText1***'+strRichText1);*/     
    }
}