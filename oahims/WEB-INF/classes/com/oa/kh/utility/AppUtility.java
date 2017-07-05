/*
 * Created on Jul 4, 2006
 *
 * To change the template for this generated file go to
 * Window>Preferences>Java>Code Generation>Code and Comments
 */
package com.oa.kh.utility;

import java.text.*;
import java.util.*;
import java.io.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.sql.*;
import java.sql.*;

/**
 * @author Administrator
 *
 * To change the template for this generated type comment go to
 * Window>Preferences>Java>Code Generation>Code and Comments
 */
public class AppUtility {

	Connection con = null;

	public AppUtility() {}

	public void Connect()
	{
		OAHIMSConnection userConn = new OAHIMSConnection();
		try{
			con = userConn.Connect();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public void DisConnect()
	{
		OAHIMSConnection userConn = new OAHIMSConnection();
		try{
			userConn.DisConnect();
		}catch(Exception e){
			e.printStackTrace();
		}
    }

	public String ChangeDateFormatToMySQL(String dateString)
	{
		String sqlDate = "";
		if(dateString == ""){
			sqlDate = "";
		}else{
			SimpleDateFormat NICE_DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

			SimpleDateFormat SQL_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

			Date date = new Date();

			try {
				date = NICE_DATE_FORMAT.parse(dateString);
			} catch (ParseException pe) {
				pe.printStackTrace();
			}

			sqlDate = SQL_DATE_FORMAT.format(date);
		}
		return sqlDate;
	}

	public String ChangeDateFormatToDisplay(String dateString)
		{
			SimpleDateFormat NICE_DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy");

			SimpleDateFormat SQL_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

			Date date = new Date();

			try {
				date = SQL_DATE_FORMAT.parse(dateString);
			} catch (ParseException pe) {
				pe.printStackTrace();
			}

			String sqlDate = NICE_DATE_FORMAT.format(date);

		return sqlDate;
	}

	public String GetSystemDateToDisplay()
	{
			SimpleDateFormat NICE_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			String sqlDate = NICE_DATE_FORMAT.format(date);
			return sqlDate;
	}

	public String GetSystemDateTimeToDisplay()
	{
			SimpleDateFormat NICE_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
			Date date = new Date();
			String sqlDate = NICE_DATE_FORMAT.format(date);
			return sqlDate;
	}

	public String CommaFilterText(String mStr,int mStat){
		String trimStr, mReturn = "";
		trimStr = mStr.trim();
		if (trimStr.length() > 0){
			if( mStat == 0){
				//Character.toString ((char) asciiCode)
				mReturn = trimStr.replace(Character.toString ((char) 39), "]#[");
				mReturn = mReturn.replace(Character.toString ((char) 34), "}#{");
			}else if( mStat == 1){
				mReturn = trimStr.replace("]#[", Character.toString ((char) 39));
				mReturn = mReturn.replace("}#{", Character.toString ((char) 34));
			}
		}
		return mReturn;
	}

	public void CreateEventLog(String strDesc,String byUser){
		int no = 0;
		if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
				 String objStr = "insert into event_log(crDateTime,Description,byUser) values("
				 	+ "'" + GetSystemDateTimeToDisplay() +  "',"
				 	+ "'" + CommaFilterText(strDesc,0) + "',"
				 	+ "'" + byUser + "')";
                 System.out.println("CreateEventLog === " + objStr);
				 no=st.executeUpdate(objStr);
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
	}

	public String GenerateFormatedNo(String strType){
		int no = 0;
		String retFormat = "";
		try
		 {
			 Statement st=con.createStatement();
			 ResultSet rs = null;
			 String objStr = "select * from mbillformatmaster where BillFormatName = '" + strType + "'";
			 rs = st.executeQuery(objStr);
			 while(rs.next()){
				no = rs.getInt("StartingFrom");
				retFormat = rs.getString("BillPrefix");
			 }
			 rs.close();

			 retFormat = retFormat + no;

			 objStr = "update mbillformatmaster set StartingFrom=StartingFrom+1 where BillFormatName = '" + strType + "'";
			 no=st.executeUpdate(objStr);

		 }catch(Exception e)
		 {
			  e.printStackTrace();
		 }
		return retFormat;
	}

}