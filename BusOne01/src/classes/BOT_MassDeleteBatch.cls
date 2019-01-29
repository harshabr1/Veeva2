/*
Name			: BOT_MassDeleteBatch 
Created By		: Sreenivasulu A
Created Date	: 11-JAN-2019
Overview		: This class is written by BusinessOne Technologies Inc. It performs delete operation from specified object/All objects.
*/
global class BOT_MassDeleteBatch implements Database.Batchable<sobject>
{
	global String queryString;		//To store the query string
    //Constructor
    global BOT_MassDeleteBatch(String query)
    {
        //Copying query string
        queryString = query;      	 
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(queryString);
    }
    
    global void execute(Database.BatchableContext BC, List<SObject> lstRecords)
    {
        //Database.delete(lstRecords, false);
		
        //To store the error messages
        List<BOT_Error_Tracking_on_Mass_Delete__c> lstErrorTracking = new List<BOT_Error_Tracking_on_Mass_Delete__c>();
        BOT_Error_Tracking_on_Mass_Delete__c objErrorTracking;			//To store an error message
		
        //To perform bulk delete operation
        Database.DeleteResult[] result = Database.delete(lstRecords, false);

        //Iterating the result
        for(Database.DeleteResult res : result)
        {
       		//If status is not success then create error record and insert it into BOT_Error_Tracking_on_Mass_Delete__c object
            if(!res.isSuccess())
            {
				for(Database.Error err : res.getErrors())
                {
                	objErrorTracking = new BOT_Error_Tracking_on_Mass_Delete__c();
                    objErrorTracking.Name = res.getId();
                    objErrorTracking.BOT_Error_Message__c = err.getMessage();
                    lstErrorTracking.add(objErrorTracking);
                }
            }
        }
        if(lstErrorTracking != Null && lstErrorTracking.size() > 0)
        {
            Database.insert(lstErrorTracking,false);
        }
    }
    global void finish(Database.BatchableContext BC) 
    {
    	List<SObject> lstRecords = Database.query(queryString);
        //Verifying how many records present in the DB. 
        if(lstRecords.size() > 0)
        {
            //If record count morethan 0 then call anoter batch to delete remaining records.
            BOT_MassDeleteBatch_Finish clsMassDeleteFinish = new BOT_MassDeleteBatch_Finish(queryString);
            Database.executeBatch(clsMassDeleteFinish, 100);
        }
    }
}