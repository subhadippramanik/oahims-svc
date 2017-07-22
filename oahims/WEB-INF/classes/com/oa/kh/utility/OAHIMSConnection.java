/*
 * Created on Jul 4, 2006
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package com.oa.kh.utility;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;

/**
 * @author Administrator
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class OAHIMSConnection {
	String connectionURL = "jdbc:mysql://localhost:3306/oa_hims_demo";
	Connection con=null;

	public OAHIMSConnection() {}

	public static void main(String args[]){
			OAHIMSConnection login = new OAHIMSConnection();
			System.out.println("OK PRM 1");
			login.Connect();
			System.out.println("OK PRM 2");
	}

	public Connection Connect()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection(connectionURL, "root", "Admin");
		}catch(Exception e)
		{
			System.out.println(e);
		}
		return con;
	}

	public void DisConnect()
	{
		try
		{
			if(con!=null)
			{
				con.close();
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}