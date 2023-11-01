// Find any queries currently being blocked

Select * 
From Table(Insight.Information_Schema.Query_History())  
Where Execution_Status ilike 'Blocked';

// Display all transactions
Show Transactions In Account;

// Cancel a transaction
Select system$abort_transaction(1594638696404);