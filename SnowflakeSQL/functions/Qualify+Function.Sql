// Execute a query to find duplicate email addresses in the Customer table
SELECT 
    C_Email_Address,
    COUNT(*) AS customer_count
FROM Customer
GROUP BY C_Email_Address
HAVING customer_count > 1;

// For each duplicate, retrieve the entire customer row
WITH Customer_Duplicates AS
    (
      SELECT 
        C_Email_Address
      FROM Customer
      GROUP BY C_Email_Address
      HAVING Count(*) > 1  
    )
SELECT * From Customer
Where C_Email_Address IN (SELECT C_Email_Address FROM Customer_Duplicates)
ORDER BY C_Email_Address

// For each duplicate, retrieve the entire customer row, using Qualify
SELECT * FROM Customer
WHERE C_Email_Address IS NOT NULL
QUALIFY COUNT(*) OVER (PARTITION BY C_Email_Address) > 1
Order By C_Email_Address

