USE [master]
GO
DROP DATABASE [tpch_workload_faster]
go
/****** Object:  Database [tpch_workload_faster] ******/
CREATE DATABASE [tpch_workload_faster]
ON  PRIMARY 
( NAME = N'tpch_workload_faster', FILENAME = N'/var/opt/mssql/data/tpch_workload_faster.mdf' , SIZE = 30Gb, MAXSIZE = UNLIMITED, FILEGROWTH = 1Gb )
 LOG ON 
( NAME = N'tpch_workload_faster_log', FILENAME = N'/var/opt/mssql/data/tpch_workload_faster_log.mdf' , SIZE = 10Gb , MAXSIZE = UNLIMITED, FILEGROWTH = 1Gb )
GO
USE [tpch_workload_faster]
GO
/****** Object:  Table [dbo].[CUSTOMER] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[C_CUSTKEY] [bigint] NOT NULL,
	[C_NAME] [varchar](25) NOT NULL,
	[C_ADDRESS] [varchar](40) NOT NULL,
	[C_NATIONKEY] [int] NOT NULL,
	[C_PHONE] [char](15) NOT NULL,
	[C_ACCTBAL] [decimal](12, 2) NOT NULL,
	[C_MKTSEGMENT] [char](10) NOT NULL,
	[C_COMMENT] [varchar](117) NOT NULL
)
GO
/****** Object:  Table [dbo].[LINEITEM] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEITEM](
	[L_ORDERKEY] [bigint] NOT NULL,
	[L_PARTKEY] [bigint] NOT NULL,
	[L_SUPPKEY] [bigint] NOT NULL,
	[L_LINENUMBER] [int] NOT NULL,
	[L_QUANTITY] [decimal](12, 2) NOT NULL,
	[L_EXTENDEDPRICE] [decimal](12, 2) NOT NULL,
	[L_DISCOUNT] [decimal](12, 2) NOT NULL,
	[L_TAX] [decimal](12, 2) NOT NULL,
	[L_RETURNFLAG] [char](1) NOT NULL,
	[L_LINESTATUS] [char](1) NOT NULL,
	[L_SHIPDATE] [date] NOT NULL,
	[L_COMMITDATE] [date] NOT NULL,
	[L_RECEIPTDATE] [date] NOT NULL,
	[L_SHIPINSTRUCT] [char](25) NOT NULL,
	[L_SHIPMODE] [char](10) NOT NULL,
	[L_COMMENT] [varchar](44) NOT NULL
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NATION](
	[N_NATIONKEY] [int] NOT NULL,
	[N_NAME] [char](25) NOT NULL,
	[N_REGIONKEY] [int] NOT NULL,
	[N_COMMENT] [varchar](152) NOT NULL
)
GO
/****** Object:  Table [dbo].[NEWPART] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NEWPART](
	[P_PARTKEY] [bigint] NOT NULL,
	[P_NAME] [varchar](55) NOT NULL,
	[P_MFGR] [char](25) NOT NULL,
	[P_BRAND] [char](10) NOT NULL,
	[P_TYPE] [varchar](25) NOT NULL,
	[P_SIZE] [int] NOT NULL,
	[P_CONTAINER] [char](10) NOT NULL,
	[P_RETAILPRICE] [decimal](12, 2) NOT NULL,
	[P_COMMENT] [varchar](23) NOT NULL
)
GO
/****** Object:  Table [dbo].[ORDERS] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDERS](
	[O_ORDERKEY] [bigint] NOT NULL,
	[O_CUSTKEY] [bigint] NOT NULL,
	[O_ORDERSTATUS] [char](1) NOT NULL,
	[O_TOTALPRICE] [decimal](12, 2) NOT NULL,
	[O_ORDERDATE] [date] NOT NULL,
	[O_ORDERPRIORITY] [char](15) NOT NULL,
	[O_CLERK] [char](15) NOT NULL,
	[O_SHIPPRIORITY] [int] NOT NULL,
	[O_COMMENT] [varchar](79) NOT NULL
)
GO
/****** Object:  Table [dbo].[PART] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PART](
	[P_PARTKEY] [bigint] NOT NULL,
	[P_NAME] [varchar](55) NOT NULL,
	[P_MFGR] [char](25) NOT NULL,
	[P_BRAND] [char](10) NOT NULL,
	[P_TYPE] [varchar](25) NOT NULL,
	[P_SIZE] [int] NOT NULL,
	[P_CONTAINER] [char](10) NOT NULL,
	[P_RETAILPRICE] [decimal](12, 2) NOT NULL,
	[P_COMMENT] [varchar](23) NOT NULL
)
GO
/****** Object:  Table [dbo].[PARTSUPP] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARTSUPP](
	[PS_PARTKEY] [bigint] NOT NULL,
	[PS_SUPPKEY] [bigint] NOT NULL,
	[PS_AVAILQTY] [int] NOT NULL,
	[PS_SUPPLYCOST] [decimal](12, 2) NOT NULL,
	[PS_COMMENT] [varchar](199) NOT NULL
)
GO
/****** Object:  Table [dbo].[REGION] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGION](
	[R_REGIONKEY] [int] NOT NULL,
	[R_NAME] [char](25) NOT NULL,
	[R_COMMENT] [varchar](152) NOT NULL
)
GO
/****** Object:  Table [dbo].[SUPPLIER] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUPPLIER](
	[S_SUPPKEY] [bigint] NOT NULL,
	[S_NAME] [char](25) NOT NULL,
	[S_ADDRESS] [varchar](40) NOT NULL,
	[S_NATIONKEY] [int] NOT NULL,
	[S_PHONE] [char](15) NOT NULL,
	[S_ACCTBAL] [decimal](12, 2) NOT NULL,
	[S_COMMENT] [varchar](101) NOT NULL
)
GO
/****** Object:  StoredProcedure [dbo].[avg_qty_by_mfgr] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[avg_qty_by_mfgr] @p_type varchar(25)
as
select avg(L_QUANTITY), P_MFGR from NEWPART
join LINEITEM
ON NEWPART.P_PARTKEY = LINEITEM.L_PARTKEY
where P_TYPE = @p_type
GROUP BY P_MFGR
GO
USE [master]
GO
ALTER DATABASE [tpch_workload_faster] SET  READ_WRITE 
GO