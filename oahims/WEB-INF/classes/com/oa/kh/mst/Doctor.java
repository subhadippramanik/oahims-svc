package com.oa.kh.mst;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class Doctor {
    Connection con = null;
    String error;
    String msg;

    public Doctor() {
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

    public int checkDoctorId(String dcode){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM mst_doctor where dcode='"+dcode+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkDoctorId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

    public String getDoctorCode(String objid)
		{
			String doccode="";
			if(con != null)
			{
				 try
				 {
					 Statement st=con.createStatement();
					 ResultSet rs = null;
					 rs=st.executeQuery("select * FROM mst_doctor where objid="+objid);
					 while(rs.next()){
						 doccode = rs.getString("dcode");
						 System.out.println("getDoctorCode ===" + doccode);
					 }
					 rs.close();
				 }catch(Exception e)
				 {
					  e.printStackTrace();
				 }
			}
			return doccode;
	}

	public String getDoctorName(String dcode)
	{
		String docName="";
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select * FROM mst_doctor where dcode='"+dcode+"'");
				 while(rs.next()){
					 docName = rs.getString("dnamef") + " " + rs.getString("dnamem") + " " + rs.getString("dnamel");
					 System.out.println("getDoctorName ===" + docName);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return  docName;
	}

	public ResultSet listDoctorById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM mst_doctor where objid="+objid);
			 	 }else{
				 rs=st.executeQuery("select * FROM mst_doctor");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public int deleteDoctor(String objid){
		int no = 0;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 	String strDelete = "delete from mst_doctor where objid=" + objid;
					System.out.println("deleteDoctor===" + strDelete);
				 	no=st.executeUpdate(strDelete);
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}

	public void addDoctor(String dcode,String dnamef,String dnamem,String dnamel,String contactno,String dadd,String isactive,String byuser) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into mst_doctor(dcode,dnamef,dnamem,dnamel,contactno,dadd,isactive,byuser) values("
								+ "'" + dcode + "',"
								+ "'" + dnamef.toUpperCase() + "',"
								+ "'" + dnamem.toUpperCase() + "',"
								+ "'" + dnamel.toUpperCase() + "',"
								+ "'" + contactno + "',"
								+ "'" + dadd + "',"
								+ "'" + isactive + "',"
								+ "'" + byuser + "')";

				System.out.println("addDoctor===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

	public int updateDoctor(String objid,String dcode,String dnamef,String dnamem,String dnamel,String contactno,String dadd,String isactive,String byuser) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate = "update mst_doctor set dcode='"+dcode+"' ,dnamef='"+dnamef.toUpperCase()+"' ,dnamem='"+dnamem.toUpperCase()+"' ,dnamel='"+dnamel.toUpperCase()+"',contactno='" + contactno + "',dadd='" + dadd + "',isactive='"+isactive+"',byuser='" + byuser + "' where objid="+objid;
				System.out.println("updateDoctor===" + strUpdate);
				no=st.executeUpdate(strUpdate);
			}catch(Exception e)
			{
			  e.printStackTrace();
			}
		}
	  return no;
   }
    /*public static void main(String ars[]) throws Exception{
        HashMap user=new HashMap();
        user.put("userId","bg");
        user.put("passWrd","bg");
        user.put("role","1");
        user.put("empId","1002");

        AddUser au=new AddUser();
        au.Connect();
        if(au.createUser(user)){
            System.out.println("user added sucessfully");
        }else{
            System.out.println(au.getMessage());
        }
    }*/

}
