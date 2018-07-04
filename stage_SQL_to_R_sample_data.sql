/*
-- Testing Import of Nullable values in R environment
-- Author: Tomaz Kastrun; 04.07.2018
-- Blog: tomaztsql.wordpress.com


*/

USE AzureLanding;
GO

CREATE TABLE R_Nullables
 (
  ID INT IDENTITY(1,1) NOT NULL
 ,num1 FLOAT
 ,num2 DECIMAL(20,10)
 ,num3 INT
 ,tex1 NVARCHAR(MAX)
 ,tex2 VARCHAR(100)
 ,bin1 VARBINARY(MAX)
 )


INSERT INTO R_Nullables
		  SELECT 1.22, 21.535, 245, 'This is Nvarchar text','Varchar text',0x0342342
UNION ALL SELECT 3.4534, 25.5, 45, 'This another Nvarchar text','Varchar text 2',0x03423e3434tg
UNION ALL SELECT NULL, NULL, NULL, NULL,NULL,NULL
UNION ALL SELECT 0, 0, 0, '','',0x


SELECT ID ,num1 ,num2 ,num3 ,tex1 ,tex2 FROM R_Nullables