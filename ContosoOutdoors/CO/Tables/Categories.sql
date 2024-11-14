CREATE TABLE [CO].[Categories] (
    [CategorySlug] NVARCHAR (255) NOT NULL,
    [CategoryName] NVARCHAR (255) NOT NULL,
    [Description]  NVARCHAR (MAX) NOT NULL,
    [IsHighlighted] BIT NOT NULL,
    PRIMARY KEY CLUSTERED ([CategorySlug] ASC)
);


GO

