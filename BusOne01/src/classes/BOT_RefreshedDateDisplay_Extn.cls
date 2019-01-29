/*
Name            : BOT_RefreshedDateDisplay_Extn
Created By      : Sreenivasulu A
Created Date    : 10-OCT-2018
Overview        : It is implemented by BusinessOne Technologies Inc.It is a controller class of BOT_RefreshedDateDisplay Visualforce page.
*/
public class BOT_RefreshedDateDisplay_Extn
{
    public Date lastUpdatedDate {get;set;}	//To store the last refreshed date
    public BOT_RefreshedDateDisplay_Extn()
    {
        try 
        {
            lastUpdatedDate = [SELECT Id, BOT_Refresh_Date__c FROM BOT_Data_Refresh_Date__c 
                               ORDER BY BOT_Refresh_Date__c DESC NULLS LAST LIMIT 1].BOT_Refresh_Date__c;
        }
        catch(Exception e)
        {
        	System.debug(e.getMessage());
        }        
	}
}