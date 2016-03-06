# GeoLite2 Import #

## Description ##

Scripts for importing the Geolite2 City CSV files to SQL server

## How to import ###

1. Download the Geolite2 City CSV database from MaxMind: 
https://dev.maxmind.com/geoip/geoip2/geolite2/

2. Modify the import sql scripts and set the correct path to the csv files 

3. Make sure that Import_GeoLite2-City-Locations.sql has imported all strings as unicode.
The only thing that worked for me was first to convert the GeoLite2-City-Locations file to UCS-2 encoding.
Then BULK insert worked as expected. You can use Notepad++ to quickly do the conversion.

## Usage ##