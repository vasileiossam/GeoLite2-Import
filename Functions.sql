IF EXISTS (SELECT 1 FROM Information_schema.Routines WHERE Specific_schema = 'dbo' AND specific_name = 'IPAddressToInteger' AND Routine_Type = 'FUNCTION') 
	DROP FUNCTION dbo.IPAddressToInteger
GO

-- http://www.aboutmyip.com/AboutMyXApp/IP2Integer.jsp
CREATE FUNCTION dbo.IPAddressToInteger(@IP varchar(15))
RETURNS bigint
AS
BEGIN
	DECLARE @num bigint

	SET @num = 
		CONVERT(bigint, PARSENAME(@IP, 4)) * 256 * 256 * 256 +
		CONVERT(bigint, PARSENAME(@IP, 3)) * 256 * 256 +
		CONVERT(bigint, PARSENAME(@IP, 2)) * 256 +
		CONVERT(bigint, PARSENAME(@IP, 1))

	RETURN (@num)
END
GO

IF EXISTS (SELECT 1 FROM Information_schema.Routines WHERE Specific_schema = 'dbo' AND specific_name = 'GetStartIp' AND Routine_Type = 'FUNCTION') 
	DROP FUNCTION dbo.GetStartIp
GO

--
-- Kudos to http://bitmugger.blogspot.com.au/2011/02/how-to-convert-cidr-ip-address-to-range.html
--
CREATE FUNCTION dbo.GetStartIp(@CidrIP varchar(64))
RETURNS bigint
AS
BEGIN
	DECLARE @num bigint
	SET @num = dbo.IPAddressToInteger(LEFT(@CidrIP, patindex('%/%' , @CidrIP) - 1)) & (cast(4294967295 as bigint) ^ (Power(2, 32 - Cast(substring(@CidrIP, patindex('%/%' , @CidrIP) + 1, 2) as int)) - 1))
	RETURN @num
END
GO

IF EXISTS (SELECT 1 FROM Information_schema.Routines WHERE Specific_schema = 'dbo' AND specific_name = 'GetEndIp' AND Routine_Type = 'FUNCTION') 
	DROP FUNCTION dbo.GetEndIp
GO

--
-- Kudos to http://bitmugger.blogspot.com.au/2011/02/how-to-convert-cidr-ip-address-to-range.html
--
CREATE FUNCTION dbo.GetEndIp(@StartIp bigint, @CidrIP varchar(64))
RETURNS bigint
AS
BEGIN
	DECLARE @num bigint
	SET @num = @StartIp + (Power(2, 32 - Cast(substring(@CidrIP, patindex('%/%' , @CidrIP) + 1, 2) as int)) - 1) 
	RETURN @num
END
GO
