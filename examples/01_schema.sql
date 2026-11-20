IF DB_ID('LabDB') IS NULL
    CREATE DATABASE LabDB;
GO

USE LabDB;
GO

CREATE TABLE dbo.customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(120) NOT NULL,
    country CHAR(2) NOT NULL,
    created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES dbo.customers(id),
    total DECIMAL(12,2) NOT NULL CHECK (total >= 0),
    ordered_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE INDEX idx_orders_customer ON dbo.orders(customer_id);
