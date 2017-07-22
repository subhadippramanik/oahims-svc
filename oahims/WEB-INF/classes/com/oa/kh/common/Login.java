package com.oa.kh.common;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;

import com.oa.kh.utility.*;

public class Login
{
    Connection con = null;
	String error;

	/*public static void main(String args[]){
		Login login = new Login();
		System.out.println("OK PRM 1");
		login.Connect();
		System.out.println("OK PRM 2");
	}*/

	public Login(){}

	public void Connect()
	{
		OAHIMSConnection oaConn = new OAHIMSConnection();
		try{
			System.out.println("OK in Login Connect	:");
			con = oaConn.Connect();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public void DisConnect()
	{
			OAHIMSConnection oaConn = new OAHIMSConnection();
			try{
				oaConn.DisConnect();
			}catch(Exception e){
				e.printStackTrace();
			}
	}


   public int CheckLogin(String loginId,String pswd,String userType) throws SQLException
	{
      int no=0;
      ResultSet rs=null;
	  if(con!=null)
	     {
	       	try
	        {
	        	Statement st=con.createStatement();
	        	String strChk = "select * from user_mst where login='"+loginId+"' and pswd='"+pswd+"' and access_type=" + userType;
	        	System.out.println("Check_login==="+ strChk);
	        	rs = st.executeQuery(strChk);
	        	if (rs.next()){
					rs.beforeFirst();
					while(rs.next()){
						no=rs.getInt("access_type");
			    	 }
			    }
	       	}catch(Exception e)
			{
			e.printStackTrace();
			}
		}
       return no;
    }

    public int CheckSecurity(String loginId,String userType) throws SQLException
	{
		int no=1;
		if(loginId.length()==0){
			no=0;
		}

		if(userType.length()==0){
			no=0;
		}

		return no;
    }


}


