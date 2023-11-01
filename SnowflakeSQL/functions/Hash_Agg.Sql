// Create a has value of the Udemy Sales table
Select Hash_Agg(*) From Udemy.Public.Sales;

// Is the Sales table in Udemy the same as Udemy_Clone
Select Hash_Agg(*) = (Select Hash_Agg(*) From Udemy_Clone.Public.Sales)
From Udemy.Public.Sales