using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using Model;
using System.Data;
namespace Business
{
    public class BPrgPrs
    {
        private PrgPrsDAL prgPrsDAL
        {
            get
            {
                return new PrgPrsDAL();
            }
        }
        private int CorrectPriceFood(decimal? price)
        {
            try
            {
                return Convert.ToInt32(price);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public class SummaryFoodListPerson
        {
            public string Date { get; set; }
            public string DayOfWeek { get; set; }
            public string PersonBarcode { get; set; }
            public string BreakFast { get; set; }
            public string Launch { get; set; }
            public string  Dinner { get; set; }
            public int? Price { get; set; }
            public bool IsPermittedReserve { get; set; }
            public bool IsFood { get; set; }
            public string statusFood { get; set; }
            

        }
        public IList<SummaryFoodListPerson> GetSummaryFoodListPersonInDate(person personObj,Dictionary<string, string> paramDic,string year,string month)
        {
            try
            {
                List<SummaryFoodListPerson> sumFoodListPersonList=new List<SummaryFoodListPerson>();

                DataTable dtDaysOfMonth = Utility.GetDayOfMonth(Convert.ToInt32(year), Convert.ToInt32(month));
                List<string> dateRangePermittedList = GetReserveDatePermittedList();
                string statusBlankFood = "~/Image/DesignImage/blank.png";
                for (int i = 0; i < dtDaysOfMonth.Rows.Count;i++ )
                {
                    string currentDate = dtDaysOfMonth.Rows[i]["Date"].ToString();
                    List<PrgPrsCustomizeModel> prgPrsCustomList = GetProgramFoodPersonByDate(personObj, currentDate, paramDic);
                    string strSummaryBreakFast = string.Empty;
                    string strSummaryLaunch = string.Empty;
                    string strSummaryDinner = string.Empty;
                    int? summaryPrice = 0;
                    bool IsFood=false;
                    
                    for (int j = 0; j < prgPrsCustomList.Count; j++)
                    {
                        if(prgPrsCustomList[j].PP_KeyID!=null)
                        {
                        IsFood=true;
                        
                        }
                        
                        switch (prgPrsCustomList[j].PP_Type)
                        {
                            case 1:
                                {
                                    if (strSummaryBreakFast == string.Empty)
                                        strSummaryBreakFast += prgPrsCustomList[j].PP_FoodName;
                                        
                                    else
                                        strSummaryBreakFast += " - " + prgPrsCustomList[j].PP_FoodName;
                                    summaryPrice +=Convert.ToInt32(prgPrsCustomList[j].PP_FoodPricePerson);
                                    break;
                                }
                            case 2:
                                {
                                    if (strSummaryLaunch == string.Empty)
                                        strSummaryLaunch += prgPrsCustomList[j].PP_FoodName;
                                    else
                                        strSummaryLaunch += " - " + prgPrsCustomList[j].PP_FoodName;
                                    summaryPrice += Convert.ToInt32(prgPrsCustomList[j].PP_FoodPricePerson);
                                    break;
                                    
                                }
                            case 3:
                                {
                                    if (strSummaryDinner == string.Empty)
                                        strSummaryDinner += prgPrsCustomList[j].PP_FoodName;
                                    else
                                        strSummaryDinner += " - " + prgPrsCustomList[j].PP_FoodName;
                                    summaryPrice += Convert.ToInt32(prgPrsCustomList[j].PP_FoodPricePerson);
                                    break;
                                    
                                }
                            default:
                                break;
                        }
                    }
                    for (int k = 0; k < prgPrsCustomList.Count; k++)
                    {
                        if (prgPrsCustomList[k].PP_strAllSupplements != null)
                        {
                            switch (prgPrsCustomList[k].PP_Type)
                            {
                                case 1:
                                    {
                                        if (strSummaryBreakFast == string.Empty)
                                            strSummaryBreakFast += prgPrsCustomList[k].PP_strAllSupplements;
                                        else
                                            strSummaryBreakFast += " - " + prgPrsCustomList[k].PP_strAllSupplements;
                                        summaryPrice += Convert.ToInt32(prgPrsCustomList[k].sumAllSupplementsPrice);
                                        break;

                                    }
                                case 2:
                                    {
                                        if (strSummaryLaunch == string.Empty)
                                            strSummaryLaunch += prgPrsCustomList[k].PP_strAllSupplements;
                                        else
                                            strSummaryLaunch += " - " + prgPrsCustomList[k].PP_strAllSupplements;
                                        summaryPrice += Convert.ToInt32(prgPrsCustomList[k].sumAllSupplementsPrice);
                                        break;
                                    }
                                case 3:
                                    {
                                        if (strSummaryDinner == string.Empty)
                                            strSummaryDinner += prgPrsCustomList[k].PP_strAllSupplements;
                                        else
                                            strSummaryDinner += " - " + prgPrsCustomList[k].PP_strAllSupplements;
                                        summaryPrice += Convert.ToInt32(prgPrsCustomList[k].sumAllSupplementsPrice);
                                        break;
                                    }
                                default:
                                    break;
                            }
                        }
                    }
                    SummaryFoodListPerson summaryFoodListPersonObj = new SummaryFoodListPerson();
                    summaryFoodListPersonObj.PersonBarcode = personObj.P_BarCode;
                    summaryFoodListPersonObj.Date = currentDate;
                    summaryFoodListPersonObj.DayOfWeek = dtDaysOfMonth.Rows[i]["DayOfWeek"].ToString();
                    summaryFoodListPersonObj.BreakFast = strSummaryBreakFast;
                    summaryFoodListPersonObj.Launch = strSummaryLaunch;
                    summaryFoodListPersonObj.Dinner = strSummaryDinner;
                    summaryFoodListPersonObj.Price =summaryPrice;
                    summaryFoodListPersonObj.IsFood=IsFood;
                    
                   

                    if (dateRangePermittedList.Contains(summaryFoodListPersonObj.Date))
                    {
                        summaryFoodListPersonObj.IsPermittedReserve = true;
                    }
                    else
                    {
                        summaryFoodListPersonObj.IsPermittedReserve = false;
                    }
                    if (summaryFoodListPersonObj.IsFood == false && summaryFoodListPersonObj.IsPermittedReserve == true)
                    {
                        summaryFoodListPersonObj.statusFood = "~/Image/DesignImage/wait.png";
                    }
                    else
                    {
                        summaryFoodListPersonObj.statusFood = statusBlankFood;
                    }
                    sumFoodListPersonList.Add(summaryFoodListPersonObj);
                }


                return sumFoodListPersonList;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        public List<PrgPrsCustomizeModel> GetProgramFoodPersonByDate(person personObj, string date, Dictionary<string, string> paramDic)
        {
            try
            {
                List<PrgPrsCustomizeModel> prgPrsCustomList = new List<PrgPrsCustomizeModel>();
                List<prgpr> prgPrsList = prgPrsDAL.GetProgramFoodPersonByDate(personObj.P_BarCode, date);
                if (prgPrsList == null)
                    return prgPrsCustomList;
                for (int j = 0; j < prgPrsList.Count; j++)
                {
                    prgpr prgPrsObj = prgPrsList[j];

                    int MaxCountMeal = 0;
                    switch (prgPrsObj.PP_Type)
                    {
                        case 1:
                            {
                                MaxCountMeal = Convert.ToInt32(paramDic["SobhKeyNo"]);
                                break;
                            }
                        case 2:
                            {
                                MaxCountMeal = Convert.ToInt32(paramDic["NaharKeyNo"]);
                                break;
                            }
                        case 3:
                            {
                                MaxCountMeal = Convert.ToInt32(paramDic["ShamKeyNo"]);
                                break;
                            }
                        default:
                            break;
                    }


                    List<WeekCustomizeModel> weekCustomList= new BWeek().GetFoodWeekByDateByType(personObj,prgPrsObj.PP_Date, Convert.ToInt16(prgPrsObj.PP_Type), paramDic);
                    
                    for (short i = 1; i <= MaxCountMeal; i++)
                    {
                        PrgPrsCustomizeModel prgPrsCustomObj = new PrgPrsCustomizeModel();
                        

                        prgPrsCustomObj.PP_Date = prgPrsObj.PP_Date;
                        prgPrsCustomObj.PP_Type = prgPrsObj.PP_Type;
                        prgPrsCustomObj.PP_Building = prgPrsObj.PP_Building;
                        prgPrsCustomObj.PP_PCode = prgPrsObj.PP_PCode;
                        switch (prgPrsObj.PP_Type)
                        {
                            case 1:
                                {
                                    prgPrsCustomObj.PP_MealName = "صبحانه";
                                    break;
                                }
                            case 2:
                                {
                                    prgPrsCustomObj.PP_MealName = "ناهار";
                                    break;
                                }
                            case 3:
                                {
                                    prgPrsCustomObj.PP_MealName = "شام";
                                    break;
                                }
                            default:
                                prgPrsCustomObj.PP_MealName = "";
                                break;
                        }
                        switch (i)
                        {
                            case 1:
                                {
                                    if (prgPrsObj.PP_Key1 == true)
                                    {
                                        short? weekKeyValue = weekCustomList.SingleOrDefault(kf => kf.Week_KeyID == i).Week_KeyValue;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                        prgPrsCustomObj.PP_KeyID = i;
                                        prgPrsCustomObj.PP_KeyValue = prgPrsObj.PP_Key1;
                                        prgPrsCustomObj.PP_FoodName = foodListObj.Food_Name;
                                        prgPrsCustomObj.PP_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                        prgPrsCustomObj.PP_FoodPricePerson =foodPriceProxyObj.FP_Price;
                                        prgPrsCustomObj.PP_sumAllFoodSupplementPrice +=CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                        if (i > MaxCountMeal)
                                        {
                                            prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name + " - ";
                                        }

                                    }
                                    break;
                                }
                            case 2:
                                {
                                    if (prgPrsObj.PP_Key2 == true)
                                    {
                                        short? weekKeyValue = weekCustomList.SingleOrDefault(kf => kf.Week_KeyID == i).Week_KeyValue;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                        prgPrsCustomObj.PP_KeyID = i;
                                        prgPrsCustomObj.PP_KeyValue = prgPrsObj.PP_Key2;
                                        prgPrsCustomObj.PP_FoodName = foodListObj.Food_Name;
                                        prgPrsCustomObj.PP_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue, personObj, paramDic);
                                        prgPrsCustomObj.PP_FoodPricePerson =foodPriceProxyObj.FP_Price;
                                        prgPrsCustomObj.PP_sumAllFoodSupplementPrice +=CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                        if (i > MaxCountMeal)
                                        {
                                            prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name + " - ";
                                        }
                                    }

                                    break;
                                }
                            case 3:
                                {
                                    if (prgPrsObj.PP_Key3 == true)
                                    {

                                        short? weekKeyValue = weekCustomList.SingleOrDefault(kf => kf.Week_KeyID == i).Week_KeyValue;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                        prgPrsCustomObj.PP_KeyID = i;
                                        prgPrsCustomObj.PP_KeyValue = prgPrsObj.PP_Key3;
                                        prgPrsCustomObj.PP_FoodName = foodListObj.Food_Name;
                                        prgPrsCustomObj.PP_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue, personObj, paramDic);
                                        prgPrsCustomObj.PP_FoodPricePerson = foodPriceProxyObj.FP_Price;
                                        prgPrsCustomObj.PP_sumAllFoodSupplementPrice += CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                        if (i > MaxCountMeal)
                                        {
                                            prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name + " - ";
                                        }

                                    }

                                    break;
                                }
                            case 4:
                                {
                                    if (prgPrsObj.PP_Key4 == true)
                                    {

                                        short? weekKeyValue = weekCustomList.SingleOrDefault(kf => kf.Week_KeyID == i).Week_KeyValue;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                        prgPrsCustomObj.PP_KeyID = i;
                                        prgPrsCustomObj.PP_KeyValue = prgPrsObj.PP_Key4;
                                        prgPrsCustomObj.PP_FoodName = foodListObj.Food_Name;
                                        prgPrsCustomObj.PP_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue, personObj, paramDic);
                                        prgPrsCustomObj.PP_FoodPricePerson =foodPriceProxyObj.FP_Price;
                                        prgPrsCustomObj.PP_sumAllFoodSupplementPrice += CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                        if (i > MaxCountMeal)
                                        {
                                            prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name + " - ";
                                        }

                                    }

                                    break;
                                }
                            case 5:
                                {
                                    if (prgPrsObj.PP_Key5 == true)
                                    {

                                        short? weekKeyValue = weekCustomList.SingleOrDefault(kf => kf.Week_KeyID == i).Week_KeyValue;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                        prgPrsCustomObj.PP_KeyID = i;
                                        prgPrsCustomObj.PP_KeyValue = prgPrsObj.PP_Key5;
                                        prgPrsCustomObj.PP_FoodName = foodListObj.Food_Name;
                                        prgPrsCustomObj.PP_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue, personObj, paramDic);
                                        prgPrsCustomObj.PP_FoodPricePerson = foodPriceProxyObj.FP_Price;
                                        prgPrsCustomObj.PP_sumAllFoodSupplementPrice +=CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                        if (i > MaxCountMeal)
                                        {
                                            prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name + " - ";
                                        }

                                    }

                                    break;
                                }
                            case 6:
                                {
                                    if (prgPrsObj.PP_Key6 == true)
                                    {

                                        short? weekKeyValue = weekCustomList.SingleOrDefault(kf => kf.Week_KeyID == i).Week_KeyValue;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                        prgPrsCustomObj.PP_KeyID = i;
                                        prgPrsCustomObj.PP_KeyValue = prgPrsObj.PP_Key6;
                                        prgPrsCustomObj.PP_FoodName = foodListObj.Food_Name;
                                        prgPrsCustomObj.PP_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue, personObj, paramDic);
                                        prgPrsCustomObj.PP_FoodPricePerson = foodPriceProxyObj.FP_Price;
                                        prgPrsCustomObj.PP_sumAllFoodSupplementPrice +=CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                        if (i > MaxCountMeal)
                                        {
                                            prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name + " - ";
                                        }
                                    }

                                    break;
                                }
                            case 7:
                                {
                                    if (prgPrsObj.PP_Key7 == true)
                                    {

                                        short? weekKeyValue = weekCustomList.SingleOrDefault(kf => kf.Week_KeyID == i).Week_KeyValue;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                        prgPrsCustomObj.PP_KeyID = i;
                                        prgPrsCustomObj.PP_KeyValue = prgPrsObj.PP_Key7;
                                        prgPrsCustomObj.PP_FoodName = foodListObj.Food_Name;
                                        prgPrsCustomObj.PP_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue, personObj, paramDic);
                                        prgPrsCustomObj.PP_FoodPricePerson =foodPriceProxyObj.FP_Price;
                                        prgPrsCustomObj.PP_sumAllFoodSupplementPrice +=CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                        if (i > MaxCountMeal)
                                        {
                                            prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name + " - ";
                                        }
                                    }

                                    break;
                                }
                            case 8:
                                {
                                    if (prgPrsObj.PP_Key8 == true)
                                    {

                                        short? weekKeyValue = weekCustomList.SingleOrDefault(kf => kf.Week_KeyID == i).Week_KeyValue;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                        prgPrsCustomObj.PP_KeyID = i;
                                        prgPrsCustomObj.PP_KeyValue = prgPrsObj.PP_Key8;
                                        prgPrsCustomObj.PP_FoodName = foodListObj.Food_Name;
                                        prgPrsCustomObj.PP_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue, personObj, paramDic);
                                        prgPrsCustomObj.PP_FoodPricePerson =foodPriceProxyObj.FP_Price;
                                        prgPrsCustomObj.PP_sumAllFoodSupplementPrice +=CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                        if (i > MaxCountMeal)
                                        {
                                            prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name + " - ";
                                        }
                                    }

                                    break;
                                }
                            default:
                                break;
                        }
                        
                        if (prgPrsCustomObj.PP_KeyID != null)
                        {
                            
                            List<WeekCustomizeModel> weekSupplementsCustomList = new BWeek().GetSupplementsWeekByDateByType(personObj, prgPrsObj.PP_Date, Convert.ToInt16(prgPrsObj.PP_Type), paramDic);
                            List<PrgPrsCustomizeModel.Supplements> SupplementsTempList = new List<PrgPrsCustomizeModel.Supplements>();
                            for (short k =Convert.ToInt16((MaxCountMeal + 1)); k <= 8; k++)
                            {
                                PrgPrsCustomizeModel.Supplements SupplementsObj = new PrgPrsCustomizeModel.Supplements();
                                switch (k)
                                {
                                    case 1:
                                        {
                                            if (prgPrsObj.PP_Key1 == true)
                                            {
                                                
                                                short? weekKeyValue = weekSupplementsCustomList.SingleOrDefault(kf => kf.Week_KeyID == k).Week_KeyValue;
                                                SupplementsObj.PP_SupplementsKeyID = k;
                                                SupplementsObj.PP_SupplementsKeyValue = prgPrsObj.PP_Key1;
                                                foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                                SupplementsObj.PP_SupplementCode = foodListObj.Food_Code;
                                                SupplementsObj.PP_SupplementsName = foodListObj.Food_Name;
                                                if (prgPrsCustomObj.PP_strAllSupplements == null)
                                                    prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name;
                                                else
                                                {
                                                    prgPrsCustomObj.PP_strAllSupplements += " , " + foodListObj.Food_Name;
                                                }

                                                foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                                SupplementsObj.PP_SupplementPricePerson =foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.sumAllSupplementsPrice +=foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.PP_sumAllFoodSupplementPrice += CorrectPriceFood(foodPriceProxyObj.FP_Price);
                                            }
                                            break;
                                        }
                                    case 2:
                                        {
                                            if (prgPrsObj.PP_Key2 == true)
                                            {

                                                short? weekKeyValue = weekSupplementsCustomList.SingleOrDefault(kf => kf.Week_KeyID == k).Week_KeyValue;
                                                SupplementsObj.PP_SupplementsKeyID = k;
                                                SupplementsObj.PP_SupplementsKeyValue = prgPrsObj.PP_Key2;
                                                foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                                SupplementsObj.PP_SupplementCode = foodListObj.Food_Code;
                                                SupplementsObj.PP_SupplementsName = foodListObj.Food_Name;
                                                if (prgPrsCustomObj.PP_strAllSupplements == null)
                                                    prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name;
                                                else
                                                {
                                                    prgPrsCustomObj.PP_strAllSupplements += " , " + foodListObj.Food_Name;
                                                }
                                                foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                                SupplementsObj.PP_SupplementPricePerson =foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.sumAllSupplementsPrice += foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.PP_sumAllFoodSupplementPrice += Convert.ToInt32(foodPriceProxyObj.FP_Price);

                                            }
                                            break;
                                        }
                                    case 3:
                                        {
                                            if (prgPrsObj.PP_Key3 == true)
                                            {

                                                short? weekKeyValue = weekSupplementsCustomList.SingleOrDefault(kf => kf.Week_KeyID == k).Week_KeyValue;
                                                SupplementsObj.PP_SupplementsKeyID = k;
                                                SupplementsObj.PP_SupplementsKeyValue = prgPrsObj.PP_Key3;
                                                foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                                SupplementsObj.PP_SupplementCode = foodListObj.Food_Code;
                                                SupplementsObj.PP_SupplementsName = foodListObj.Food_Name;
                                                if (prgPrsCustomObj.PP_strAllSupplements == null)
                                                    prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name;
                                                else
                                                {
                                                    prgPrsCustomObj.PP_strAllSupplements += " , " + foodListObj.Food_Name;
                                                }
                                                foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                                SupplementsObj.PP_SupplementPricePerson = foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.sumAllSupplementsPrice += foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.PP_sumAllFoodSupplementPrice += Convert.ToInt32(foodPriceProxyObj.FP_Price);

                                            }
                                            break;
                                        }
                                    case 4:
                                        {
                                            if (prgPrsObj.PP_Key4 == true)
                                            {

                                                short? weekKeyValue = weekSupplementsCustomList.SingleOrDefault(kf => kf.Week_KeyID == k).Week_KeyValue;
                                                SupplementsObj.PP_SupplementsKeyID = k;
                                                SupplementsObj.PP_SupplementsKeyValue = prgPrsObj.PP_Key4;
                                                foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                                SupplementsObj.PP_SupplementCode = foodListObj.Food_Code;
                                                SupplementsObj.PP_SupplementsName = foodListObj.Food_Name;
                                                if (prgPrsCustomObj.PP_strAllSupplements == null)
                                                    prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name;
                                                else
                                                {
                                                    prgPrsCustomObj.PP_strAllSupplements += " , " + foodListObj.Food_Name;
                                                }
                                                foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                                SupplementsObj.PP_SupplementPricePerson = foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.sumAllSupplementsPrice += foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.PP_sumAllFoodSupplementPrice += Convert.ToInt32(foodPriceProxyObj.FP_Price);

                                            }
                                            break;
                                        }
                                    case 5:
                                        {
                                            if (prgPrsObj.PP_Key5 == true)
                                            {

                                                short? weekKeyValue = weekSupplementsCustomList.SingleOrDefault(kf => kf.Week_KeyID == k).Week_KeyValue;
                                                SupplementsObj.PP_SupplementsKeyID = k;
                                                SupplementsObj.PP_SupplementsKeyValue = prgPrsObj.PP_Key5;
                                                foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                                SupplementsObj.PP_SupplementCode = foodListObj.Food_Code;
                                                SupplementsObj.PP_SupplementsName = foodListObj.Food_Name;
                                                if (prgPrsCustomObj.PP_strAllSupplements == null)
                                                    prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name;
                                                else
                                                {
                                                    prgPrsCustomObj.PP_strAllSupplements += " , " + foodListObj.Food_Name;
                                                }
                                                foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                                SupplementsObj.PP_SupplementPricePerson = foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.sumAllSupplementsPrice += foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.PP_sumAllFoodSupplementPrice += Convert.ToInt32(foodPriceProxyObj.FP_Price);

                                            }
                                            break;
                                        }
                                    case 6:
                                        {
                                            if (prgPrsObj.PP_Key6 == true)
                                            {

                                                short? weekKeyValue = weekSupplementsCustomList.SingleOrDefault(kf => kf.Week_KeyID == k).Week_KeyValue;
                                                SupplementsObj.PP_SupplementsKeyID = k;
                                                SupplementsObj.PP_SupplementsKeyValue = prgPrsObj.PP_Key6;
                                                foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                                SupplementsObj.PP_SupplementCode = foodListObj.Food_Code;
                                                SupplementsObj.PP_SupplementsName = foodListObj.Food_Name;
                                                if (prgPrsCustomObj.PP_strAllSupplements == null)
                                                    prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name;
                                                else
                                                {
                                                    prgPrsCustomObj.PP_strAllSupplements += " , " + foodListObj.Food_Name;
                                                }
                                                foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                                SupplementsObj.PP_SupplementPricePerson = foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.sumAllSupplementsPrice += foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.PP_sumAllFoodSupplementPrice += Convert.ToInt32(foodPriceProxyObj.FP_Price);

                                            }
                                            break;
                                        }
                                    case 7:
                                        {
                                            if (prgPrsObj.PP_Key7 == true)
                                            {

                                                short? weekKeyValue = weekSupplementsCustomList.SingleOrDefault(kf => kf.Week_KeyID == k).Week_KeyValue;
                                                SupplementsObj.PP_SupplementsKeyID = k;
                                                SupplementsObj.PP_SupplementsKeyValue = prgPrsObj.PP_Key7;
                                                foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                                SupplementsObj.PP_SupplementCode = foodListObj.Food_Code;
                                                SupplementsObj.PP_SupplementsName = foodListObj.Food_Name;
                                                if (prgPrsCustomObj.PP_strAllSupplements == null)
                                                    prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name;
                                                else
                                                {
                                                    prgPrsCustomObj.PP_strAllSupplements += " , " + foodListObj.Food_Name;
                                                }
                                                foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                                SupplementsObj.PP_SupplementPricePerson = foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.sumAllSupplementsPrice += foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.PP_sumAllFoodSupplementPrice += Convert.ToInt32(foodPriceProxyObj.FP_Price);

                                            }
                                            break;
                                        }
                                    case 8:
                                        {
                                            if (prgPrsObj.PP_Key8 == true)
                                            {

                                                short? weekKeyValue = weekSupplementsCustomList.SingleOrDefault(kf => kf.Week_KeyID == k).Week_KeyValue;
                                                SupplementsObj.PP_SupplementsKeyID = k;
                                                SupplementsObj.PP_SupplementsKeyValue = prgPrsObj.PP_Key8;
                                                foodlist foodListObj = new BFood().GetFoodByID(weekKeyValue);
                                                SupplementsObj.PP_SupplementCode = foodListObj.Food_Code;
                                                SupplementsObj.PP_SupplementsName = foodListObj.Food_Name;
                                                if (prgPrsCustomObj.PP_strAllSupplements == null)
                                                    prgPrsCustomObj.PP_strAllSupplements += foodListObj.Food_Name;
                                                else
                                                {
                                                    prgPrsCustomObj.PP_strAllSupplements += " , " + foodListObj.Food_Name;
                                                }
                                                foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekKeyValue,personObj,paramDic);
                                                SupplementsObj.PP_SupplementPricePerson = foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.sumAllSupplementsPrice += foodPriceProxyObj.FP_Price;
                                                prgPrsCustomObj.PP_sumAllFoodSupplementPrice += Convert.ToInt32(foodPriceProxyObj.FP_Price);

                                            }
                                            break;
                                        }

                                    default:
                                        break;
                                }
                                SupplementsTempList.Add(SupplementsObj);
                            }
                            List<PrgPrsCustomizeModel.Supplements> SupplementsList = new List<PrgPrsCustomizeModel.Supplements>();
                            for (int f = 0; f < SupplementsTempList.Count; f++)
                            {
                                if(SupplementsTempList[f].PP_SupplementsKeyID!=null)
                                {
                                    SupplementsList.Add(SupplementsTempList[f]);
                                }
                            }
                            prgPrsCustomObj.PP_SupplementsList = SupplementsList;
                            prgPrsCustomList.Add(prgPrsCustomObj);
                        }


                    }

                   
                    


                }
                
                return prgPrsCustomList;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public int GetProgramPersonCountInDateByType(string date, short? type, string barcode)
        {
            try
            {
                int result = 0;
                List<prgpr> prgPrsList = prgPrsDAL.GetProgramFoodPersonByDate(barcode, date);
                result= prgPrsList.Count(p => p.PP_Type == type);
                return result;
                

            }
            catch (Exception ex)
            {       
                
                throw ex;
            }
        }
      

        public bool InsertProgramFoodPerson(PrgPrsCustomizeModel prgPrsCustom,Dictionary<string, string> paramDic)
        {
            try
            {
                person personObj=new BPerson().GetPersonByBarocde(prgPrsCustom.PP_PCode);
                //Validations **********************
                fish fishObj=new BFish().GetFishFoodPersonByDateByType(personObj, prgPrsCustom.PP_Date, prgPrsCustom.PP_Type ?? 0);
                
                if(fishObj!=null)
                    throw new Exception("در این وعده قبلا فیش ثبت شده است.امکان رزرو وجود ندارد");
                if (GetProgramPersonCountInDateByType(prgPrsCustom.PP_Date, prgPrsCustom.PP_Type, prgPrsCustom.PP_PCode) > 0)
                {
                    throw new Exception("در این وعده قبلا غذا رزرو شده است.امکان رزرو دیگری وجود ندارد.");
                }

                
                
                if (new BPerson().checkPersonHaveCredit(personObj,prgPrsCustom.PP_sumAllFoodSupplementPrice,paramDic) == false)
                {
                    throw new Exception("مجاز به رزرو غذا نیستید .اعتبار باقیمانده شما " + personObj.P_Credit + " ریال می باشد.");
                }
                wr_ReserveRange reserveRangeObj = new BReserveRange().GetReserveRange();
                string startDayOfMonthDate = prgPrsCustom.PP_Date.Substring(0, 8) + "01";
                string EndDayOfMonthDate = prgPrsCustom.PP_Date.Substring(0, 8) + Utility.GetEndDayOfMonth(prgPrsCustom.PP_Date);
                int countResevedFoodPerson = GetProgramFoodPersonCountInDateRange(prgPrsCustom.PP_PCode, startDayOfMonthDate, EndDayOfMonthDate);
                if (countResevedFoodPerson > reserveRangeObj.ReservRange_SAGHFRESERVE)
                {
                    throw new Exception("سقف رزرو غذا برای شما در این ماه به پایان رسیده است.");
                }
                List<WeekCustomizeModel> weekCustomList = new BWeek().GetFoodWeekByDateByType(personObj, prgPrsCustom.PP_Date, prgPrsCustom.PP_Type.GetValueOrDefault(0), paramDic);
                WeekCustomizeModel weekCustomObj= weekCustomList.SingleOrDefault(w => w.Week_KeyID == prgPrsCustom.PP_KeyID);
                if (weekCustomObj.Week_NValue <= GetprgPrsRegisteredCountInDate(prgPrsCustom.PP_Date,Convert.ToInt32(prgPrsCustom.PP_Type)))
                {
                    throw new Exception("سقف رزرو برای این غذا به پایان رسیده است.");
                }

               
                
                

                //*********************************
                prgpr prgPrsObj = CreatePrgPrsObjFromPrsCustomObj(prgPrsCustom);
                
                bool resultInsertProgramFood = false;
                if (new BPerson().IsPersonChangeCredit(personObj))
                {
                    List<TransactionProxy> transModelList=new List<TransactionProxy>();
                    
                    TransactionProxy transModelInsertPrtogramFood=new TransactionProxy(){
                    TypeQuery = TransactionProxy.TypeQueryEnum.Insert,
                    Object=prgPrsObj
                    };
                    transModelList.Add(transModelInsertPrtogramFood);

                    Dictionary<string ,string> WhereParametersPersonDic=new Dictionary<string,string>();
                    WhereParametersPersonDic.Add("P_BarCode",personObj.P_BarCode);
                    personObj.P_Credit = (personObj.P_Credit == null ? 0 : personObj.P_Credit) - prgPrsObj.PP_Price;
                    TransactionProxy transModelUpdatePerson=new TransactionProxy(){
                    TypeQuery=TransactionProxy.TypeQueryEnum.Update,
                    Object=personObj,
                    WhereParametersDic=WhereParametersPersonDic
                    };
                    transModelList.Add(transModelUpdatePerson);

                    resultInsertProgramFood = new TransactionDAL().ExecuteTransaction(transModelList);
                    
                }
                else
                {
                    resultInsertProgramFood=prgPrsDAL.InsertProgramFoodPerson(prgPrsObj);
                }
                return resultInsertProgramFood;
               

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public bool DeleteProgramFoodPerson(PrgPrsCustomizeModel prgPrsCustomObj, person personObj)

        {
            try
            {
               //Validations*************
                fish fishObj=new BFish().GetFishFoodPersonByDateByType(personObj, prgPrsCustomObj.PP_Date, prgPrsCustomObj.PP_Type ?? 0);

                if (fishObj != null)
                {
                    if (fishObj.Fish_Reserved == true)
                    throw new Exception("در این وعده قبلا فیش ثبت شده است.امکان حذف رزرو وجود ندارد");
                }
                prgpr prgPrsObj = CreatePrgPrsObjFromPrsCustomObj(prgPrsCustomObj);
                
                bool resultDeleteProgramFood = false;
                if (new BPerson().IsPersonChangeCredit(personObj))
                {
                    List<TransactionProxy> transModelList = new List<TransactionProxy>();
                    Dictionary<string, string> WhereParametersDeleteProgramDic = new Dictionary<string, string>();
                    WhereParametersDeleteProgramDic.Add("PP_Date", prgPrsCustomObj.PP_Date);
                    WhereParametersDeleteProgramDic.Add("PP_PCode", prgPrsCustomObj.PP_PCode);
                    WhereParametersDeleteProgramDic.Add("PP_Type", prgPrsCustomObj.PP_Type.ToString());
                    TransactionProxy transModelDeletePrtogramFood = new TransactionProxy()
                    {
                        TypeQuery = TransactionProxy.TypeQueryEnum.Delete,
                        Object = prgPrsObj,
                        WhereParametersDic = WhereParametersDeleteProgramDic
                    };
                    transModelList.Add(transModelDeletePrtogramFood);

                    Dictionary<string, string> WhereParametersPersonDic = new Dictionary<string, string>();
                    WhereParametersPersonDic.Add("P_BarCode", personObj.P_BarCode);
                    personObj.P_Credit = (personObj.P_Credit == null ? 0 : personObj.P_Credit) + prgPrsObj.PP_Price;
                    TransactionProxy transModelUpdatePerson = new TransactionProxy()
                    {
                        TypeQuery = TransactionProxy.TypeQueryEnum.Update,
                        Object = personObj,
                        WhereParametersDic = WhereParametersPersonDic
                    };
                    transModelList.Add(transModelUpdatePerson);

                    resultDeleteProgramFood = new TransactionDAL().ExecuteTransaction(transModelList);
                }
                else
                {
                   resultDeleteProgramFood= prgPrsDAL.DeleteProgramFoodPerson(prgPrsObj);
                }
                return resultDeleteProgramFood;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        
        public prgpr CreatePrgPrsObjFromPrsCustomObj(PrgPrsCustomizeModel prgCustom)
        {
            try
            {
                PrgPrsCustomizeModel prgPrsCutomObj = prgCustom;
                prgpr prgPrsObj = new prgpr();
                prgPrsObj.PP_Key1 = false;
                prgPrsObj.PP_Key2 = false;
                prgPrsObj.PP_Key3 = false;
                prgPrsObj.PP_Key4 = false;
                prgPrsObj.PP_Key5 = false;
                prgPrsObj.PP_Key6 = false;
                prgPrsObj.PP_Key7 = false;
                prgPrsObj.PP_Key8 = false;
                prgPrsObj.PP_Date = prgPrsCutomObj.PP_Date;
                prgPrsObj.PP_Building = prgPrsCutomObj.PP_Building;
                prgPrsObj.PP_PCode = prgPrsCutomObj.PP_PCode;
                prgPrsObj.PP_Type = prgPrsCutomObj.PP_Type;
                double sumKeys = 0;
                decimal? sumPrice = 0;
                for (int i = 1; i < 8; i++)
                {
                    switch (i)
                    {
                        case 1:
                            {
                                if (prgPrsCutomObj.PP_KeyID == i)
                                {
                                    prgPrsObj.PP_Key1 = prgPrsCutomObj.PP_KeyValue;
                                    sumPrice += prgPrsCutomObj.PP_FoodPricePerson;
                                    sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_KeyID)));
                                }


                                break;
                            }
                        case 2:
                            {
                                if (prgPrsCutomObj.PP_KeyID == i)
                                {
                                    prgPrsObj.PP_Key2 = prgPrsCutomObj.PP_KeyValue;
                                    sumPrice += prgPrsCutomObj.PP_FoodPricePerson;
                                    sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_KeyID)));
                                }

                                break;
                            }
                        case 3:
                            {
                                if (prgPrsCutomObj.PP_KeyID == i)
                                {
                                    prgPrsObj.PP_Key3 = prgPrsCutomObj.PP_KeyValue;
                                    sumPrice += prgPrsCutomObj.PP_FoodPricePerson;
                                    sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_KeyID)));
                                }

                                break;
                            }
                        case 4:
                            {
                                if (prgPrsCutomObj.PP_KeyID == i)
                                {
                                    prgPrsObj.PP_Key4 = prgPrsCutomObj.PP_KeyValue;
                                    sumPrice += prgPrsCutomObj.PP_FoodPricePerson;
                                    sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_KeyID)));
                                }

                                break;
                            }
                        case 5:
                            {
                                if (prgPrsCutomObj.PP_KeyID == i)
                                {
                                    prgPrsObj.PP_Key5 = prgPrsCutomObj.PP_KeyValue;
                                    sumPrice += prgPrsCutomObj.PP_FoodPricePerson;
                                    sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_KeyID)));
                                }

                                break;
                            }
                        case 6:
                            {
                                if (prgPrsCutomObj.PP_KeyID == i)
                                {
                                    prgPrsObj.PP_Key6 = prgPrsCutomObj.PP_KeyValue;
                                    sumPrice += prgPrsCutomObj.PP_FoodPricePerson;
                                    sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_KeyID)));
                                }

                                break;
                            }
                        case 7:
                            {
                                if (prgPrsCutomObj.PP_KeyID == i)
                                {
                                    prgPrsObj.PP_Key7 = prgPrsCutomObj.PP_KeyValue;
                                    sumPrice += prgPrsCutomObj.PP_FoodPricePerson;
                                    sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_KeyID)));
                                }

                                break;
                            }
                        case 8:
                            {
                                if (prgPrsCutomObj.PP_KeyID == i)
                                {
                                    prgPrsObj.PP_Key8 = prgPrsCutomObj.PP_KeyValue;
                                    sumPrice += prgPrsCutomObj.PP_FoodPricePerson;
                                    sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_KeyID)));
                                }

                                break;
                            }
                        default:
                            break;
                    }
                }
                for (int i = 0; i < prgPrsCutomObj.PP_SupplementsList.Count; i++)
                {

                    switch (prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)
                    {
                        case 1:
                            {

                                prgPrsObj.PP_Key1 = prgPrsCutomObj.PP_KeyValue;
                                sumPrice += prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementPricePerson;
                                sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)));


                                break;
                            }
                        case 2:
                            {

                                prgPrsObj.PP_Key2 = prgPrsCutomObj.PP_KeyValue;
                                sumPrice += prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementPricePerson;
                                sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)));

                                break;
                            }
                        case 3:
                            {

                                prgPrsObj.PP_Key3 = prgPrsCutomObj.PP_KeyValue;
                                sumPrice += prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementPricePerson;
                                sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)));

                                break;
                            }
                        case 4:
                            {

                                prgPrsObj.PP_Key4 = prgPrsCutomObj.PP_KeyValue;
                                sumPrice += prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementPricePerson;
                                sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)));

                                break;
                            }
                        case 5:
                            {

                                prgPrsObj.PP_Key5 = prgPrsCutomObj.PP_KeyValue;
                                sumPrice += prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementPricePerson;
                                sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)));

                                break;
                            }
                        case 6:
                            {

                                prgPrsObj.PP_Key6 = prgPrsCutomObj.PP_KeyValue;
                                sumPrice += prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementPricePerson;
                                sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)));

                                break;
                            }
                        case 7:
                            {

                                prgPrsObj.PP_Key7 = prgPrsCutomObj.PP_KeyValue;
                                sumPrice += prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementPricePerson;
                                sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)));

                                break;
                            }
                        case 8:
                            {

                                prgPrsObj.PP_Key8 = prgPrsCutomObj.PP_KeyValue;
                                sumPrice += prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementPricePerson;
                                sumKeys += (Math.Pow(2, Convert.ToDouble(prgPrsCutomObj.PP_SupplementsList[i].PP_SupplementsKeyID)));

                                break;
                            }
                        default:
                            break;
                    }
                }

                prgPrsObj.PP_Keys = Convert.ToInt16(sumKeys);
                prgPrsObj.PP_Price = sumPrice;
                return prgPrsObj;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }


        
        public int GetProgramFoodPersonCountInDateRange(string barcode, string fromDate, string toDate)
        {

            try
            {
                return prgPrsDAL.GetProgramFoodPersonCountInDateRange(barcode, fromDate, toDate);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public class ReserveDateRangePermitted
        {
            public string FromDate { get; set; }
            public string ToDate { get; set; }

        }

        public List<string> GetReserveDatePermittedList()
        {
            try
            {
                List<string> dateRangeList = new List<string>();
                ReserveDateRangePermitted rdrpObj = new ReserveDateRangePermitted();
                wr_ReserveRange reserveRangeObj = new BReserveRange().GetReserveRange();
                wr_DynamicReserveRange dynamicReserveRange = new BDynamicReservRange().GetDynamicReservRange();
                DateTime currentDate = DateTime.Now;
                DateTime enFromDate = new DateTime();
                DateTime enToDate=new DateTime();
                string toDate = string.Empty;
                if (dynamicReserveRange != null && reserveRangeObj != null)
                {
                    switch (dynamicReserveRange.DynamicReservRange_FromDateType)
                    {

                        case 0:
                            {
                                enFromDate = currentDate.AddDays(Convert.ToDouble(dynamicReserveRange.DynamicReservRange_FromDateCount));
                                break;
                            }
                        case 1:
                            {
                                enFromDate = currentDate.AddDays(Convert.ToDouble((dynamicReserveRange.DynamicReservRange_FromDateCount * 7)));
                                break;
                            }

                        default:
                            break;
                    }


                    switch (reserveRangeObj.ReservRange_EndDateType)
                    {

                        case 0:
                            {
                                enToDate = enFromDate.AddDays(Convert.ToDouble(reserveRangeObj.ReservRange_EndDateCount));
                                break;
                            }
                        case 1:
                            {
                                enToDate = enFromDate.AddDays(Convert.ToDouble((reserveRangeObj.ReservRange_EndDateCount * 7)));
                                break;
                            }
                        case 2:
                            {
                                enToDate = enFromDate.AddMonths(Convert.ToInt32(reserveRangeObj.ReservRange_EndDateCount));
                                break;
                            }
                        default:
                            break;
                    }

                    for (var day = enFromDate; day.Date <= enToDate; day = day.AddDays(1))
                    {
                        dateRangeList.Add(Utility.MiladiToShamsi(day));
                    }
                }
                return dateRangeList;

            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        public int GetprgPrsRegisteredCountInDate(string date,int type)
        {
            try
            {
                return prgPrsDAL.GetprgPrsRegisteredCountInDate(date, type);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
    }
}
