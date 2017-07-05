package com.oa.kh.labtest;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class ClinicalTestsGroup {
    Connection con = null;
    String error;
    String msg;

    public ClinicalTestsGroup() {
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

    public int checkClinicalTestsGroupId(String grpcode){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM mst_clinicaltestsgroup where grpcode='"+grpcode+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkClinicalTestsGroupId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

    public String getClinicalTestsGroupCode(String objid)
		{
			String grpcode="";
			if(con != null)
			{
				 try
				 {
					 Statement st=con.createStatement();
					 ResultSet rs = null;
					 rs=st.executeQuery("select * FROM mst_clinicaltestsgroup where objid="+objid);
					 while(rs.next()){
						 grpcode = rs.getString("grpcode");
						 System.out.println("getClinicalTestsGroupCode ===" + grpcode);
					 }
					 rs.close();
				 }catch(Exception e)
				 {
					  e.printStackTrace();
				 }
			}
			return grpcode;
	}

	public String getClinicalTestsGroupName(String grpcode)
	{
		String grpname="";
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select * FROM mst_clinicaltestsgroup where grpcode='"+grpcode+"'");
				 while(rs.next()){
					 grpname = rs.getString("grpname");
					 System.out.println("getClinicalTestsGroupName ===" + grpname);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return  grpname;
	}

	public ResultSet listClinicalTestsGroupById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM mst_clinicaltestsgroup where objid="+objid);
			 	 }else{
				 rs=st.executeQuery("select * FROM mst_clinicaltestsgroup");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public int deleteClinicalTestsGroup(String objid){
		int no = 0;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 	String strDelete = "delete from mst_clinicaltestsgroup where objid=" + objid;
					System.out.println("deleteClinicalTestsGroup===" + strDelete);
				 	no=st.executeUpdate(strDelete);
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}
	
	public void addClinicalTestsGroup(String grpcode,String grpname,String isactive,String byuser) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into mst_clinicaltestsgroup(grpcode,grpname,isactive,byuser) values("
								+ "'" + grpcode + "',"
								+ "'" + grpname.toUpperCase() + "',"
								+ "'" + isactive + "',"
								+ "'" + byuser + "')";

				System.out.println("addClinicalTestsGroup===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

	public int updateClinicalTestsGroup(String objid,String grpcode,String grpname,String isactive,String byuser) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate = "update mst_clinicaltestsgroup set grpcode='"+dcode+"' ,grpname='"+grpname.toUpperCase()+"',isactive='"+isactive+"',byuser='" + byuser + "' where objid="+objid;
				System.out.println("updateClinicalTestsGroup===" + strUpdate);
				no=st.executeUpdate(strUpdate);
			}catch(Exception e)
			{
			  e.printStackTrace();
			}
		}
	  return no;
   }
    
}
