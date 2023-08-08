--Select *
--From NashvilleHousing
--Order by 1

-- Standardize Date Format

--Select SaleDate, Convert(Date,SaleDate)
--From NashvilleHousing


--Alter Table NashVilleHousing
--Add SaleDateConverted Date;

--Update NashvilleHousing
--SET SaleDateConverted = Convert(Date,SaleDate)

----ALTER TABLE NashVilleHousing
----DROP COLUMN SaleDateConverted;


--Select SaleDateConverted, Convert(Date,SaleDate)
--From NashvilleHousing

-- Populate Propert Address Data

--Select a.[UniqueID ], a.ParcelID, a.PropertyAddress, b.[UniqueID ], b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
--From NashvilleHousing a
--Join NashvilleHousing b
--	On a.ParcelID = b.ParcelID
--	and a.[UniqueID ] <> b.[UniqueID ]
--where a.PropertyAddress is null

--Update a
--SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
--From NashvilleHousing a
--Join NashvilleHousing b
--	On a.ParcelID = b.ParcelID
--	and a.[UniqueID ] <> b.[UniqueID ]
--where a.PropertyAddress is null

--Select * 
--From NashvilleHousing
--where PropertyAddress is null

-- BREAKDOWN ADDRESS into Address, City, State

--Select PropertyAddress
--From NashvilleHousing

--Select 
--SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress) - 1) as PropertySplitAddreess,
--SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as PropertySplitCity
--From NashvilleHousing


--Alter Table NashVilleHousing
--Add PropertySplitAddress nvarchar(255);

--Update NashvilleHousing
--SET PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress) - 1)

--Alter Table NashVilleHousing
--Add PropertySplitCity nvarchar(255);

--Update NashvilleHousing
--SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

--Select * 
--From NashvilleHousing


--Select OwnerAddress
--From NashvilleHousing

--SELECT
--PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
--PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
--PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
--From  NashvilleHousing

--Alter Table NashVilleHousing
--Add OwnerSplitAddress nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

--Alter Table NashVilleHousing
--Add OwnerSplitCity nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

--Alter Table NashVilleHousing
--Add OwnerSplitState nvarchar(255);

--Update NashvilleHousing
--SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

--Select *
--From NashvilleHousing


-- Change Y and N to Yes and No

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant,
CASE 
	When SoldAsVacant = 'Y' Then 'Yes'
	WHEN SoldAsVacant = 'N' Then 'No'
	ELSE SoldAsVacant
	END
From NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE 
	When SoldAsVacant = 'Y' Then 'Yes'
	WHEN SoldAsVacant = 'N' Then 'No'
	ELSE SoldAsVacant
END


-- Remove Duplicates

