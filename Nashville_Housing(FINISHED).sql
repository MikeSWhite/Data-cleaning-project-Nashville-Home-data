SELECT * FROM nashville_housing3;

SELECT * FROM nashville_housing2;

-- 1. Standardize data format
-- 2. populate and edip property address
-- 3. Break address into individual columns (address, state, city)
-- 4. change y and in to yess and no 
-- 5. Remove Duplicates
-- 6. Remove any columns(if Needed)

-- Seperating the address
SELECT propertyAddress
FROM nashville_housing3;

SELECT 
substring(PropertyAddress, 1, LOCATE(',', propertyAddress) -1 ) AS Address,
	substring(PropertyAddress, LOCATE(',', propertyAddress) +1) , length(PropertyAddress)  AS City
FROM nashville_housing3;

SELECT 
	substring(PropertyAddress, LOCATE(',', propertyAddress) +1) , length(PropertyAddress)  AS City
FROM nashville_housing3;


ALTER TABLE nashville_housing3
ADD Property_split_Address VARCHAR(255);

ALTER TABLE nashville_housing3
ADD Property_split_City VARCHAR(255);

UPDATE nashville_housing3
SET Property_split_Address = substring(PropertyAddress, 1, LOCATE(',', propertyAddress) -1 );

UPDATE nashville_housing3
SET Property_split_City = substring(PropertyAddress, LOCATE(',', propertyAddress) +1);

SELECT *
FROM nashville_housing3;

-- Seperating owner address

SELECT owneraddress
FROM nashville_housing3;



SELECT
    TRIM(SUBSTRING_INDEX(owneraddress, ',', 1)) AS street,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(owneraddress, ',', 2), ',', -1)) AS city,
    TRIM(SUBSTRING_INDEX(owneraddress, ',', -1)) AS state
FROM nashville_housing3;


SELECT
 TRIM(SUBSTRING_INDEX(owneraddress, ',', -1)) AS state
FROM nashville_housing3;

ALTER TABLE nashville_housing3
ADD owner_split_Address VARCHAR(255);

ALTER TABLE nashville_housing3
ADD owner_split_City VARCHAR(255);
 
ALTER TABLE nashville_housing3
ADD owner_split_State VARCHAR(255);

UPDATE nashville_housing3
SET owner_split_state = TRIM(SUBSTRING_INDEX(owneraddress, ',', -1));
 
SELECT *
FROM nashville_housing3;

-- change sold as vacant to 'yes' 'no'

SELECT DISTINCT(soldasvacant), COUNT(soldasvacant)
FROM nashville_housing3
GROUP BY soldasvacant;

SELECT soldasvacant,
(CASE
		WHEN soldasvacant LIKE '%Y%' THEN 'Yes'
        WHEN soldasvacant LIKE '%N%' THEN 'No'
        ELSE soldasvacant
	END)
FROM nashville_housing3;  


UPDATE nashville_housing3
SET soldasvacant = (CASE
		WHEN soldasvacant LIKE '%Y%' THEN 'Yes'
        WHEN soldasvacant LIKE '%N%' THEN 'No'
        ELSE soldasvacant
	END);
    
-- trimming Acereage

SELECT ROUND(Acreage, 1)
FROM nashville_housing3;

UPDATE nashville_housing3
SET Acreage = ROUND(Acreage, 1);

SELECT 
TRUNCATE(Acreage, 1);

    
    
    -- Removing duplicates
    
SELECT *
FROM nashville_housing3;
    
      
 WITH rownum_CTE AS(     
      SELECT *,
		ROW_NUMBER() OVER(
		PARTITION BY parcelID,
        PropertyAddress,
        SalePrice,
        SaleDate,
        LegalReference
        ORDER BY uniqueID
        ) AS row_num
        FROM nashville_housing3
        ORDER BY parcelID
      )
SELECT *
FROM rownum_CTE
WHERE row_num > 1
ORDER BY PropertyAddress;
    
    -- Deleting unused columns
    
    
SELECT *
FROM nashville_housing3;

ALTER TABLE nashville_housing3
DROP COLUMN owneraddress;

ALTER TABLE nashville_housing3
DROP COLUMN PropertyAddress;

ALTER TABLE nashville_housing3
DROP COLUMN TaxDistrict;

SELECT *
FROM nashville_housing3;

UPDATE nashville_housing3
SET Acreage = TRUNCATE(Acreage, 1);

SELECT *
FROM nashville_housing3;
 