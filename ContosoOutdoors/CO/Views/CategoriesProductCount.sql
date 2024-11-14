CREATE VIEW CO.CategoriesProductCount
	AS SELECT Cat.CategorySlug
		, Cat.CategoryName
		, Cat.Description
		, COUNT(*) AS ProductCount

	FROM CO.Categories Cat
	INNER JOIN CO.Products Prod ON Cat.CategorySlug = Prod.CategorySlug

	GROUP BY Cat.CategorySlug, Cat.CategoryName, Cat.Description;

GO

