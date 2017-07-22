package com.oa.kh.hrm;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class EmployeeRelationship {
    Connection con = null;
    String error;
    String msg;

    public EmployeeRelationship() {
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

    public int checkEmployeeRelationshipId(String empobjid){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 System.out.println("select count(*) as mCnt FROM emp_relationship where empobjid="+empobjid);
                 rs=st.executeQuery("select count(*) as mCnt FROM emp_relationship where empobjid="+empobjid);
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkEmployeeRelationshipId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

	public ResultSet listEmployeeRelationshipById(String empobjid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(empobjid != null ){
				 rs=st.executeQuery("select * FROM emp_relationship where empobjid="+empobjid);
			 	 }else{
				 rs=st.executeQuery("select * FROM emp_relationship");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public ResultSet listDistinctEmployeeRelationshipById(){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 System.out.println("select distinct empobjid FROM emp_relationship");
                 rs=st.executeQuery("select distinct empobjid FROM emp_relationship");

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
	}


	public int deleteEmployeeRelationship(String empobjid){
		int no = 0;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(empobjid != null ){
				 	String strDelete = "Delete FROM emp_relationship where empobjid=" + empobjid;
					System.out.println("deleteEmployeeRelationship===" + strDelete);
				 	no=st.executeUpdate(strDelete);
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}


	public void addEmployeeRelationship(String strInsertData) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into emp_relationship(empobjid,emprelationship,emprelname,empreldob,emprelsex,emprelphoto,isactive,byuser) values("
								+ strInsertData + ")";

				System.out.println("addEmployeeRelationship===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

	public int updateEmployeeRelationship(String strInsertData,String empobjid) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
				System.out.println("updateEmployeeRelationship===" + empobjid + "===" + strInsertData);
				addEmployeeRelationship(strInsertData);

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
