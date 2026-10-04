# SSMS - Driving Range
I built a relational database, _DrivingRange_, for a fictional driving range business with tee box rentals, ball bucket purchases, and golf tournaments. It covers customers, the range facility, tee boxes, tournaments, entries, and purchases. This was a project for CWEB2126 - Database II.
## Project - Driving Range Database and Entity Relationship Diagrams

- **Entity Relationship Diagrams**: Conceptual, Logical, Physical

  I worked through the conceptual and logical levels of ERD before writing any SQL, then reverse engineered my code to create an accurate physical model. The conceptual diagram lays out the business entities (Tournament, Customer, Bucket of Balls, Range, Tee Box) and how they relate, with no attributes or keys. The logical diagram adds attributes, primary keys, and foreign keys to every entity, and resolves each many-to-many relationship into its own table: `Entry` between Tournament and Customer, and `TeeBoxUsage` between Customer and Tee Box. The physical diagram builds on the logical one with SQL Server data types, `NOT NULL', `CHECK` constraints, and defaults for every column, matching the final script exactly.

- **Schema Design (DDL)**: `Customer`, `Range`, `TeeBox`, `Tournament`, `BucketOfBalls`, `TeeBoxUsage`, `Entry`, `Purchase`

  I designed eight tables and connected them with primary and foreign keys. Tee box rentals are free, so `TeeBoxUsage` only logs who occupied which bay and when; a `NULL` `EndTime` means the bay is still in use, and a `CHECK` constraint keeps a rental's end time from falling before its start time. `Entry` stores each customer's `Handicap` at the time they registered for a tournament rather than on `Customer`, since a handicap changes over time, and a `UNIQUE` constraint on `(TournamentID, CustomerID)` stops a customer from entering the same tournament twice. `TeeBox` has a similar `UNIQUE` constraint on `(RangeID, TeeBoxNumber)` so bay numbers can't repeat within a range. `Purchase.PricePaid` records the price actually charged, separate from `BucketOfBalls.ItemPrice`, so past sales stay accurate if prices change later.

## Running the Project
1. Clone the repository: `git clone (https://github.com/joey-augustin/SSMS.Driving.Range)`
2. Open `Joey's Driving Range.sql` in SQL Server Management Studio or another SQL Server client
3. Run the script from top to bottom: database creation, then tables in order (`Customer`, `Range`, `TeeBox`, `Tournament`, `BucketOfBalls`, `TeeBoxUsage`, `Entry`, `Purchase`)

## Technologies Used
- SQL Server Management Studio (SSMS)
