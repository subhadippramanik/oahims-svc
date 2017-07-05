package com.oa.kh.opd;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class OpdRegistration {
    Connection con = null;
    String error;
    String msg;

    public OpdRegistration() {
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

    public int checkOpdRegistrationId(String regnno){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM mst_opd_registration where regnno='"+regnno+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkOpdRegistrationId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

    public int OpdCountByDoctorId(String docobjid,String asondate){
		int no=0;
		if(con != null)
		{
			 try
			 {
				 String strDoctor="";
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 if(asondate!=null){
					strDoctor="select count(*) as mCnt FROM mst_opd_registration where doctorobjid="+docobjid+" and createddate='" + asondate + "'";

			 	 }else{
					strDoctor="select count(*) as mCnt FROM mst_opd_registration where doctorobjid="+docobjid;

			 	 }
				 System.out.println("OpdCountByDoctorId ===" + strDoctor);
				 rs=st.executeQuery(strDoctor);
				 while(rs.next()){
					 no = rs.getInt("mCnt");
					 System.out.println("OpdCountByDoctorId ===" + no);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
    }

    public String GetOpdRegistrationObjId(String regnno){
		String objid="";
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select objid FROM mst_opd_registration where regnno='"+regnno+"'");
				 while(rs.next()){
					 objid = rs.getString("objid");
					 System.out.println("GetOpdRegistrationObjId ===" + objid);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return objid;
	}


	public ResultSet listOpdRegistrationById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM mst_opd_registration where objid="+objid);
			 	 }else{
				 rs=st.executeQuery("select * FROM mst_opd_registration");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

    public ResultSet listOpdRegistration(String strSel){
			ResultSet rs = null;
			if(con != null)
			{
				 try
				 {
					 Statement st=con.createStatement();

					 rs=st.executeQuery(strSel);

				 }catch(Exception e)
				 {
					  e.printStackTrace();
				 }
			}
			return rs;
    }


	public int deleteOpdRegistration(String objid){
		int no = 0;
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
					String strDelete = "Delete FROM mst_opd_registration where objid=" + objid;
					System.out.println("deleteOpdRegistration===" + strDelete);
				 	no=st.executeUpdate(strDelete);

				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}

	public void addOpdRegistration(String billamnt,String regnno,String stafffree,String empobjid,String oldnew,
									String patientname,String patientphoto,String patstate,String patdistrict,
									String patps,String patageyrs,String patagemts,String patageday,String patsex,
									String doctorobjid,String isactive,String byuser,String createddate,String updateddatetime) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into mst_opd_registration(billamnt,regnno,stafffree,empobjid,oldnew,patientname,patientphoto,patstate,patdistrict,"
				+ "patps,patageyrs,patagemts,patageday,patsex,doctorobjid,isactive,byuser,createddate,updateddatetime) values("
						+ "" + billamnt + ","
						+ "'" + regnno + "',"
						+ "'" + stafffree + "',"
						+ "" + empobjid + ","
						+ "'" + oldnew + "',"
						+ "'" + patientname + "',"
						+ "'" + patientphoto + "',"
						+ "'" + patstate + "',"
						+ "'" + patdistrict + "',"
						+ "'" + patps + "',"
						+ "" + patageyrs + ","
						+ "" + patagemts + ","
						+ "" + patageday + ","
						+ "'" + patsex + "',"
						+ "" + doctorobjid + ","
						+ "'" + isactive + "',"
						+ "'" + byuser + "',"
						+ "'" + createddate + "',"
						+ "'" + updateddatetime + "')";

				System.out.println("addOpdRegistration===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

    public int CreateSeqNo() throws SQLException
    {
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();

				no=st.executeUpdate("insert into seq_no(id) values(1)");

				ResultSet rs=st.executeQuery("select max(seqno) as mNoMax FROM seq_no");

				while(rs.next()){

					no = rs.getInt("mNoMax");
				}

			}catch(Exception e){
			  e.printStackTrace();
			}
		}

		return no;

	}

	public int updatePrintStatus(String objid) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strUpdate = "update mst_opd_registration set printstatus='Y' where objid="+objid;
				System.out.println("updatePrintStatus===" + strUpdate);
				no=st.executeUpdate(strUpdate);
			}catch(Exception e){
			  e.printStackTrace();
			}
		}
		return no;
	}

	public String getPrintStatus(String objid) throws SQLException
	{
		String no="";
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				ResultSet rs = null;
				String strSelect = "select printstatus from mst_opd_registration where objid="+objid;
				System.out.println("getPrintStatus====" + strSelect);
				rs=st.executeQuery(strSelect);
				while(rs.next()){
					no = rs.getString("printstatus");
					System.out.println("getPrintStatus ===" + no);
				}
				rs.close();
			}catch(Exception e){
			  e.printStackTrace();
			}
		}
		return no;
	}


	public int updateOpdRegistration(String billamnt,String objid,String regnno,String stafffree,String empobjid,String oldnew,
									String patientname,String patientphoto,String patstate,String patdistrict,
									String patps,String patageyrs,String patagemts,String patageday,String patsex,
									String doctorobjid,String isactive,String byuser,String createddate,String updateddatetime) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate="update mst_opd_registration set billamnt="
			   	+ billamnt+",regnno='"+regnno+"',stafffree='"+stafffree+"',empobjid="
			   	+ empobjid+",oldnew='"+oldnew+"',patientname='"+patientname+"',patientphoto='"
			   	+ patientphoto+"',patstate='"+patstate+"',patdistrict='"
			   	+ patdistrict+"',patps='"+patps+"',patageyrs="+patageyrs+",patagemts="
			   	+ patagemts+",patageday="+patageday+",patsex='"+patsex+"',doctorobjid="
			   	+ doctorobjid+",isactive='"+isactive+"',"
			   	+ "byuser='" + byuser + "',"
				+ "createddate='" + createddate + "',"
				+ "updateddatetime='" + updateddatetime + "' "
			   	+ "where objid="+objid;

				System.out.println("updateOpdRegistration===" + strUpdate);
			   	no=st.executeUpdate(strUpdate);
			}catch(Exception e)
			{
			  e.printStackTrace();
			}
		}
	  return no;
   }

   public int updateOpdRegistrationPatientVisit(String objid,String doctorobjid,String dscheduleday,String dscheduletimefrom,String dscheduletimeto,String isactive,String byuser) throws SQLException
   	{
   		int no=0;
   		if(con!=null)
   		 {
   		   try{
   			   	Statement st=con.createStatement();
   			   	String strUpdate="update pat_opd_visit set doctorobjid='"+doctorobjid+"',dscheduleday='"+dscheduleday+"',dscheduletimefrom='"+dscheduletimefrom+"' ,dscheduletimeto='"+dscheduletimeto+"',isactive='"+isactive+"',byuser='" + byuser + "' where objid="+objid;
   				System.out.println("updateDoctorSchedule===" + strUpdate);
   			   	no=st.executeUpdate(strUpdate);
   			}catch(Exception e)
   			{
   			  e.printStackTrace();
   			}
   		}
   	  return no;
   }

}

