/*
Name			: BOT_MassDeleteBatch_Finish 
Created By		: Sreenivasulu A
Created Date	: 22-JAN-2019
Overview		: This class is written by BusinessOne Technologies Inc. This Batch class invoke when Mass DeleteBatch is fail to process all records.
				  We are calling this batch class from the finish method of BOT_MassDeleteBatch.
*/
Global class BOT_MassDeleteBatch_Finish implements Database.Batchable<sObject>
{
	global String queryString;
    global BOT_MassDeleteBatch_Finish(String query)
    {
        queryString = query;       
    }
    Global Database.QueryLocator start(Database.BatchableContext BC)
    {
    	return Database.getQueryLocator(queryString);   
    }
    Global void execute(Database.BatchableContext BC, List<sObject> lstRecords)
    {
    	Database.delete(lstRecords, false);   
    }
    Global void finish(Database.BatchableContext BC){}
}