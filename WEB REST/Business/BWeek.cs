using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using Model;
namespace Business
{
    public class BWeek
    {

        private WeekDAL weekDAL
        {

            get
            {
                return new WeekDAL();
            }
        }
        private Int64 ConvertDecimalToLong(decimal? price)
        {
            try
            {
                return Convert.ToInt64(price == null ? 0 : price);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public List<WeekCustomizeModel> GetFoodWeekByDateByType(person personObj,string date, short type, Dictionary<string, string> paramDic)
        {

            try
            {
                week weekObj = weekDAL.GetFoodWeekByDateByType(date, type);
                List<WeekCustomizeModel> weekCustomList = new List<WeekCustomizeModel>();
               
                if (weekObj == null)
                    return weekCustomList;


                short MaxCountMeal = 0;

                switch (weekObj.Week_Type)
                {
                    case 1:
                        {
                            MaxCountMeal = Convert.ToInt16(paramDic["SobhKeyNo"]);
                            break;
                        }
                    case 2:
                        {
                            MaxCountMeal = Convert.ToInt16(paramDic["NaharKeyNo"]);
                            break;
                        }
                    case 3:
                        {
                            MaxCountMeal = Convert.ToInt16(paramDic["ShamKeyNo"]);
                            break;
                        }
                    default:
                        break;
                }
                for (short i = 1; i <= MaxCountMeal; i++)
                {
                    WeekCustomizeModel weekCustomObj = new WeekCustomizeModel();
                    weekCustomObj.Week_Date = weekObj.Week_Date;
                    weekCustomObj.Week_Type = weekObj.Week_Type;
                    switch (i)
                    {
                        case 1:
                            {
                                if (weekObj.Week_Key1 != 0)
                                {

                                    weekCustomObj.Week_KeyID = i;
                                    weekCustomObj.Week_KeyValue = weekObj.Week_Key1;
                                    weekCustomObj.Week_NID = i;
                                    weekCustomObj.Week_NValue = weekObj.Week_N1;
                                    foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key1);
                                    weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                    weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                    foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key1, personObj, paramDic);
                                    weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                }
                                break;
                            }
                        case 2:
                            {
                                if (weekObj.Week_Key2 != 0)
                                {

                                    weekCustomObj.Week_KeyID = i;
                                    weekCustomObj.Week_KeyValue = weekObj.Week_Key2;
                                    weekCustomObj.Week_NID = i;
                                    weekCustomObj.Week_NValue = weekObj.Week_N2;
                                    foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key2);
                                    weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                    weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                    foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key2, personObj, paramDic);
                                    weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                }

                                break;
                            }
                        case 3:
                            {
                                if (weekObj.Week_Key3 != 0)
                                {
                                    weekCustomObj.Week_KeyID = i;
                                    weekCustomObj.Week_KeyValue = weekObj.Week_Key3;
                                    weekCustomObj.Week_NID = i;
                                    weekCustomObj.Week_NValue = weekObj.Week_N3;
                                    foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key3);
                                    weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                    weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                    foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key3, personObj, paramDic);
                                    weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                }

                                break;
                            }
                        case 4:
                            {
                                if (weekObj.Week_Key4 != 0)
                                {

                                    weekCustomObj.Week_KeyID = i;
                                    weekCustomObj.Week_KeyValue = weekObj.Week_Key4;
                                    weekCustomObj.Week_NID = i;
                                    weekCustomObj.Week_NValue = weekObj.Week_N4;
                                    foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key4);
                                    weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                    weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                    foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key4, personObj, paramDic);
                                    weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                }

