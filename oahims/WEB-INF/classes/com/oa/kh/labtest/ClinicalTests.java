package com.oa.kh.labtest;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class ClinicalTests {
    Connection con = null;
    String error;
    String msg;

    public ClinicalTests() {
    }

    public String getMessage(){
        return this.msg;
    }

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

    public int checkClinicalTestsId(String testcode){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM mst_clinicaltests where testcode='"+testcode+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkClinicalTestsId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

    public String getClinicalTestsCode(String objid)
		{
			String testcode="";
			if(con != null)
			{
				 try
				 {
					 Statement st=con.createStatement();
					 ResultSet rs = null;
					 rs=st.executeQuery("select * FROM mst_clinicaltests where objid="+objid);
					 while(rs.next()){
						 testcode = rs.getString("testcode");
						 System.out.println("getClinicalTestsCode ===" + testcode);
					 }
					 rs.close();
				 }catch(Exception e)
				 {
					  e.printStackTrace();
				 }
			}
			return testcode;
	}

	public String getClinicalTestsName(String testcode)
	{
		String testname="";
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select * FROM mst_clinicaltests where testcode='"+testcode+"'");
				 while(rs.next()){
					 testname = rs.getString("testname");
					 System.out.println("getClinicalTestsName ===" + testname);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return  testname;
	}

	public ResultSet listClinicalTestsById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM mst_clinicaltests where objid="+objid);
			 	 }else{
				 rs=st.executeQuery("select * FROM mst_clinicaltests");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public int deleteClinicalTests(String objid){
		int no = 0;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 	String strDelete = "delete from mst_clinicaltests where objid=" + objid;
					System.out.println("deleteClinicalTests===" + strDelete);
				 	no=st.executeUpdate(strDelete);
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}
	
	public void addClinicalTests(String grpobjid,String testcode,String testname,String temperature,String methodology,
								String price,String maxlessallowed) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into mst_clinicaltests(grpobjid,testcode,testname,temperature,methodology,price,maxlessallowed) values("
								+ "" + grpobjid + ","
								+ "'" + testcode + "',"
								+ "'" + testname.toUpperCase() + "',"
								+ "'" + temperature + "',"
								+ "'" + methodology + "',"
								+ "" + price + ","
								+ "" + maxlessallowed + ")";

				System.out.println("addClinicalTests===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

	public int updateClinicalTests(String objid,String grpobjid,String testcode,String testname,String temperature,
							String methodology,String price,String maxlessallowed) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate = "update mst_clinicaltests set grpobjid="+grpobjid+",testcode='"+testcode+"',testname='"+testname.toUpperCase()+"',temperature='"+temperature+"',methodology='" + methodology + "',price="+price+",maxlessallowed="+maxlessallowed+" where objid="+objid;
				System.out.println("updateClinicalTests===" + strUpdate);
				no=st.executeUpdate(strUpdate);
			}catch(Exception e)
			{
			  e.printStackTrace();
			}
		}
	  return no;
   }
    
}
