IF OBJECT_ID('dbo.GeoLite2IPv6', 'U') IS NOT NULL DROP TABLE dbo.GeoLite2IPv6; 

CREATE TABLE GeoLite2IPv6 (
	[network] [nvarchar](64) NOT NULL,
	[geoname_id] [int] NULL,
	[registered_country_geoname_id] [int] NULL,
	[represented_country_geoname_id] [int] NULL,
	[is_anonymous_proxy] [int] NULL DEFAULT ((0)),
	[is_satellite_provider] [int] NULL DEFAULT ((0)),
	[postal_code] [nvarchar](16) NULL,
	[latitude] [decimal](9,6) NULL,
	[longitude] [decimal](9,6) NULL,
	[accuracy_radius] [int] NULL
 CONSTRAINT [PK_GeoLite2IPv6] PRIMARY KEY CLUSTERED 
(
	[network] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

BULK INSERT GeoLite2IPv6 
FROM 'C:\dev\GeoLite2 Import\GeoLite2-City-CSV_20160301\GeoLite2-City-Blocks-IPv6.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '0x0a'  --Use to shift the control to next row
) 

 
