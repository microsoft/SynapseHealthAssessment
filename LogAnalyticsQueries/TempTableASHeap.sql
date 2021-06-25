let databaseName = '<DATABASENAME>';
//Long-Running Queries - Just Actual Queries
//If 'Command' is empty - you need to set a bigger time window, the older record with the command is outside of your window
AzureDiagnostics
| where Category  == 'ExecRequests'
| where Resource  == databaseName
| where StatementType_s !in ('Batch','Execute')
| where tolower(Command_s) contains "create table #"
 | summarize Session_ID=any(SessionId_s),
    Request_ID=any(RequestId_s),
    Submit_Time=max(SubmitTime_t),
    Start_Time=max(StartTime_t),
    End_Time=max(EndTime_t),
    Command=any(Command_s),
    Status=min(Status_s), //This works because Completed/Failed/Cancelled are all below running, below suspended. This happens to work out where the min is the current status
    Statement_Type=any(StatementType_s),
    Resource_class=any(ResourceClass_s)
    by RequestId_s
| summarize ElapsedTime_min=anyif((End_Time - Start_Time)/1m,Start_Time > ago(30d)),Session_ID=any(Session_ID), Submit_Time=any(Submit_Time) ,Start_Time=any(Start_Time), End_Time=any(End_Time),Command=any(Command),Status=any(Status),Statement_Type=any(Statement_Type),Resource_class=any(Resource_class) by Request_ID
| order by ElapsedTime_min desc