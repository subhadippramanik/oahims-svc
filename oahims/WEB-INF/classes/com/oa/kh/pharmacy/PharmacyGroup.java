package com.oa.kh.pharmacy;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class PharmacyGroup {
    Connection con = null;
    String error;
    String msg;

    public PharmacyGroup() {
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

    public int checkPharmacyGroupId(String grpcode){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM mst_pharmacygroup where grpcode='"+grpcode+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkPharmacyGroupId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

    public String getPharmacyGroupCode(String objid)
		{
			String grpcode="";
			if(con != null)
			{
				 try
				 {
					 Statement st=con.createStatement();
					 ResultSet rs = null;
					 rs=st.executeQuery("select * FROM mst_pharmacygroup where objid="+objid);
					 while(rs.next()){
						 grpcode = rs.getString("grpcode");
						 System.out.println("getPharmacyGroupCode ===" + grpcode);
					 }
					 rs.close();
				 }catch(Exception e)
				 {
					  e.printStackTrace();
				 }
			}
			return grpcode;
	}

	public String getPharmacyGroupName(String grpcode)
	{
		String grpname="";
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select * FROM mst_pharmacygroup where grpcode='"+grpcode+"'");
				 while(rs.next()){
					 grpname = rs.getString("grpname");
					 System.out.println("getPharmacyGroupName ===" + grpname);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return  grpname;
	}

	public ResultSet listPharmacyGroupById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM mst_pharmacygroup where objid="+objid);
			 	 }else{
				 rs=st.executeQuery("select * FROM mst_pharmacygroup");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public int deletePharmacyGroup(String objid){
		int no = 0;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 	String strDelete = "delete from mst_pharmacygroup where objid=" + objid;
					System.out.println("deletePharmacyGroup===" + strDelete);
				 	no=st.executeUpdate(strDelete);
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}

	public void addPharmacyGroup(String grpcode,String grpname,String isactive,String byuser) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into mst_pharmacygroup(grpcode,grpname,isactive,byuser) values("
								+ "'" + grpcode + "',"
								+ "'" + grpname.toUpperCase() + "',"
								+ "'" + isactive + "',"
								+ "'" + byuser + "')";

				System.out.println("addPharmacyGroup===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

	public int updatePharmacyGroup(String objid,String grpcode,String grpname,String isactive,String byuser) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate = "update mst_pharmacygroup set grpcode='"+dcode+"' ,grpname='"+grpname.toUpperCase()+"',isactive='"+isactive+"',byuser='" + byuser + "' where objid="+objid;
				System.out.println("updatePharmacyGroup===" + strUpdate);
				no=st.executeUpdate(strUpdate);
			}catch(Exception e)
			{
			  e.printStackTrace();
			}
		}
	  return no;
   }
    
}
