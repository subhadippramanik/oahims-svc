package com.oa.kh.pharmacy;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class PharmacyItems {
    Connection con = null;
    String error;
    String msg;

    public PharmacyItems() {
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

    public int checkPharmacyItemsId(String testcode){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM mst_pharmacyItems where testcode='"+testcode+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkPharmacyItemsId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

    public String getPharmacyItemsCode(String objid)
		{
			String testcode="";
			if(con != null)
			{
				 try
				 {
					 Statement st=con.createStatement();
					 ResultSet rs = null;
					 rs=st.executeQuery("select * FROM mst_pharmacyItems where objid="+objid);
					 while(rs.next()){
						 testcode = rs.getString("testcode");
						 System.out.println("getPharmacyItemsCode ===" + testcode);
					 }
					 rs.close();
				 }catch(Exception e)
				 {
					  e.printStackTrace();
				 }
			}
			return testcode;
	}

	public String getPharmacyItemsName(String testcode)
	{
		String testname="";
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select * FROM mst_pharmacyItems where testcode='"+testcode+"'");
				 while(rs.next()){
					 testname = rs.getString("testname");
					 System.out.println("getPharmacyItemsName ===" + testname);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return  testname;
	}

	public ResultSet listPharmacyItemsById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM mst_pharmacyItems where objid="+objid);
			 	 }else{
				 rs=st.executeQuery("select * FROM mst_pharmacyItems");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public int deletePharmacyItems(String objid){
		int no = 0;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 	String strDelete = "delete from mst_pharmacyItems where objid=" + objid;
					System.out.println("deletePharmacyItems===" + strDelete);
				 	no=st.executeUpdate(strDelete);
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}
	objid bigint(20) NOT NULL
grpobjid bigint(20) NULL
grpname varchar(56) NULL
medcode varchar(32) NULL
medname varchar(132) NULL
medgenname varchar(132) NULL
medbatch varchar(32) NULL
medexp date NULL
uomr varchar(12) NULL
uomi varchar(12) NULL
mfgby varchar(100) NULL
pkgdunit int(11) NULL
discount double NULL
retailprice double NULL
	public void addPharmacyItems(String grpobjid,String grpname,String medcode,String medname,String medgenname,String medbatch,String medexp,
								String uomr,String uomi,String mfgby,String pkgdunit,String discount,String retailprice) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into mst_pharmacyItems(grpobjid,testcode,testname,temperature,methodology,price,maxlessallowed) values("
								+ "" + grpobjid + ","
								+ "'" + testcode + "',"
								+ "'" + testname.toUpperCase() + "',"
								+ "'" + temperature + "',"
								+ "'" + methodology + "',"
								+ "" + price + ","
								+ "" + maxlessallowed + ")";

				System.out.println("addPharmacy===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

	public int updatePharmacy(String objid,String grpobjid,String testcode,String testname,String temperature,
							String methodology,String price,String maxlessallowed) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate = "update mst_pharmacyItems set grpobjid="+grpobjid+",testcode='"+testcode+"',testname='"+testname.toUpperCase()+"',temperature='"+temperature+"',methodology='" + methodology + "',price="+price+",maxlessallowed="+maxlessallowed+" where objid="+objid;
				System.out.println("updatePharmacy===" + strUpdate);
				no=st.executeUpdate(strUpdate);
			}catch(Exception e)
			{
			  e.printStackTrace();
			}
		}
	  return no;
   }
    
}
