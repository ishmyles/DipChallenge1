﻿CREATE TABLE [dbo].[Product]
(
	[ProdID] NVARCHAR(20) NOT NULL,
	[Description] NVARCHAR(60) NOT NULL,
	[UnitPrice] MONEY NOT NULL,
	[CatID] INT NOT NULL,
	CONSTRAINT PK_PRODUCT PRIMARY KEY (ProdID),
	CONSTRAINT FK_PRODUCT_CAT FOREIGN KEY (CatID) REFERENCES Category(CatID)
)
