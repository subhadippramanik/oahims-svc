package com.oa.kh.master;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class AddUser {
    Connection con = null;
    String error;
    String msg;

    public AddUser() {
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


    public int checkUserId(String login){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM user_mst where login='"+login+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("Here no===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

	public ResultSet listUserbyId(String login){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(login != null ){
				 rs=st.executeQuery("select * FROM user_mst where login='"+login+"'");
			 	 }else{
				 rs=st.executeQuery("select * FROM user_mst");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

	public int deleteUser(String objid){
		int no = 0;
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("delete  FROM user_mst where objid="+objid);
				 }else{
				 rs=st.executeQuery("select * FROM user_mst");
				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}


    public void addUser(String login,String pswd,String access_type) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into user_mst(login,pswd,access_type) values("
								+ "'" + login + "',"
								+ "'" + pswd + "',"
								+ "'" + access_type + "')";

				System.out.println("addUser===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
	}

	public int updateUser(String objid,String login,String pswd,String access_type) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
				Statement st=con.createStatement();
				String strUpdate = "update user_mst set login='"+login+"',pswd='"+pswd+"' ,access_type='"+access_type + "' where objid="+objid;
				System.out.println("updateUser===" + strUpdate);
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
