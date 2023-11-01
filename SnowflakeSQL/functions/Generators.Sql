// Generate some numbers
Select ROW_NUMBER() OVER (Order BY NULL) as Row_Id
From table(GENERATOR(ROWCOUNT => 10)) t

// Generate some dates
Select DATEADD(DAY,ROW_NUMBER() OVER (Order By NULL) - 1, '1/1/2021') as Dates
From table(GENERATOR(ROWCOUNT => 10)) t

// Generate a uniform random distribution of integer numbers
Select
     SEQ4() as Numbers -- Returns a sequence of increasing integers based on a 4 byte integer (in this case). Starts with zero.
    ,UNIFORM(1, 20, RANDOM(20)) as Distribution -- Returns a uniformly random number, in the inclusive range of the first two parameters. The Random function is called with a seed value.
From table(GENERATOR(ROWCOUNT => 10)) t

// Generate a series of floating point numbers
Select
    uniform(0.0, 1.0, random()) -- This does not work as might be expected
    ,uniform(0::float, 1::float, random()) -- This does work
From table(generator(rowcount => 10));

// You can also have Snowflake generate numbers for a specified period of time. In this case it's one second.
Select
     SEQ4() as Numbers -- Returns a sequence of increasing integers based on a 4 byte integer (in this case). Starts with zero.
From table(GENERATOR(TIMELIMIT => 1)) t
