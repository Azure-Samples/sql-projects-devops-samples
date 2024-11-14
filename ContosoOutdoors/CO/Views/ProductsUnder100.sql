CREATE VIEW CO.ProductsUnder100
	AS SELECT Id, Name, Price, CategorySlug, BrandSlug, Description, ProductSlug, Manual
	FROM CO.Products WHERE Price < 100.0;

GO

