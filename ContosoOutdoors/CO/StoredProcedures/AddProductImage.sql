-- insert a new product image into the database
CREATE PROCEDURE CO.AddProductImage
	@ProductId INT,
	@ImageUri NVARCHAR(255)
AS
	SET NOCOUNT ON

	INSERT INTO CO.ProductImages (ProductId, ImageUri)
	VALUES (@ProductId, @ImageUri)

	SELECT SCOPE_IDENTITY() AS ImageId
RETURN 0

GO

