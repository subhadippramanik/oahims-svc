package com.oa.kh.opd;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class DoctorLeave {
    Connection con = null;
    String error;
    String msg;

    public DoctorLeave() {
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

    public int checkDoctorLeaveId(String objid){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM doctor_leave where objid='"+objid+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkDoctorLeaveId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

	public ResultSet listDoctorLeaveById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM doctor_leave where objid='"+objid+"'");
			 	 }else{
				 rs=st.executeQuery("select * FROM doctor_leave");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public int deleteDoctorLeave(String objid){
		int no = 0;
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 	String strDelete = "Delete FROM doctor_leave where objid=" + objid;
					System.out.println("deleteDoctorLeave===" + strDelete);
				 	rs=st.executeQuery(strDelete);
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}

	public void addDoctorLeave(String doctorobjid,String leavefrom,String leaveto,String isactive,String byuser) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into doctor_leave(doctorobjid,leavefrom,leaveto,isactive,byuser) values("
								+ "'" + doctorobjid + "',"
								+ "'" + leavefrom + "',"
								+ "'" + leaveto + "',"
								+ "'" + isactive + "',"
								+ "'" + byuser + "')";

				System.out.println("addDoctorLeave===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

	public int updateDoctorLeave(String objid,String doctorobjid,String leavefrom,String leaveto,String isactive,String byuser) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate="update doctor_leave set doctorobjid='"+doctorobjid+"',leavefrom='"+leavefrom+"' ,leaveto='"+leaveto+"',isactive='"+isactive+"',byuser='" + byuser + "' where objid="+objid;
				System.out.println("updateDoctorLeave===" + strUpdate);
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
