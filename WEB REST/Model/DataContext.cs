using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Data;
using System.Reflection;
using System.Linq.Expressions;
using System.ComponentModel;

namespace Model
{


	
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="rest2")]
	public partial class FoodReserveDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void Insertfoodlist(foodlist instance);
    partial void Updatefoodlist(foodlist instance);
    partial void Deletefoodlist(foodlist instance);
    partial void Insertwr_DynamicReserveRange(wr_DynamicReserveRange instance);
    partial void Updatewr_DynamicReserveRange(wr_DynamicReserveRange instance);
    partial void Deletewr_DynamicReserveRange(wr_DynamicReserveRange instance);
    partial void Insertwr_ReserveRange(wr_ReserveRange instance);
    partial void Updatewr_ReserveRange(wr_ReserveRange instance);
    partial void Deletewr_ReserveRange(wr_ReserveRange instance);
    partial void Insertwr_User(wr_User instance);
    partial void Updatewr_User(wr_User instance);
    partial void Deletewr_User(wr_User instance);
    partial void Insertwr_PublicMessage(wr_PublicMessage instance);
    partial void Updatewr_PublicMessage(wr_PublicMessage instance);
    partial void Deletewr_PublicMessage(wr_PublicMessage instance);
    partial void Insertfishfood(fishfood instance);
    partial void Updatefishfood(fishfood instance);
    partial void Deletefishfood(fishfood instance);
    #endregion
		
		public FoodReserveDataContext() :
        base(System.Configuration.ConfigurationManager.ConnectionStrings["cnnWebRest"].ToString(), mappingSource)
		{
			OnCreated();
		}
		
        //public FoodReserveDataContext(string connection) : 
        //        base(connection, mappingSource)
        //{
        //    OnCreated();
        //}
		
        //public FoodReserveDataContext(System.Data.IDbConnection connection) : 
        //        base(connection, mappingSource)
        //{
        //    OnCreated();
        //}
		
        //public FoodReserveDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
        //        base(connection, mappingSource)
        //{
        //    OnCreated();
        //}
		
        //public FoodReserveDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
        //        base(connection, mappingSource)
        //{
        //    OnCreated();
        //}
		
		public System.Data.Linq.Table<person> persons
		{
			get
			{
				return this.GetTable<person>();
			}
		}
		
		public System.Data.Linq.Table<week> weeks
		{
			get
			{
				return this.GetTable<week>();
			}
		}
		
		public System.Data.Linq.Table<group> groups
		{
			get
			{
				return this.GetTable<group>();
			}
		}
		
		public System.Data.Linq.Table<foodlist> foodlists
		{
			get
			{
				return this.GetTable<foodlist>();
			}
		}
		
		public System.Data.Linq.Table<prgpr> prgprs
		{
			get
			{
				return this.GetTable<prgpr>();
			}
		}
		
		public System.Data.Linq.Table<building> buildings
		{
			get
			{
				return this.GetTable<building>();
			}
		}
		
		public System.Data.Linq.Table<foodpric> foodprics
		{
			get
			{
				return this.GetTable<foodpric>();
			}
		}
		
		public System.Data.Linq.Table<wr_DynamicReserveRange> wr_DynamicReserveRanges
		{
			get
			{
				return this.GetTable<wr_DynamicReserveRange>();
			}
		}
		
		public System.Data.Linq.Table<wr_ReserveRange> wr_ReserveRanges
		{
			get
			{
				return this.GetTable<wr_ReserveRange>();
			}
		}
		
		public System.Data.Linq.Table<wr_User> wr_Users
		{
			get
			{
				return this.GetTable<wr_User>();
			}
		}
		
		public System.Data.Linq.Table<wr_PublicMessage> wr_PublicMessages
		{
			get
			{
				return this.GetTable<wr_PublicMessage>();
			}
		}
		
		public System.Data.Linq.Table<fish> fishes
		{
			get
			{
				return this.GetTable<fish>();
			}
		}
		
		public System.Data.Linq.Table<fishfood> fishfoods
		{
			get
			{
				return this.GetTable<fishfood>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.persons")]
	public partial class person
	{
        public readonly string tableName="persons";
		private string _P_BarCode;
		
		private string _P_Proxi;
        
		private string _P_Estekhdami;
		
		private string _P_Name;
		
		private string _P_Family;
		
		private string _P_Father;
		
		private string _P_IDNo;
		
		private string _P_MeliCode;
		
		private string _P_FromPlace;
		
		private string _P_BirthDate;
		
		private string _P_BirthPlace;
		
		private string _P_Madrak;
		
		private string _P_Curse;
		
		private System.Nullable<short> _P_Sex;
		
		private System.Nullable<short> _P_Marry;
		
		private System.Nullable<short> _P_Military;
		
		private string _P_Address;
		
		private string _P_Tel;
		
		private string _P_Domain;
		
		private string _P_ADUserName;
		
		private System.Nullable<short> _P_Param;
		
		private string _P_Picture;
		
		private System.Nullable<int> _P_Part1;
		
		private System.Nullable<int> _P_Part2;
		
		private System.Nullable<int> _P_Part3;
		
		private System.Nullable<int> _P_Part4;
		
		private string _P_Parts;
		
		private System.Nullable<short> _P_JobCode;
		
		private System.Nullable<int> _P_CoPosts;
		
		private System.Nullable<short> _P_Station;
		
		private string _P_JobDate;
		
		private string _P_EndJobDate;
		
		private System.Nullable<short> _P_ShiftGroup;
		
		private System.Nullable<short> _P_RuleGroup;
		
		private System.Nullable<short> _P_ShiftGroupM;
		
		private string _P_Vaz;
		
		private string _P_Reserve1;
		
		private string _P_Reserve2;
		
		private string _P_Reserve3;
		
		private string _P_Reserve4;
		
		private string _P_Reserve5;
		
		private string _P_Reserve6;
		
		private string _P_reserve7;
		
		private string _P_reserve8;
		
		private System.Nullable<bool> _P_IsValid;
		
		private System.Nullable<bool> _P_IsValidweb;
		
		private System.Nullable<bool> _P_ValidTest;
		
		private System.Nullable<bool> _P_Pricable;
		
		private System.Nullable<bool> _P_PrePaid;
		
		private System.Nullable<decimal> _P_Credit;
		
		private System.Nullable<bool> _P_Sobhaneh;
		
		private System.Nullable<bool> _P_Nahar;
		
		private System.Nullable<bool> _P_Sham;
		
		private System.Nullable<bool> _P_NextSobhaneh;
		
		private System.Nullable<bool> _P_Rejim;
		
		private System.Nullable<bool> _P_IsGuest;
		
		private System.Nullable<short> _P_Special;
		
		private System.Nullable<short> _P_ManyFish;
		
		private string _P_EtebarFish;
		
		private System.Nullable<short> _P_dblFoodMax;
		
		private System.Nullable<bool> _P_DblFood;
		
		private System.Nullable<short> _P_CashType;
		
		private System.Nullable<bool> _P_DeserNoFood;
		
		private System.Nullable<short> _P_Building;
		
		private System.Nullable<short> _P_service;
		
		private string _P_Sabegheh;
		
		private System.Nullable<short> _P_MntFoodMax;
		
		private System.Nullable<bool> _P_MntFood;
		
		public person()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_BarCode", DbType="NVarChar(8) NOT NULL", CanBeNull=false)]
		public string P_BarCode
		{
			get
			{
				return this._P_BarCode;
			}
			set
			{
				if ((this._P_BarCode != value))
				{
					this._P_BarCode = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Proxi", DbType="NVarChar(8) NOT NULL", CanBeNull=false)]
		public string P_Proxi
		{
			get
			{
				return this._P_Proxi;
			}
			set
			{
				if ((this._P_Proxi != value))
				{
					this._P_Proxi = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Estekhdami", DbType="NVarChar(12)")]
		public string P_Estekhdami
		{
			get
			{
				return this._P_Estekhdami;
			}
			set
			{
				if ((this._P_Estekhdami != value))
				{
					this._P_Estekhdami = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Name", DbType="NVarChar(15)")]
		public string P_Name
		{
			get
			{
				return this._P_Name;
			}
			set
			{
				if ((this._P_Name != value))
				{
					this._P_Name = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Family", DbType="NVarChar(25)")]
		public string P_Family
		{
			get
			{
				return this._P_Family;
			}
			set
			{
				if ((this._P_Family != value))
				{
					this._P_Family = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Father", DbType="NVarChar(15)")]
		public string P_Father
		{
			get
			{
				return this._P_Father;
			}
			set
			{
				if ((this._P_Father != value))
				{
					this._P_Father = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_IDNo", DbType="NVarChar(20)")]
		public string P_IDNo
		{
			get
			{
				return this._P_IDNo;
			}
			set
			{
				if ((this._P_IDNo != value))
				{
					this._P_IDNo = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_MeliCode", DbType="NVarChar(20)")]
		public string P_MeliCode
		{
			get
			{
				return this._P_MeliCode;
			}
			set
			{
				if ((this._P_MeliCode != value))
				{
					this._P_MeliCode = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_FromPlace", DbType="NVarChar(15)")]
		public string P_FromPlace
		{
			get
			{
				return this._P_FromPlace;
			}
			set
			{
				if ((this._P_FromPlace != value))
				{
					this._P_FromPlace = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_BirthDate", DbType="NVarChar(10)")]
		public string P_BirthDate
		{
			get
			{
				return this._P_BirthDate;
			}
			set
			{
				if ((this._P_BirthDate != value))
				{
					this._P_BirthDate = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_BirthPlace", DbType="NVarChar(15)")]
		public string P_BirthPlace
		{
			get
			{
				return this._P_BirthPlace;
			}
			set
			{
				if ((this._P_BirthPlace != value))
				{
					this._P_BirthPlace = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Madrak", DbType="NVarChar(20)")]
		public string P_Madrak
		{
			get
			{
				return this._P_Madrak;
			}
			set
			{
				if ((this._P_Madrak != value))
				{
					this._P_Madrak = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Curse", DbType="NVarChar(30)")]
		public string P_Curse
		{
			get
			{
				return this._P_Curse;
			}
			set
			{
				if ((this._P_Curse != value))
				{
					this._P_Curse = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Sex", DbType="SmallInt")]
		public System.Nullable<short> P_Sex
		{
			get
			{
				return this._P_Sex;
			}
			set
			{
				if ((this._P_Sex != value))
				{
					this._P_Sex = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Marry", DbType="SmallInt")]
		public System.Nullable<short> P_Marry
		{
			get
			{
				return this._P_Marry;
			}
			set
			{
				if ((this._P_Marry != value))
				{
					this._P_Marry = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Military", DbType="SmallInt")]
		public System.Nullable<short> P_Military
		{
			get
			{
				return this._P_Military;
			}
			set
			{
				if ((this._P_Military != value))
				{
					this._P_Military = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Address", DbType="NVarChar(80)")]
		public string P_Address
		{
			get
			{
				return this._P_Address;
			}
			set
			{
				if ((this._P_Address != value))
				{
					this._P_Address = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Tel", DbType="NVarChar(20)")]
		public string P_Tel
		{
			get
			{
				return this._P_Tel;
			}
			set
			{
				if ((this._P_Tel != value))
				{
					this._P_Tel = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Domain", DbType="NVarChar(50)")]
		public string P_Domain
		{
			get
			{
				return this._P_Domain;
			}
			set
			{
				if ((this._P_Domain != value))
				{
					this._P_Domain = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_ADUserName", DbType="NVarChar(50)")]
		public string P_ADUserName
		{
			get
			{
				return this._P_ADUserName;
			}
			set
			{
				if ((this._P_ADUserName != value))
				{
					this._P_ADUserName = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Param", DbType="SmallInt")]
		public System.Nullable<short> P_Param
		{
			get
			{
				return this._P_Param;
			}
			set
			{
				if ((this._P_Param != value))
				{
					this._P_Param = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Picture", DbType="NVarChar(255)")]
		public string P_Picture
		{
			get
			{
				return this._P_Picture;
			}
			set
			{
				if ((this._P_Picture != value))
				{
					this._P_Picture = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Part1", DbType="Int")]
		public System.Nullable<int> P_Part1
		{
			get
			{
				return this._P_Part1;
			}
			set
			{
				if ((this._P_Part1 != value))
				{
					this._P_Part1 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Part2", DbType="Int")]
		public System.Nullable<int> P_Part2
		{
			get
			{
				return this._P_Part2;
			}
			set
			{
				if ((this._P_Part2 != value))
				{
					this._P_Part2 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Part3", DbType="Int")]
		public System.Nullable<int> P_Part3
		{
			get
			{
				return this._P_Part3;
			}
			set
			{
				if ((this._P_Part3 != value))
				{
					this._P_Part3 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Part4", DbType="Int")]
		public System.Nullable<int> P_Part4
		{
			get
			{
				return this._P_Part4;
			}
			set
			{
				if ((this._P_Part4 != value))
				{
					this._P_Part4 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Parts", DbType="NVarChar(255)")]
		public string P_Parts
		{
			get
			{
				return this._P_Parts;
			}
			set
			{
				if ((this._P_Parts != value))
				{
					this._P_Parts = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_JobCode", DbType="SmallInt")]
		public System.Nullable<short> P_JobCode
		{
			get
			{
				return this._P_JobCode;
			}
			set
			{
				if ((this._P_JobCode != value))
				{
					this._P_JobCode = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_CoPosts", DbType="Int")]
		public System.Nullable<int> P_CoPosts
		{
			get
			{
				return this._P_CoPosts;
			}
			set
			{
				if ((this._P_CoPosts != value))
				{
					this._P_CoPosts = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Station", DbType="SmallInt")]
		public System.Nullable<short> P_Station
		{
			get
			{
				return this._P_Station;
			}
			set
			{
				if ((this._P_Station != value))
				{
					this._P_Station = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_JobDate", DbType="NVarChar(10)")]
		public string P_JobDate
		{
			get
			{
				return this._P_JobDate;
			}
			set
			{
				if ((this._P_JobDate != value))
				{
					this._P_JobDate = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_EndJobDate", DbType="NVarChar(10)")]
		public string P_EndJobDate
		{
			get
			{
				return this._P_EndJobDate;
			}
			set
			{
				if ((this._P_EndJobDate != value))
				{
					this._P_EndJobDate = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_ShiftGroup", DbType="SmallInt")]
		public System.Nullable<short> P_ShiftGroup
		{
			get
			{
				return this._P_ShiftGroup;
			}
			set
			{
				if ((this._P_ShiftGroup != value))
				{
					this._P_ShiftGroup = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_RuleGroup", DbType="SmallInt")]
		public System.Nullable<short> P_RuleGroup
		{
			get
			{
				return this._P_RuleGroup;
			}
			set
			{
				if ((this._P_RuleGroup != value))
				{
					this._P_RuleGroup = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_ShiftGroupM", DbType="SmallInt")]
		public System.Nullable<short> P_ShiftGroupM
		{
			get
			{
				return this._P_ShiftGroupM;
			}
			set
			{
				if ((this._P_ShiftGroupM != value))
				{
					this._P_ShiftGroupM = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Vaz", DbType="NVarChar(20)")]
		public string P_Vaz
		{
			get
			{
				return this._P_Vaz;
			}
			set
			{
				if ((this._P_Vaz != value))
				{
					this._P_Vaz = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Reserve1", DbType="NVarChar(50)")]
		public string P_Reserve1
		{
			get
			{
				return this._P_Reserve1;
			}
			set
			{
				if ((this._P_Reserve1 != value))
				{
					this._P_Reserve1 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Reserve2", DbType="NVarChar(50)")]
		public string P_Reserve2
		{
			get
			{
				return this._P_Reserve2;
			}
			set
			{
				if ((this._P_Reserve2 != value))
				{
					this._P_Reserve2 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Reserve3", DbType="NVarChar(50)")]
		public string P_Reserve3
		{
			get
			{
				return this._P_Reserve3;
			}
			set
			{
				if ((this._P_Reserve3 != value))
				{
					this._P_Reserve3 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Reserve4", DbType="NVarChar(50)")]
		public string P_Reserve4
		{
			get
			{
				return this._P_Reserve4;
			}
			set
			{
				if ((this._P_Reserve4 != value))
				{
					this._P_Reserve4 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Reserve5", DbType="NVarChar(50)")]
		public string P_Reserve5
		{
			get
			{
				return this._P_Reserve5;
			}
			set
			{
				if ((this._P_Reserve5 != value))
				{
					this._P_Reserve5 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Reserve6", DbType="NVarChar(50)")]
		public string P_Reserve6
		{
			get
			{
				return this._P_Reserve6;
			}
			set
			{
				if ((this._P_Reserve6 != value))
				{
					this._P_Reserve6 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_reserve7", DbType="NVarChar(20)")]
		public string P_reserve7
		{
			get
			{
				return this._P_reserve7;
			}
			set
			{
				if ((this._P_reserve7 != value))
				{
					this._P_reserve7 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_reserve8", DbType="NVarChar(20)")]
		public string P_reserve8
		{
			get
			{
				return this._P_reserve8;
			}
			set
			{
				if ((this._P_reserve8 != value))
				{
					this._P_reserve8 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_IsValid", DbType="Bit")]
		public System.Nullable<bool> P_IsValid
		{
			get
			{
				return this._P_IsValid;
			}
			set
			{
				if ((this._P_IsValid != value))
				{
					this._P_IsValid = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_IsValidweb", DbType="Bit")]
		public System.Nullable<bool> P_IsValidweb
		{
			get
			{
				return this._P_IsValidweb;
			}
			set
			{
				if ((this._P_IsValidweb != value))
				{
					this._P_IsValidweb = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_ValidTest", DbType="Bit")]
		public System.Nullable<bool> P_ValidTest
		{
			get
			{
				return this._P_ValidTest;
			}
			set
			{
				if ((this._P_ValidTest != value))
				{
					this._P_ValidTest = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Pricable", DbType="Bit")]
		public System.Nullable<bool> P_Pricable
		{
			get
			{
				return this._P_Pricable;
			}
			set
			{
				if ((this._P_Pricable != value))
				{
					this._P_Pricable = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_PrePaid", DbType="Bit")]
		public System.Nullable<bool> P_PrePaid
		{
			get
			{
				return this._P_PrePaid;
			}
			set
			{
				if ((this._P_PrePaid != value))
				{
					this._P_PrePaid = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Credit", DbType="Money")]
		public System.Nullable<decimal> P_Credit
		{
			get
			{
				return this._P_Credit;
			}
			set
			{
				if ((this._P_Credit != value))
				{
					this._P_Credit = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Sobhaneh", DbType="Bit")]
		public System.Nullable<bool> P_Sobhaneh
		{
			get
			{
				return this._P_Sobhaneh;
			}
			set
			{
				if ((this._P_Sobhaneh != value))
				{
					this._P_Sobhaneh = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Nahar", DbType="Bit")]
		public System.Nullable<bool> P_Nahar
		{
			get
			{
				return this._P_Nahar;
			}
			set
			{
				if ((this._P_Nahar != value))
				{
					this._P_Nahar = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Sham", DbType="Bit")]
		public System.Nullable<bool> P_Sham
		{
			get
			{
				return this._P_Sham;
			}
			set
			{
				if ((this._P_Sham != value))
				{
					this._P_Sham = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_NextSobhaneh", DbType="Bit")]
		public System.Nullable<bool> P_NextSobhaneh
		{
			get
			{
				return this._P_NextSobhaneh;
			}
			set
			{
				if ((this._P_NextSobhaneh != value))
				{
					this._P_NextSobhaneh = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Rejim", DbType="Bit")]
		public System.Nullable<bool> P_Rejim
		{
			get
			{
				return this._P_Rejim;
			}
			set
			{
				if ((this._P_Rejim != value))
				{
					this._P_Rejim = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_IsGuest", DbType="Bit")]
		public System.Nullable<bool> P_IsGuest
		{
			get
			{
				return this._P_IsGuest;
			}
			set
			{
				if ((this._P_IsGuest != value))
				{
					this._P_IsGuest = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Special", DbType="SmallInt")]
		public System.Nullable<short> P_Special
		{
			get
			{
				return this._P_Special;
			}
			set
			{
				if ((this._P_Special != value))
				{
					this._P_Special = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_ManyFish", DbType="SmallInt")]
		public System.Nullable<short> P_ManyFish
		{
			get
			{
				return this._P_ManyFish;
			}
			set
			{
				if ((this._P_ManyFish != value))
				{
					this._P_ManyFish = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_EtebarFish", DbType="NVarChar(10)")]
		public string P_EtebarFish
		{
			get
			{
				return this._P_EtebarFish;
			}
			set
			{
				if ((this._P_EtebarFish != value))
				{
					this._P_EtebarFish = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_dblFoodMax", DbType="SmallInt")]
		public System.Nullable<short> P_dblFoodMax
		{
			get
			{
				return this._P_dblFoodMax;
			}
			set
			{
				if ((this._P_dblFoodMax != value))
				{
					this._P_dblFoodMax = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_DblFood", DbType="Bit")]
		public System.Nullable<bool> P_DblFood
		{
			get
			{
				return this._P_DblFood;
			}
			set
			{
				if ((this._P_DblFood != value))
				{
					this._P_DblFood = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_CashType", DbType="SmallInt")]
		public System.Nullable<short> P_CashType
		{
			get
			{
				return this._P_CashType;
			}
			set
			{
				if ((this._P_CashType != value))
				{
					this._P_CashType = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_DeserNoFood", DbType="Bit")]
		public System.Nullable<bool> P_DeserNoFood
		{
			get
			{
				return this._P_DeserNoFood;
			}
			set
			{
				if ((this._P_DeserNoFood != value))
				{
					this._P_DeserNoFood = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Building", DbType="SmallInt")]
		public System.Nullable<short> P_Building
		{
			get
			{
				return this._P_Building;
			}
			set
			{
				if ((this._P_Building != value))
				{
					this._P_Building = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_service", DbType="SmallInt")]
		public System.Nullable<short> P_service
		{
			get
			{
				return this._P_service;
			}
			set
			{
				if ((this._P_service != value))
				{
					this._P_service = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_Sabegheh", DbType="NVarChar(8)")]
		public string P_Sabegheh
		{
			get
			{
				return this._P_Sabegheh;
			}
			set
			{
				if ((this._P_Sabegheh != value))
				{
					this._P_Sabegheh = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_MntFoodMax", DbType="SmallInt")]
		public System.Nullable<short> P_MntFoodMax
		{
			get
			{
				return this._P_MntFoodMax;
			}
			set
			{
				if ((this._P_MntFoodMax != value))
				{
					this._P_MntFoodMax = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_P_MntFood", DbType="Bit")]
		public System.Nullable<bool> P_MntFood
		{
			get
			{
				return this._P_MntFood;
			}
			set
			{
				if ((this._P_MntFood != value))
				{
					this._P_MntFood = value;
				}
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.week")]
	public partial class week
	{
		
		private string _Week_Date;
		
		private System.Nullable<short> _Week_Type;
		
		private System.Nullable<short> _Week_Key1;
		
		private System.Nullable<short> _Week_Key2;
		
		private System.Nullable<short> _Week_Key3;
		
		private System.Nullable<short> _Week_Key4;
		
		private System.Nullable<short> _Week_Key5;
		
		private System.Nullable<short> _Week_Key6;
		
		private System.Nullable<short> _Week_Key7;
		
		private System.Nullable<short> _Week_Key8;
		
		private System.Nullable<short> _Week_Key9;
		
		private System.Nullable<short> _Week_Key0;
		
		private System.Nullable<short> _Week_N1;
		
		private System.Nullable<short> _Week_N2;
		
		private System.Nullable<short> _Week_N3;
		
		private System.Nullable<short> _Week_N4;
		
		private System.Nullable<short> _Week_N5;
		
		private System.Nullable<short> _Week_N6;
		
		private System.Nullable<short> _Week_N7;
		
		private System.Nullable<short> _Week_N8;
		
		public week()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Date", DbType="NVarChar(10)")]
		public string Week_Date
		{
			get
			{
				return this._Week_Date;
			}
			set
			{
				if ((this._Week_Date != value))
				{
					this._Week_Date = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Type", DbType="SmallInt")]
		public System.Nullable<short> Week_Type
		{
			get
			{
				return this._Week_Type;
			}
			set
			{
				if ((this._Week_Type != value))
				{
					this._Week_Type = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key1", DbType="SmallInt")]
		public System.Nullable<short> Week_Key1
		{
			get
			{
				return this._Week_Key1;
			}
			set
			{
				if ((this._Week_Key1 != value))
				{
					this._Week_Key1 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key2", DbType="SmallInt")]
		public System.Nullable<short> Week_Key2
		{
			get
			{
				return this._Week_Key2;
			}
			set
			{
				if ((this._Week_Key2 != value))
				{
					this._Week_Key2 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key3", DbType="SmallInt")]
		public System.Nullable<short> Week_Key3
		{
			get
			{
				return this._Week_Key3;
			}
			set
			{
				if ((this._Week_Key3 != value))
				{
					this._Week_Key3 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key4", DbType="SmallInt")]
		public System.Nullable<short> Week_Key4
		{
			get
			{
				return this._Week_Key4;
			}
			set
			{
				if ((this._Week_Key4 != value))
				{
					this._Week_Key4 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key5", DbType="SmallInt")]
		public System.Nullable<short> Week_Key5
		{
			get
			{
				return this._Week_Key5;
			}
			set
			{
				if ((this._Week_Key5 != value))
				{
					this._Week_Key5 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key6", DbType="SmallInt")]
		public System.Nullable<short> Week_Key6
		{
			get
			{
				return this._Week_Key6;
			}
			set
			{
				if ((this._Week_Key6 != value))
				{
					this._Week_Key6 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key7", DbType="SmallInt")]
		public System.Nullable<short> Week_Key7
		{
			get
			{
				return this._Week_Key7;
			}
			set
			{
				if ((this._Week_Key7 != value))
				{
					this._Week_Key7 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key8", DbType="SmallInt")]
		public System.Nullable<short> Week_Key8
		{
			get
			{
				return this._Week_Key8;
			}
			set
			{
				if ((this._Week_Key8 != value))
				{
					this._Week_Key8 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key9", DbType="SmallInt")]
		public System.Nullable<short> Week_Key9
		{
			get
			{
				return this._Week_Key9;
			}
			set
			{
				if ((this._Week_Key9 != value))
				{
					this._Week_Key9 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_Key0", DbType="SmallInt")]
		public System.Nullable<short> Week_Key0
		{
			get
			{
				return this._Week_Key0;
			}
			set
			{
				if ((this._Week_Key0 != value))
				{
					this._Week_Key0 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_N1", DbType="SmallInt")]
		public System.Nullable<short> Week_N1
		{
			get
			{
				return this._Week_N1;
			}
			set
			{
				if ((this._Week_N1 != value))
				{
					this._Week_N1 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_N2", DbType="SmallInt")]
		public System.Nullable<short> Week_N2
		{
			get
			{
				return this._Week_N2;
			}
			set
			{
				if ((this._Week_N2 != value))
				{
					this._Week_N2 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_N3", DbType="SmallInt")]
		public System.Nullable<short> Week_N3
		{
			get
			{
				return this._Week_N3;
			}
			set
			{
				if ((this._Week_N3 != value))
				{
					this._Week_N3 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_N4", DbType="SmallInt")]
		public System.Nullable<short> Week_N4
		{
			get
			{
				return this._Week_N4;
			}
			set
			{
				if ((this._Week_N4 != value))
				{
					this._Week_N4 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_N5", DbType="SmallInt")]
		public System.Nullable<short> Week_N5
		{
			get
			{
				return this._Week_N5;
			}
			set
			{
				if ((this._Week_N5 != value))
				{
					this._Week_N5 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_N6", DbType="SmallInt")]
		public System.Nullable<short> Week_N6
		{
			get
			{
				return this._Week_N6;
			}
			set
			{
				if ((this._Week_N6 != value))
				{
					this._Week_N6 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_N7", DbType="SmallInt")]
		public System.Nullable<short> Week_N7
		{
			get
			{
				return this._Week_N7;
			}
			set
			{
				if ((this._Week_N7 != value))
				{
					this._Week_N7 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Week_N8", DbType="SmallInt")]
		public System.Nullable<short> Week_N8
		{
			get
			{
				return this._Week_N8;
			}
			set
			{
				if ((this._Week_N8 != value))
				{
					this._Week_N8 = value;
				}
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.groups")]
	public partial class group
	{
		
		private System.Nullable<short> _Grp_Code;
		
		private string _Grp_Name;
		
		private string _Grp_FromSobh;
		
		private string _Grp_ToSobh;
		
		private string _Grp_FromNahar;
		
		private string _Grp_ToNahar;
		
		private string _Grp_FromSham;
		
		private string _Grp_ToSham;
		
		private string _Grp_M1;
		
		private string _Grp_M2;
		
		private string _Grp_M3;
		
		private string _Grp_M4;
		
		private string _Grp_M5;
		
		private string _Grp_M6;
		
		private string _Grp_M7;
		
		private string _Grp_M8;
		
		private string _Grp_M9;
		
		private string _Grp_M10;
		
		private string _Grp_M11;
		
		private string _Grp_M12;
		
		public group()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_Code", DbType="SmallInt")]
		public System.Nullable<short> Grp_Code
		{
			get
			{
				return this._Grp_Code;
			}
			set
			{
				if ((this._Grp_Code != value))
				{
					this._Grp_Code = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_Name", DbType="NVarChar(40)")]
		public string Grp_Name
		{
			get
			{
				return this._Grp_Name;
			}
			set
			{
				if ((this._Grp_Name != value))
				{
					this._Grp_Name = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_FromSobh", DbType="NVarChar(5)")]
		public string Grp_FromSobh
		{
			get
			{
				return this._Grp_FromSobh;
			}
			set
			{
				if ((this._Grp_FromSobh != value))
				{
					this._Grp_FromSobh = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_ToSobh", DbType="NVarChar(5)")]
		public string Grp_ToSobh
		{
			get
			{
				return this._Grp_ToSobh;
			}
			set
			{
				if ((this._Grp_ToSobh != value))
				{
					this._Grp_ToSobh = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_FromNahar", DbType="NVarChar(5)")]
		public string Grp_FromNahar
		{
			get
			{
				return this._Grp_FromNahar;
			}
			set
			{
				if ((this._Grp_FromNahar != value))
				{
					this._Grp_FromNahar = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_ToNahar", DbType="NVarChar(5)")]
		public string Grp_ToNahar
		{
			get
			{
				return this._Grp_ToNahar;
			}
			set
			{
				if ((this._Grp_ToNahar != value))
				{
					this._Grp_ToNahar = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_FromSham", DbType="NVarChar(5)")]
		public string Grp_FromSham
		{
			get
			{
				return this._Grp_FromSham;
			}
			set
			{
				if ((this._Grp_FromSham != value))
				{
					this._Grp_FromSham = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_ToSham", DbType="NVarChar(5)")]
		public string Grp_ToSham
		{
			get
			{
				return this._Grp_ToSham;
			}
			set
			{
				if ((this._Grp_ToSham != value))
				{
					this._Grp_ToSham = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M1", DbType="NVarChar(31)")]
		public string Grp_M1
		{
			get
			{
				return this._Grp_M1;
			}
			set
			{
				if ((this._Grp_M1 != value))
				{
					this._Grp_M1 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M2", DbType="NVarChar(31)")]
		public string Grp_M2
		{
			get
			{
				return this._Grp_M2;
			}
			set
			{
				if ((this._Grp_M2 != value))
				{
					this._Grp_M2 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M3", DbType="NVarChar(31)")]
		public string Grp_M3
		{
			get
			{
				return this._Grp_M3;
			}
			set
			{
				if ((this._Grp_M3 != value))
				{
					this._Grp_M3 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M4", DbType="NVarChar(31)")]
		public string Grp_M4
		{
			get
			{
				return this._Grp_M4;
			}
			set
			{
				if ((this._Grp_M4 != value))
				{
					this._Grp_M4 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M5", DbType="NVarChar(31)")]
		public string Grp_M5
		{
			get
			{
				return this._Grp_M5;
			}
			set
			{
				if ((this._Grp_M5 != value))
				{
					this._Grp_M5 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M6", DbType="NVarChar(31)")]
		public string Grp_M6
		{
			get
			{
				return this._Grp_M6;
			}
			set
			{
				if ((this._Grp_M6 != value))
				{
					this._Grp_M6 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M7", DbType="NVarChar(31)")]
		public string Grp_M7
		{
			get
			{
				return this._Grp_M7;
			}
			set
			{
				if ((this._Grp_M7 != value))
				{
					this._Grp_M7 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M8", DbType="NVarChar(31)")]
		public string Grp_M8
		{
			get
			{
				return this._Grp_M8;
			}
			set
			{
				if ((this._Grp_M8 != value))
				{
					this._Grp_M8 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M9", DbType="NVarChar(31)")]
		public string Grp_M9
		{
			get
			{
				return this._Grp_M9;
			}
			set
			{
				if ((this._Grp_M9 != value))
				{
					this._Grp_M9 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M10", DbType="NVarChar(31)")]
		public string Grp_M10
		{
			get
			{
				return this._Grp_M10;
			}
			set
			{
				if ((this._Grp_M10 != value))
				{
					this._Grp_M10 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M11", DbType="NVarChar(31)")]
		public string Grp_M11
		{
			get
			{
				return this._Grp_M11;
			}
			set
			{
				if ((this._Grp_M11 != value))
				{
					this._Grp_M11 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Grp_M12", DbType="NVarChar(31)")]
		public string Grp_M12
		{
			get
			{
				return this._Grp_M12;
			}
			set
			{
				if ((this._Grp_M12 != value))
				{
					this._Grp_M12 = value;
				}
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.foodlist")]
	public partial class foodlist : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private short _Food_Code;
		
		private System.Nullable<short> _Food_Type;
		
		private string _Food_Name;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnFood_CodeChanging(short value);
    partial void OnFood_CodeChanged();
    partial void OnFood_TypeChanging(System.Nullable<short> value);
    partial void OnFood_TypeChanged();
    partial void OnFood_NameChanging(string value);
    partial void OnFood_NameChanged();
    #endregion
		
		public foodlist()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Food_Code", DbType="SmallInt NOT NULL", IsPrimaryKey=true)]
		public short Food_Code
		{
			get
			{
				return this._Food_Code;
			}
			set
			{
				if ((this._Food_Code != value))
				{
					this.OnFood_CodeChanging(value);
					this.SendPropertyChanging();
					this._Food_Code = value;
					this.SendPropertyChanged("Food_Code");
					this.OnFood_CodeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Food_Type", DbType="SmallInt")]
		public System.Nullable<short> Food_Type
		{
			get
			{
				return this._Food_Type;
			}
			set
			{
				if ((this._Food_Type != value))
				{
					this.OnFood_TypeChanging(value);
					this.SendPropertyChanging();
					this._Food_Type = value;
					this.SendPropertyChanged("Food_Type");
					this.OnFood_TypeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Food_Name", DbType="NVarChar(40)")]
		public string Food_Name
		{
			get
			{
				return this._Food_Name;
			}
			set
			{
				if ((this._Food_Name != value))
				{
					this.OnFood_NameChanging(value);
					this.SendPropertyChanging();
					this._Food_Name = value;
					this.SendPropertyChanged("Food_Name");
					this.OnFood_NameChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.prgprs")]
	public partial class prgpr
	{
		
		private string _PP_Date;
        public readonly string tableName = "prgprs";
		private System.Nullable<short> _PP_Type;
		
		private string _PP_PCode;
		
		private System.Nullable<bool> _PP_Key1;
		
		private System.Nullable<bool> _PP_Key2;
		
		private System.Nullable<bool> _PP_Key3;
		
		private System.Nullable<bool> _PP_Key4;
		
		private System.Nullable<bool> _PP_Key5;
		
		private System.Nullable<bool> _PP_Key6;
		
		private System.Nullable<bool> _PP_Key7;
		
		private System.Nullable<bool> _PP_Key8;
		
		private System.Nullable<short> _PP_Keys;
		
		private System.Nullable<int> _PP_Building;
		
		private System.Nullable<decimal> _PP_Price;
		
		public prgpr()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Date", DbType="NVarChar(10)")]
		public string PP_Date
		{
			get
			{
				return this._PP_Date;
			}
			set
			{
				if ((this._PP_Date != value))
				{
					this._PP_Date = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Type", DbType="SmallInt")]
		public System.Nullable<short> PP_Type
		{
			get
			{
				return this._PP_Type;
			}
			set
			{
				if ((this._PP_Type != value))
				{
					this._PP_Type = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_PCode", DbType="NVarChar(8)")]
		public string PP_PCode
		{
			get
			{
				return this._PP_PCode;
			}
			set
			{
				if ((this._PP_PCode != value))
				{
					this._PP_PCode = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Key1", DbType="Bit")]
		public System.Nullable<bool> PP_Key1
		{
			get
			{
				return this._PP_Key1;
			}
			set
			{
				if ((this._PP_Key1 != value))
				{
					this._PP_Key1 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Key2", DbType="Bit")]
		public System.Nullable<bool> PP_Key2
		{
			get
			{
				return this._PP_Key2;
			}
			set
			{
				if ((this._PP_Key2 != value))
				{
					this._PP_Key2 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Key3", DbType="Bit")]
		public System.Nullable<bool> PP_Key3
		{
			get
			{
				return this._PP_Key3;
			}
			set
			{
				if ((this._PP_Key3 != value))
				{
					this._PP_Key3 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Key4", DbType="Bit")]
		public System.Nullable<bool> PP_Key4
		{
			get
			{
				return this._PP_Key4;
			}
			set
			{
				if ((this._PP_Key4 != value))
				{
					this._PP_Key4 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Key5", DbType="Bit")]
		public System.Nullable<bool> PP_Key5
		{
			get
			{
				return this._PP_Key5;
			}
			set
			{
				if ((this._PP_Key5 != value))
				{
					this._PP_Key5 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Key6", DbType="Bit")]
		public System.Nullable<bool> PP_Key6
		{
			get
			{
				return this._PP_Key6;
			}
			set
			{
				if ((this._PP_Key6 != value))
				{
					this._PP_Key6 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Key7", DbType="Bit")]
		public System.Nullable<bool> PP_Key7
		{
			get
			{
				return this._PP_Key7;
			}
			set
			{
				if ((this._PP_Key7 != value))
				{
					this._PP_Key7 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Key8", DbType="Bit")]
		public System.Nullable<bool> PP_Key8
		{
			get
			{
				return this._PP_Key8;
			}
			set
			{
				if ((this._PP_Key8 != value))
				{
					this._PP_Key8 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Keys", DbType="SmallInt")]
		public System.Nullable<short> PP_Keys
		{
			get
			{
				return this._PP_Keys;
			}
			set
			{
				if ((this._PP_Keys != value))
				{
					this._PP_Keys = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Building", DbType="Int")]
		public System.Nullable<int> PP_Building
		{
			get
			{
				return this._PP_Building;
			}
			set
			{
				if ((this._PP_Building != value))
				{
					this._PP_Building = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PP_Price", DbType="Money")]
		public System.Nullable<decimal> PP_Price
		{
			get
			{
				return this._PP_Price;
			}
			set
			{
				if ((this._PP_Price != value))
				{
					this._PP_Price = value;
				}
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.building")]
	public partial class building
	{
		
		private System.Nullable<short> _Building_Code;
		
		private string _Building_Name;
		
		public building()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Building_Code", DbType="SmallInt")]
		public System.Nullable<short> Building_Code
		{
			get
			{
				return this._Building_Code;
			}
			set
			{
				if ((this._Building_Code != value))
				{
					this._Building_Code = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Building_Name", DbType="NVarChar(40)")]
		public string Building_Name
		{
			get
			{
				return this._Building_Name;
			}
			set
			{
				if ((this._Building_Name != value))
				{
					this._Building_Name = value;
				}
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.foodpric")]
	public partial class foodpric
	{
		
		private short _FP_FoodCode;
		
		private string _FP_Date;
		
		private System.Nullable<decimal> _FP_PriceFee;
		
		private System.Nullable<decimal> _FP_PricePerson;
		
		public foodpric()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FP_FoodCode", DbType="SmallInt NOT NULL")]
		public short FP_FoodCode
		{
			get
			{
				return this._FP_FoodCode;
			}
			set
			{
				if ((this._FP_FoodCode != value))
				{
					this._FP_FoodCode = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FP_Date", DbType="NVarChar(10) NOT NULL", CanBeNull=false)]
		public string FP_Date
		{
			get
			{
				return this._FP_Date;
			}
			set
			{
				if ((this._FP_Date != value))
				{
					this._FP_Date = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FP_PriceFee", DbType="Money")]
		public System.Nullable<decimal> FP_PriceFee
		{
			get
			{
				return this._FP_PriceFee;
			}
			set
			{
				if ((this._FP_PriceFee != value))
				{
					this._FP_PriceFee = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FP_PricePerson", DbType="Money")]
		public System.Nullable<decimal> FP_PricePerson
		{
			get
			{
				return this._FP_PricePerson;
			}
			set
			{
				if ((this._FP_PricePerson != value))
				{
					this._FP_PricePerson = value;
				}
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.wr_DynamicReserveRange")]
	public partial class wr_DynamicReserveRange : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private decimal _Id = default(decimal);
		
		private System.Nullable<int> _DynamicReservRange_FromDateType;
		
		private System.Nullable<int> _DynamicReservRange_FromDateCount;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnDynamicReservRange_FromDateTypeChanging(System.Nullable<int> value);
    partial void OnDynamicReservRange_FromDateTypeChanged();
    partial void OnDynamicReservRange_FromDateCountChanging(System.Nullable<int> value);
    partial void OnDynamicReservRange_FromDateCountChanged();
    #endregion
		
		public wr_DynamicReserveRange()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", AutoSync=AutoSync.OnInsert, DbType="Decimal(18,0) NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true, UpdateCheck=UpdateCheck.Never)]
		public decimal Id
		{
			get
			{
				return this._Id;
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DynamicReservRange_FromDateType", DbType="Int")]
		public System.Nullable<int> DynamicReservRange_FromDateType
		{
			get
			{
				return this._DynamicReservRange_FromDateType;
			}
			set
			{
				if ((this._DynamicReservRange_FromDateType != value))
				{
					this.OnDynamicReservRange_FromDateTypeChanging(value);
					this.SendPropertyChanging();
					this._DynamicReservRange_FromDateType = value;
					this.SendPropertyChanged("DynamicReservRange_FromDateType");
					this.OnDynamicReservRange_FromDateTypeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DynamicReservRange_FromDateCount", DbType="Int")]
		public System.Nullable<int> DynamicReservRange_FromDateCount
		{
			get
			{
				return this._DynamicReservRange_FromDateCount;
			}
			set
			{
				if ((this._DynamicReservRange_FromDateCount != value))
				{
					this.OnDynamicReservRange_FromDateCountChanging(value);
					this.SendPropertyChanging();
					this._DynamicReservRange_FromDateCount = value;
					this.SendPropertyChanged("DynamicReservRange_FromDateCount");
					this.OnDynamicReservRange_FromDateCountChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.wr_ReserveRange")]
	public partial class wr_ReserveRange : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private decimal _Id = default(decimal);
		
		private System.Nullable<int> _ReservRange_EndDateCount;
		
		private System.Nullable<int> _ReservRange_EndDateType;
		
		private System.Nullable<bool> _ReservRange_Mokhalafat;
		
		private System.Nullable<int> _ReservRange_SAGHFRESERVE;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnReservRange_EndDateCountChanging(System.Nullable<int> value);
    partial void OnReservRange_EndDateCountChanged();
    partial void OnReservRange_EndDateTypeChanging(System.Nullable<int> value);
    partial void OnReservRange_EndDateTypeChanged();
    partial void OnReservRange_MokhalafatChanging(System.Nullable<bool> value);
    partial void OnReservRange_MokhalafatChanged();
    partial void OnReservRange_SAGHFRESERVEChanging(System.Nullable<int> value);
    partial void OnReservRange_SAGHFRESERVEChanged();
    #endregion
		
		public wr_ReserveRange()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", AutoSync=AutoSync.OnInsert, DbType="Decimal(18,0) NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true, UpdateCheck=UpdateCheck.Never)]
		public decimal Id
		{
			get
			{
				return this._Id;
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ReservRange_EndDateCount", DbType="Int")]
		public System.Nullable<int> ReservRange_EndDateCount
		{
			get
			{
				return this._ReservRange_EndDateCount;
			}
			set
			{
				if ((this._ReservRange_EndDateCount != value))
				{
					this.OnReservRange_EndDateCountChanging(value);
					this.SendPropertyChanging();
					this._ReservRange_EndDateCount = value;
					this.SendPropertyChanged("ReservRange_EndDateCount");
					this.OnReservRange_EndDateCountChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ReservRange_EndDateType", DbType="Int")]
		public System.Nullable<int> ReservRange_EndDateType
		{
			get
			{
				return this._ReservRange_EndDateType;
			}
			set
			{
				if ((this._ReservRange_EndDateType != value))
				{
					this.OnReservRange_EndDateTypeChanging(value);
					this.SendPropertyChanging();
					this._ReservRange_EndDateType = value;
					this.SendPropertyChanged("ReservRange_EndDateType");
					this.OnReservRange_EndDateTypeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ReservRange_Mokhalafat", DbType="Bit")]
		public System.Nullable<bool> ReservRange_Mokhalafat
		{
			get
			{
				return this._ReservRange_Mokhalafat;
			}
			set
			{
				if ((this._ReservRange_Mokhalafat != value))
				{
					this.OnReservRange_MokhalafatChanging(value);
					this.SendPropertyChanging();
					this._ReservRange_Mokhalafat = value;
					this.SendPropertyChanged("ReservRange_Mokhalafat");
					this.OnReservRange_MokhalafatChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ReservRange_SAGHFRESERVE", DbType="Int")]
		public System.Nullable<int> ReservRange_SAGHFRESERVE
		{
			get
			{
				return this._ReservRange_SAGHFRESERVE;
			}
			set
			{
				if ((this._ReservRange_SAGHFRESERVE != value))
				{
					this.OnReservRange_SAGHFRESERVEChanging(value);
					this.SendPropertyChanging();
					this._ReservRange_SAGHFRESERVE = value;
					this.SendPropertyChanged("ReservRange_SAGHFRESERVE");
					this.OnReservRange_SAGHFRESERVEChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.wr_Users")]
	public partial class wr_User : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private decimal _ID = default(decimal);
		
		private string _lgn_barcode;
		
		private string _lgn_UserName;
		
		private string _lgn_Password;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void Onlgn_barcodeChanging(string value);
    partial void Onlgn_barcodeChanged();
    partial void Onlgn_UserNameChanging(string value);
    partial void Onlgn_UserNameChanged();
    partial void Onlgn_PasswordChanging(string value);
    partial void Onlgn_PasswordChanged();
    #endregion
		
		public wr_User()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ID", AutoSync=AutoSync.Always, DbType="Decimal(18,0) NOT NULL IDENTITY", IsDbGenerated=true, UpdateCheck=UpdateCheck.Never)]
		public decimal ID
		{
			get
			{
				return this._ID;
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_lgn_barcode", DbType="NVarChar(8) NOT NULL", CanBeNull=false)]
		public string lgn_barcode
		{
			get
			{
				return this._lgn_barcode;
			}
			set
			{
				if ((this._lgn_barcode != value))
				{
					this.Onlgn_barcodeChanging(value);
					this.SendPropertyChanging();
					this._lgn_barcode = value;
					this.SendPropertyChanged("lgn_barcode");
					this.Onlgn_barcodeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_lgn_UserName", DbType="NVarChar(50) NOT NULL", CanBeNull=false, IsPrimaryKey=true)]
		public string lgn_UserName
		{
			get
			{
				return this._lgn_UserName;
			}
			set
			{
				if ((this._lgn_UserName != value))
				{
					this.Onlgn_UserNameChanging(value);
					this.SendPropertyChanging();
					this._lgn_UserName = value;
					this.SendPropertyChanged("lgn_UserName");
					this.Onlgn_UserNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_lgn_Password", DbType="NVarChar(20)")]
		public string lgn_Password
		{
			get
			{
				return this._lgn_Password;
			}
			set
			{
				if ((this._lgn_Password != value))
				{
					this.Onlgn_PasswordChanging(value);
					this.SendPropertyChanging();
					this._lgn_Password = value;
					this.SendPropertyChanged("lgn_Password");
					this.Onlgn_PasswordChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.wr_PublicMessage")]
	public partial class wr_PublicMessage : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private decimal _id = default(decimal);
		
		private string _Message;
		
		private System.Nullable<System.DateTime> _DateMessage;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnMessageChanging(string value);
    partial void OnMessageChanged();
    partial void OnDateMessageChanging(System.Nullable<System.DateTime> value);
    partial void OnDateMessageChanged();
    #endregion
		
		public wr_PublicMessage()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_id", AutoSync=AutoSync.OnInsert, DbType="Decimal(18,0) NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true, UpdateCheck=UpdateCheck.Never)]
		public decimal id
		{
			get
			{
				return this._id;
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Message", DbType="NVarChar(1000)")]
		public string Message
		{
			get
			{
				return this._Message;
			}
			set
			{
				if ((this._Message != value))
				{
					this.OnMessageChanging(value);
					this.SendPropertyChanging();
					this._Message = value;
					this.SendPropertyChanged("Message");
					this.OnMessageChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DateMessage", DbType="DateTime")]
		public System.Nullable<System.DateTime> DateMessage
		{
			get
			{
				return this._DateMessage;
			}
			set
			{
				if ((this._DateMessage != value))
				{
					this.OnDateMessageChanging(value);
					this.SendPropertyChanging();
					this._DateMessage = value;
					this.SendPropertyChanged("DateMessage");
					this.OnDateMessageChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.fish")]
	public partial class fish
	{
		
		private string _Fish_Date;
		
		private short _Fish_Type;
		
		private short _Fish_No;
		
		private System.Nullable<short> _Fish_RdrFishNo;
		
		private string _Fish_Time;
		
		private string _Fish_PCode;
		
		private System.Nullable<short> _Fish_RdrCode;
		
		private System.Nullable<short> _Fish_UCode;
		
		private System.Nullable<short> _Fish_UKhadamat;
		
		private System.Nullable<decimal> _Fish_UPrc;
		
		private System.Nullable<decimal> _Fish_UPay;
        private System.Nullable<bool> _Fish_Reserved;
		public fish()
		{
		}


        [global::System.Data.Linq.Mapping.ColumnAttribute(Storage = "_Fish_Reserved", DbType = "bit")]
        public System.Nullable<bool> Fish_Reserved
        {
            get
            {
                return this._Fish_Reserved;
            }
            set
            {
                if ((this._Fish_Reserved != value))
                {
                    this._Fish_Reserved = value;
                }
            }
        }
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_Date", DbType="NVarChar(10) NOT NULL", CanBeNull=false)]
		public string Fish_Date
		{
			get
			{
				return this._Fish_Date;
			}
			set
			{
				if ((this._Fish_Date != value))
				{
					this._Fish_Date = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_Type", DbType="SmallInt NOT NULL")]
		public short Fish_Type
		{
			get
			{
				return this._Fish_Type;
			}
			set
			{
				if ((this._Fish_Type != value))
				{
					this._Fish_Type = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_No", DbType="SmallInt NOT NULL")]
		public short Fish_No
		{
			get
			{
				return this._Fish_No;
			}
			set
			{
				if ((this._Fish_No != value))
				{
					this._Fish_No = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_RdrFishNo", DbType="SmallInt")]
		public System.Nullable<short> Fish_RdrFishNo
		{
			get
			{
				return this._Fish_RdrFishNo;
			}
			set
			{
				if ((this._Fish_RdrFishNo != value))
				{
					this._Fish_RdrFishNo = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_Time", DbType="NVarChar(5)")]
		public string Fish_Time
		{
			get
			{
				return this._Fish_Time;
			}
			set
			{
				if ((this._Fish_Time != value))
				{
					this._Fish_Time = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_PCode", DbType="NVarChar(8)")]
		public string Fish_PCode
		{
			get
			{
				return this._Fish_PCode;
			}
			set
			{
				if ((this._Fish_PCode != value))
				{
					this._Fish_PCode = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_RdrCode", DbType="SmallInt")]
		public System.Nullable<short> Fish_RdrCode
		{
			get
			{
				return this._Fish_RdrCode;
			}
			set
			{
				if ((this._Fish_RdrCode != value))
				{
					this._Fish_RdrCode = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_UCode", DbType="SmallInt")]
		public System.Nullable<short> Fish_UCode
		{
			get
			{
				return this._Fish_UCode;
			}
			set
			{
				if ((this._Fish_UCode != value))
				{
					this._Fish_UCode = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_UKhadamat", DbType="SmallInt")]
		public System.Nullable<short> Fish_UKhadamat
		{
			get
			{
				return this._Fish_UKhadamat;
			}
			set
			{
				if ((this._Fish_UKhadamat != value))
				{
					this._Fish_UKhadamat = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_UPrc", DbType="Money")]
		public System.Nullable<decimal> Fish_UPrc
		{
			get
			{
				return this._Fish_UPrc;
			}
			set
			{
				if ((this._Fish_UPrc != value))
				{
					this._Fish_UPrc = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Fish_UPay", DbType="Money")]
		public System.Nullable<decimal> Fish_UPay
		{
			get
			{
				return this._Fish_UPay;
			}
			set
			{
				if ((this._Fish_UPay != value))
				{
					this._Fish_UPay = value;
				}
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.fishfood")]
	public partial class fishfood : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private string _FF_Date;
		
		private short _FF_Type;
		
		private short _FF_FishNo;
		
		private short _FF_Food;
		
		private System.Nullable<decimal> _FF_Price;
		
		private System.Nullable<decimal> _FF_Pay;
		
		private System.Nullable<short> _FF_No;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnFF_DateChanging(string value);
    partial void OnFF_DateChanged();
    partial void OnFF_TypeChanging(short value);
    partial void OnFF_TypeChanged();
    partial void OnFF_FishNoChanging(short value);
    partial void OnFF_FishNoChanged();
    partial void OnFF_FoodChanging(short value);
    partial void OnFF_FoodChanged();
    partial void OnFF_PriceChanging(System.Nullable<decimal> value);
    partial void OnFF_PriceChanged();
    partial void OnFF_PayChanging(System.Nullable<decimal> value);
    partial void OnFF_PayChanged();
    partial void OnFF_NoChanging(System.Nullable<short> value);
    partial void OnFF_NoChanged();
    #endregion
		
		public fishfood()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FF_Date", DbType="NVarChar(10) NOT NULL", CanBeNull=false, IsPrimaryKey=true)]
		public string FF_Date
		{
			get
			{
				return this._FF_Date;
			}
			set
			{
				if ((this._FF_Date != value))
				{
					this.OnFF_DateChanging(value);
					this.SendPropertyChanging();
					this._FF_Date = value;
					this.SendPropertyChanged("FF_Date");
					this.OnFF_DateChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FF_Type", DbType="SmallInt NOT NULL", IsPrimaryKey=true)]
		public short FF_Type
		{
			get
			{
				return this._FF_Type;
			}
			set
			{
				if ((this._FF_Type != value))
				{
					this.OnFF_TypeChanging(value);
					this.SendPropertyChanging();
					this._FF_Type = value;
					this.SendPropertyChanged("FF_Type");
					this.OnFF_TypeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FF_FishNo", DbType="SmallInt NOT NULL", IsPrimaryKey=true)]
		public short FF_FishNo
		{
			get
			{
				return this._FF_FishNo;
			}
			set
			{
				if ((this._FF_FishNo != value))
				{
					this.OnFF_FishNoChanging(value);
					this.SendPropertyChanging();
					this._FF_FishNo = value;
					this.SendPropertyChanged("FF_FishNo");
					this.OnFF_FishNoChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FF_Food", DbType="SmallInt NOT NULL", IsPrimaryKey=true)]
		public short FF_Food
		{
			get
			{
				return this._FF_Food;
			}
			set
			{
				if ((this._FF_Food != value))
				{
					this.OnFF_FoodChanging(value);
					this.SendPropertyChanging();
					this._FF_Food = value;
					this.SendPropertyChanged("FF_Food");
					this.OnFF_FoodChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FF_Price", DbType="Money")]
		public System.Nullable<decimal> FF_Price
		{
			get
			{
				return this._FF_Price;
			}
			set
			{
				if ((this._FF_Price != value))
				{
					this.OnFF_PriceChanging(value);
					this.SendPropertyChanging();
					this._FF_Price = value;
					this.SendPropertyChanged("FF_Price");
					this.OnFF_PriceChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FF_Pay", DbType="Money")]
		public System.Nullable<decimal> FF_Pay
		{
			get
			{
				return this._FF_Pay;
			}
			set
			{
				if ((this._FF_Pay != value))
				{
					this.OnFF_PayChanging(value);
					this.SendPropertyChanging();
					this._FF_Pay = value;
					this.SendPropertyChanged("FF_Pay");
					this.OnFF_PayChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FF_No", DbType="SmallInt")]
		public System.Nullable<short> FF_No
		{
			get
			{
				return this._FF_No;
			}
			set
			{
				if ((this._FF_No != value))
				{
					this.OnFF_NoChanging(value);
					this.SendPropertyChanging();
					this._FF_No = value;
					this.SendPropertyChanged("FF_No");
					this.OnFF_NoChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}


    }

