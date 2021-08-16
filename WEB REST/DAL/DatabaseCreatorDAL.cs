using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace DAL
{

   public class DatabaseCreatorDAL
    {
       dbConnection connection = new dbConnection();

       public bool ExistWebRestTablesInDatabse()
       {
           bool exists;
           try
           {
               // ANSI SQL way.  Works in PostgreSQL, MSSQL, MySQL.  
               string query = "select case when exists((select * from information_schema.tables where table_name = 'wr_Users')) then 1 else 0 end";
               SqlParameter[] paramArray=new SqlParameter[0];
               DataTable dtResult = connection.executeSelectQuery(query, paramArray);
               if (Convert.ToInt32(dtResult.Rows[0][0]) ==1 )
                   exists = true;
               else

                   exists = false;
               return exists;
           }
           catch (Exception)
           {
               try
               {

               
               string query = "select 1 from wr_Users where 1 = 0";
               SqlParameter[] paramArray = new SqlParameter[0];
               DataTable dtResult = connection.executeSelectQuery(query, paramArray);
               exists = true;
               return exists;
               }
               catch (Exception)
               {

                   exists = false;
                   return exists;
               }
           }
       }
       public bool CreateWebRestTablesInDatabase()
       {
           try
           {
               string query = @"CREATE TABLE [dbo].[wr_Users](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[lgn_barcode] [nvarchar](8) NOT NULL,
	[lgn_UserName] [nvarchar](50) NOT NULL,
	[lgn_Password] [nvarchar](20) NULL,
 CONSTRAINT [PK_NW_webLogin] PRIMARY KEY CLUSTERED 
(
	[lgn_UserName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[wr_DynamicReserveRange](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DynamicReservRange_FromDateType] [int] NULL,
	[DynamicReservRange_FromDateCount] [int] NULL,
 CONSTRAINT [PK_wr_DynamicReserveRange] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[wr_Page](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[page_name] [varchar](20) NULL,
	[page_bannerAdd] [varchar](60) NULL,
	[page_helpAdd] [varchar](60) NULL,
	[page_newsAdd] [varchar](60) NULL,
 CONSTRAINT [PK_wr_Page] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[wr_ReserveRange](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ReservRange_EndDateCount] [int] NULL,
	[ReservRange_EndDateType] [int] NULL,
	[ReservRange_Mokhalafat] [bit] NULL,
	[ReservRange_SAGHFRESERVE] [int] NULL,
 CONSTRAINT [PK_wr_ReserveRange] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[wr_StaticReserveRange](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[StaticReservRange_FromDay] [int] NULL,
	[StaticReservRange_ToDay] [int] NULL,
 CONSTRAINT [PK_wr_StaticReserveRange] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
CREATE TABLE [dbo].[wr_PublicMessage](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](1000) NULL,
	[DateMessage] [datetime] NULL,
 CONSTRAINT [PK_wr_PublicMessage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Insert Into wr_Users (lgn_barcode,lgn_UserName,lgn_Password) Values ('admin','admin','G' )";
               SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cnnWebRest"].ConnectionString);
               conn.Open();
               SqlCommand cmd = new SqlCommand(query, conn);
               cmd.ExecuteNonQuery();
               conn.Close();
               return true;

           }
           catch (Exception ex)
           {
               
               throw ex;
           }
       }

    }
}
