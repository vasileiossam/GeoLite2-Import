# GeoLite2 Import #

## Description ##

SQL Scripts for importing the Geolite2 City CSV files to SQL server

## How to import ###

1. Download the Geolite2 City CSV database from MaxMind: 
https://dev.maxmind.com/geoip/geoip2/geolite2/

2. Run functions.sql to get the conversion functions.

3. Modify the import sql scripts and set the correct path to the csv files.

4. Make sure that Import_GeoLite2-City-Locations.sql has imported all strings as unicode.
The only thing that worked for me was first to convert the GeoLite2-City-Locations file to UCS-2 encoding.
You can use Notepad++ to quickly do the conversion.

## Usage ##

```sql
DECLARE @IP bigint
SET @IP = dbo.IPAddressToInteger('198.142.186.148')

SELECT TOP 1 GeoLite2Locations.* FROM GeoLite2IPv4 
INNER JOIN GeoLite2Locations ON GeoLite2Locations.geoname_id = GeoLite2IPv4.geoname_id
WHERE @IP BETWEEN startIpNum AND endIpNum 
```
