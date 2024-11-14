CREATE TABLE [CO].[Products] (
    [Id]           INT             IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (255)  NOT NULL,
    [Price]        DECIMAL (10, 2) NOT NULL,
    [CategorySlug] NVARCHAR (255)  NOT NULL,
    [BrandSlug]    NVARCHAR (255)  NOT NULL,
    [Description]  NVARCHAR (MAX)  NOT NULL,
    [ProductSlug]  NVARCHAR (255)  NOT NULL,
    [Manual]       NVARCHAR (255)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IX_Products_BrandSlug]
    ON [CO].[Products]([BrandSlug] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_Products_CategorySlug]
    ON [CO].[Products]([CategorySlug] ASC);


GO

