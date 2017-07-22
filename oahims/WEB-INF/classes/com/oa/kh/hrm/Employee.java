package com.oa.kh.hrm;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class Employee {
    Connection con = null;
    String error;
    String msg;

    public Employee() {
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

    public int checkEmployeeId(String empcode){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM mst_emp where empcode='"+empcode+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkEmployeeId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

	public String getEmployeeCode(String objid)
		{
			String empcode="";
			if(con != null)
			{
				 try
				 {
					 Statement st=con.createStatement();
					 ResultSet rs = null;
					 rs=st.executeQuery("select empcode,emptitle,empnamef,empnamem,empnamel FROM mst_emp where objid="+objid);
					 while(rs.next()){
						 empcode = rs.getString("empcode");
						 System.out.println("getEmployeeCode ===" + empcode);
					 }
					 rs.close();
				 }catch(Exception e)
				 {
					  e.printStackTrace();
				 }
			}
			return  empcode;
	}

	public String getEmployeeName(String empcode)
	{
		String empName="";
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select emptitle,empnamef,empnamem,empnamel FROM mst_emp where empcode='"+empcode+"'");
				 while(rs.next()){
					 empName = rs.getString("empnamef") + " " + rs.getString("empnamem") + " " + rs.getString("empnamel");
					 System.out.println("getEmployeeName ===" + empName);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return  empName;
	}

	public int getEmployeeObjid(String empcode)
	{
		int objid = 0;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select objid FROM mst_emp where empcode='"+empcode+"'");
				 while(rs.next()){
					 objid = rs.getInt("objid");
					 System.out.println("getEmployeeObjid ===" + objid);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return  objid;
	}

	public ResultSet listEmployeeById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM mst_emp where objid="+objid);
			 	 }else{
				 rs=st.executeQuery("select * FROM mst_emp");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public int deleteEmployee(String objid){
		int no = 0;
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 	String strDelete = "delete from mst_emp where objid=" + objid;
					System.out.println("deleteEmployee===" + strDelete);
				 	rs=st.executeQuery(strDelete);
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}

	public void addEmployee(String empcode,String emptitle,String empnamef,String empnamem,String empnamel,
					String empsex,String empdob,String contactno,String empadd,String empphoto,String empdoj,
					String isactive,String byuser) throws SQLException
	{
		AppUtility appUtility = new AppUtility();

		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into mst_emp(empcode,emptitle,empnamef,empnamem,empnamel,empsex,empdob,contactno,empadd,empphoto,empdoj,isactive,byuser) values("
								+ "'" + empcode + "',"
								+ "'" + emptitle + "',"
								+ "'" + empnamef.toUpperCase() + "',"
								+ "'" + empnamem.toUpperCase() + "',"
								+ "'" + empnamel.toUpperCase() + "',"
								+ "'" + empsex + "',"
								+ "'" + empdob + "',"
								+ "'" + contactno + "',"
								+ "'" + empadd + "',"
								+ "'" + empphoto + "',"
								+ "'" + empdoj + "',"
								+ "'" + isactive + "',"
								+ "'" + byuser + "')";

				System.out.println("addEmployee===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

	public int updateEmployee(String objid,String empcode,String emptitle,String empnamef,String empnamem,String empnamel,
					String empsex,String empdob,String contactno,String empadd,String empphoto,String empdoj,
					String isactive,String byuser) throws SQLException
	{
		AppUtility appUtility = new AppUtility();
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate="update mst_emp set empcode='"+empcode+"',emptitle='"+emptitle+"',empnamef='"+empnamef.toUpperCase()+"' ,empnamem='"+empnamem.toUpperCase()+"' ,empnamel='"+empnamel.toUpperCase()+"',empsex='"+empsex+"',empdob='"+empdob+"',contactno='" + contactno + "',empadd='" + empadd + "',empphoto='"+empphoto+"',empdoj='"+empdoj+"',isactive='"+isactive+"',byuser='" + byuser + "' where objid="+objid;
				System.out.println("updateEmployee===" + strUpdate);
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