                                break;
                            }
                        case 5:
                            {
                                if (weekObj.Week_Key5 != 0)
                                {

                                    weekCustomObj.Week_KeyID = i;
                                    weekCustomObj.Week_KeyValue = weekObj.Week_Key5;
                                    weekCustomObj.Week_NID = i;
                                    weekCustomObj.Week_NValue = weekObj.Week_N5;
                                    foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key5);
                                    weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                    weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                    foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key5, personObj, paramDic);
                                    weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                }

                                break;
                            }
                        case 6:
                            {
                                if (weekObj.Week_Key6 != 0)
                                {

                                    weekCustomObj.Week_KeyID = i;
                                    weekCustomObj.Week_KeyValue = weekObj.Week_Key6;
                                    weekCustomObj.Week_NID = i;
                                    weekCustomObj.Week_NValue = weekObj.Week_N6;
                                    foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key6);
                                    weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                    weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                    foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key6, personObj, paramDic);
                                    weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                }

                                break;
                            }
                        case 7:
                            {
                                if (weekObj.Week_Key7 != 0)
                                {

                                    weekCustomObj.Week_KeyID = i;
                                    weekCustomObj.Week_KeyValue = weekObj.Week_Key7;
                                    weekCustomObj.Week_NID = i;
                                    weekCustomObj.Week_NValue = weekObj.Week_N7;
                                    foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key7);
                                    weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                    weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                    foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key7, personObj, paramDic);
                                    weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                }

                                break;
                            }
                        case 8:
                            {
                                if (weekObj.Week_Key8 != 0)
                                {

                                    weekCustomObj.Week_KeyID = i;
                                    weekCustomObj.Week_KeyValue = weekObj.Week_Key8;
                                    weekCustomObj.Week_NID = i;
                                    weekCustomObj.Week_NValue = weekObj.Week_N8;
                                    foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key8);
                                    weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                    weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                    foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key8, personObj, paramDic);
                                    weekCustomObj.Week_FoodPricePerson =ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                }

                                break;
                            }
                        default:
                            break;
                    }

                    if(weekCustomObj.Week_KeyID!=null)
                    weekCustomList.Add(weekCustomObj);



                }






                
                return weekCustomList;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        
        public List<WeekCustomizeModel> GetSupplementsWeekByDateByType(person personObj,string date, short type, Dictionary<string, string> paramDic)
        {

            try
            {
                week weekObj = weekDAL.GetFoodWeekByDateByType(date, type);
                List<WeekCustomizeModel> weekCustomList = new List<WeekCustomizeModel>();
                
                if (weekObj == null)
                    return weekCustomList;
                
                    
                    short MaxCountMeal = 0;

                    switch (weekObj.Week_Type)
                    {
                        case 1:
                            {
                                MaxCountMeal = Convert.ToInt16(paramDic["SobhKeyNo"]);
                                break;
                            }
                        case 2:
                            {
                                MaxCountMeal = Convert.ToInt16(paramDic["NaharKeyNo"]);
                                break;
                            }
                        case 3:
                            {
                                MaxCountMeal = Convert.ToInt16(paramDic["ShamKeyNo"]);
                                break;
                            }
                        default:
                            break;
                    }
                    for (short i = Convert.ToInt16((MaxCountMeal + 1)); i <= 8; i++)
                    {
                        WeekCustomizeModel weekCustomObj = new WeekCustomizeModel();
                        weekCustomObj.Week_Date = weekObj.Week_Date;
                        weekCustomObj.Week_Type = weekObj.Week_Type;
                        switch (i)
                        {
                            case 1:
                                {
                                    if (weekObj.Week_Key1 != 0)
                                    {

                                        weekCustomObj.Week_KeyID = i;
                                        weekCustomObj.Week_KeyValue = weekObj.Week_Key1;
                                        weekCustomObj.Week_NID = i;
                                        weekCustomObj.Week_NValue = weekObj.Week_N1;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key1);
                                        weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                        weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key1, personObj, paramDic);
                                        weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                    }
                                    break;
                                }
                            case 2:
                                {
                                    if (weekObj.Week_Key2 != 0)
                                    {

                                        weekCustomObj.Week_KeyID = i;
                                        weekCustomObj.Week_KeyValue = weekObj.Week_Key2;
                                        weekCustomObj.Week_NID = i;
                                        weekCustomObj.Week_NValue = weekObj.Week_N2;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key2);
                                        weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                        weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key2, personObj, paramDic);
                                        weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                    }

                                    break;
                                }
                            case 3:
                                {
                                    if (weekObj.Week_Key3 != 0)
                                    {
                                        
                                        weekCustomObj.Week_KeyID = i;
                                        weekCustomObj.Week_KeyValue = weekObj.Week_Key3;
                                        weekCustomObj.Week_NID = i;
                                        weekCustomObj.Week_NValue = weekObj.Week_N3;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key3);
                                        weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                        weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key3, personObj, paramDic);
                                        weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                    }

                                    break;
                                }
                            case 4:
                                {
                                    if (weekObj.Week_Key4 != 0)
                                    {

                                        weekCustomObj.Week_KeyID = i;
                                        weekCustomObj.Week_KeyValue = weekObj.Week_Key4;
                                        weekCustomObj.Week_NID = i;
                                        weekCustomObj.Week_NValue = weekObj.Week_N4;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key4);
                                        weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                        weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key4, personObj, paramDic);
                                        weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                    }

                                    break;
                                }
                            case 5:
                                {
                                    if (weekObj.Week_Key5 != 0)
                                    {

                                        weekCustomObj.Week_KeyID = i;
                                        weekCustomObj.Week_KeyValue = weekObj.Week_Key5;
                                        weekCustomObj.Week_NID = i;
                                        weekCustomObj.Week_NValue = weekObj.Week_N5;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key5);
                                        weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                        weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key5, personObj, paramDic);
                                        weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                    }

                                    break;
                                }
                            case 6:
                                {
                                    if (weekObj.Week_Key6 != 0)
                                    {

                                        weekCustomObj.Week_KeyID = i;
                                        weekCustomObj.Week_KeyValue = weekObj.Week_Key6;
                                        weekCustomObj.Week_NID = i;
                                        weekCustomObj.Week_NValue = weekObj.Week_N6;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key6);
                                        weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                        weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key6, personObj, paramDic);
                                        weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                    }

                                    break;
                                }
                            case 7:
                                {
                                    if (weekObj.Week_Key7 != 0)
                                    {

                                        weekCustomObj.Week_KeyID = i;
                                        weekCustomObj.Week_KeyValue = weekObj.Week_Key7;
                                        weekCustomObj.Week_NID = i;
                                        weekCustomObj.Week_NValue = weekObj.Week_N7;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key7);
                                        weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                        weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key7, personObj, paramDic);
                                        weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                    }

                                    break;
                                }
                            case 8:
                                {
                                    if (weekObj.Week_Key8 != 0)
                                    {

                                        weekCustomObj.Week_KeyID = i;
                                        weekCustomObj.Week_KeyValue = weekObj.Week_Key8;
                                        weekCustomObj.Week_NID = i;
                                        weekCustomObj.Week_NValue = weekObj.Week_N8;
                                        foodlist foodListObj = new BFood().GetFoodByID(weekObj.Week_Key8);
                                        weekCustomObj.Week_FoodName = foodListObj.Food_Name;
                                        weekCustomObj.Week_FoodCode = foodListObj.Food_Code;
                                        foodPriceProxy foodPriceProxyObj = new BFoodPrice().GetFoodPricePersonByFoodCode(weekObj.Week_Key8, personObj, paramDic);
                                        weekCustomObj.Week_FoodPricePerson = ConvertDecimalToLong(foodPriceProxyObj.FP_Price);


                                    }

                                    break;
                                }
                            default:
                                break;
                        }

                        if(weekCustomObj.Week_KeyID!=null)
                        weekCustomList.Add(weekCustomObj);


                    }
                
             return weekCustomList;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
