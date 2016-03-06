IF OBJECT_ID('dbo.GeoLite2Locations', 'U') IS NOT NULL DROP TABLE dbo.GeoLite2Locations; 

CREATE TABLE GeoLite2Locations (
	[geoname_id] [int] NOT NULL,
	[locale_code] [nvarchar](16) NULL,
	[continent_code] [nvarchar](16) NULL,
	[continent_name] [nvarchar](64) NULL,
	[country_iso_code] [nvarchar](16) NULL,
	[country_name] [nvarchar](64) NULL,
	[subdivision_1_iso_code] [nvarchar](64) NULL,
	[subdivision_1_name] [nvarchar](64) NULL,
	[subdivision_2_iso_code] [nvarchar](64) NULL,
	[subdivision_2_name] [nvarchar](64) NULL,
	[city_name] [nvarchar](64) NULL,
	[metro_code] [nvarchar](32) NULL,
	[time_zone] [nvarchar](64) NULL,
 CONSTRAINT [PK_GeoLite2Locations] PRIMARY KEY CLUSTERED 
(
	geoname_id  ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

BULK INSERT GeoLite2Locations 
--FROM 'C:\dev\GeoLite2 Import\GeoLite2-City-CSV_20160301\GeoLite2-City-Locations-en.csv'
FROM 'C:\dev\GeoLite2 Import\GeoLite2-City-CSV_20160301\GeoLite2-City-Locations-en-UCS-2.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '0x0a'  --Use to shift the control to next row
) 

-- strip double quotes
UPDATE GeoLite2Locations SET continent_name = REPLACE(continent_name, '"', '')
UPDATE GeoLite2Locations SET country_name = REPLACE(country_name, '"', '')
UPDATE GeoLite2Locations SET city_name = REPLACE(city_name, '"', '')
UPDATE GeoLite2Locations SET subdivision_1_name = REPLACE(subdivision_1_name, '"', '')
UPDATE GeoLite2Locations SET subdivision_2_name = REPLACE(subdivision_2_name, '"', '')


