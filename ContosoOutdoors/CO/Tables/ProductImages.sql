CREATE TABLE [CO].[ProductImages] (
    [ImageId]   INT            IDENTITY (1, 1) NOT NULL,
    [ProductId] INT            NOT NULL,
    [ImageUri]  NVARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([ImageId] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IX_ProductImages_ProductId]
    ON [CO].[ProductImages]([ProductId] ASC)
    INCLUDE([ImageUri]);


GO

