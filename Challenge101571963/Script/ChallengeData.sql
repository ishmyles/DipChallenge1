﻿/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF '$(LoadTestData)' = 'true'

BEGIN

DELETE FROM CustOrder;
DELETE FROM Shipping;
DELETE FROM Product;
DELETE FROM Customer;
DELETE FROM Category;
DELETE FROM Region;
DELETE FROM Segment;

INSERT INTO Segment(SegID, SegName) VALUES
(1, 'Consumer'),
(2, 'Corporate'),
(3, 'Home Office');

INSERT INTO Region(Region) VALUES
('South'),
('Central'),
('West'),
('East'),
('North');

INSERT INTO Category(CatID, CatName) VALUES
(1, 'Furniture'),
(2, 'Office Supplies'),
(3, 'Technology');

INSERT INTO Shipping(ShipMode) VALUES
('Second Class'),
('Standard Class'),
('First Class'),
('Overnight Express');

INSERT INTO Product(ProdID, Description, UnitPrice, CatID) VALUES
('FUR-BO-10001798', 'Bush Somerset Collection Bookcase', $261.96, 1),
('FUR-CH-10000454', 'Mitel 5320 IP Phone VoIP phone', $731.94, 3),
('OFF-LA-10000240', 'Self-Adhesive Address Labels for Typewriters by Universal', $14.62, 2);

INSERT INTO Customer(CustID, FullName, Country, City, State, PostCode, SegID, Region) VALUES
('CG-12520', 'Claire Gute', 'United States', 'Henderson', 'Oklahoma', 42420, 1, 'Central'),
('DV-13045', 'Darrin Van Huff', 'United States', 'Los Angeles', 'California', 42420, 2, 'West'),
('SO-20335', 'Sean ODonnell', 'United States', 'Fort Lauderdale', 'Florida', 42420, 1, 'South'),
('BH-11710', 'Brosina Hoffman', 'United States', 'Los Angeles', 'California', 42420, 3, 'West');

INSERT INTO CustOrder(CustID, ProdID, OrderDate, Quantity, ShipDate, ShipMode) VALUES
(
	'CG-12520', 'FUR-BO-10001798',
	CONVERT(DATE, '08/11/2016', 103),
	2,
	CONVERT(DATE, '11/11/2016', 103),
	'Second Class'
),

(
	'CG-12520', 'FUR-CH-10000454',
	CONVERT(DATE, '08/11/2016', 103),
	3,
	CONVERT(DATE, '11/11/2016', 103),
	'Second Class'
),

(
	'CG-12520', 'OFF-LA-10000240',
	CONVERT(DATE, '12/06/2016', 103),
	2,
	CONVERT(DATE, '16/06/2016', 103),
	'Second Class'
),

(
	'DV-13045', 'OFF-LA-10000240',
	CONVERT(DATE, '21/11/2015', 103),
	2,
	CONVERT(DATE, '26/11/2015', 103),
	'Second Class'
),

(
	'DV-13045', 'OFF-LA-10000240',
	CONVERT(DATE, '11/10/2014', 103),
	1,
	CONVERT(DATE, '15/10/2014', 103),
	'Standard Class'
),

(
	'DV-13045', 'FUR-CH-10000454',
	CONVERT(DATE, '12/11/2016', 103),
	9,
	CONVERT(DATE, '16/11/2016', 103),
	'Standard Class'
),

(
	'SO-20335', 'OFF-LA-10000240',
	CONVERT(DATE, '02/09/2016', 103),
	5,
	CONVERT(DATE, '08/09/2016', 103),
	'Standard Class'
),

(
	'SO-20335', 'FUR-BO-10001798',
	CONVERT(DATE, '25/08/2017', 103),
	2,
	CONVERT(DATE, '28/08/2017', 103),
	'Overnight Express'
),

(
	'SO-20335', 'FUR-CH-10000454',
	CONVERT(DATE, '22/06/2017', 103),
	2,
	CONVERT(DATE, '26/06/2017', 103),
	'Standard Class'
),

(
	'SO-20335', 'FUR-BO-10001798',
	CONVERT(DATE, '01/05/2017', 103),
	3,
	CONVERT(DATE, '02/05/2017', 103),
	'First Class'
);

END;