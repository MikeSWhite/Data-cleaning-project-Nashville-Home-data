Nashville Housing Data Cleaning (SQL)
Project Overview
This project focuses on cleaning and standardizing the Nashville Housing dataset using MySQL. The goal was to improve data quality, consistency, and usability by normalizing address fields, standardizing categorical values, handling duplicates, and removing unused columns.

All transformations were performed directly in SQL to simulate real-world data preparation tasks commonly handled by SQL developers and data analysts.

Data Cleaning Steps
1. Address Standardization and Splitting
Property Address
The PropertyAddress column originally contained both street address and city in a single field.

This column was split into:

Property_split_Address

Property_split_City

String functions such as SUBSTRING() and LOCATE() were used to extract values based on the comma delimiter.

Owner Address
The OwnerAddress column contained street, city, and state in a single field.

This column was split into:

owner_split_Address

owner_split_City

owner_split_State

The SUBSTRING_INDEX() and TRIM() functions were used to reliably parse each component.

2. Standardizing Categorical Values
Sold As Vacant
The SoldAsVacant field contained inconsistent values such as Y, N, Yes, and No.

A CASE statement was used to standardize all values to:

Yes

No

This ensures consistency for analysis and reporting.

3. Numeric Data Normalization
Acreage
The Acreage column was standardized to one decimal place using:

ROUND()

TRUNCATE()

This improves readability and ensures consistent numeric formatting.

4. Duplicate Detection
Duplicate records were identified using a window function (ROW_NUMBER()).

Rows were partitioned by:

ParcelID

PropertyAddress

SalePrice

SaleDate

LegalReference

This allowed identification of duplicate records while preserving a single unique entry per property transaction.

Duplicate rows were reviewed before removal to ensure data integrity.

5. Removing Unused Columns
After cleaning and restructuring the data, redundant columns were removed to reduce clutter and improve schema clarity:

OwnerAddress

PropertyAddress

TaxDistrict

The final table contains only normalized and analysis-ready columns.

Skills Demonstrated
SQL data cleaning and transformation

String manipulation

Window functions (ROW_NUMBER)

Schema modification (ALTER TABLE)

Data standardization and normalization

Real-world dataset preparation

Final Result
The cleaned dataset is:

More readable

Consistent across categorical and numeric fields

Properly normalized for analysis or visualization

Free of redundant columns and duplicate records
