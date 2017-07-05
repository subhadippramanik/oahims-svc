package com.oa.kh.ipd;

import javax.sql.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.lang.*;

import com.oa.kh.utility.*;


public class IpdRegistration {
    Connection con = null;
    String error;
    String msg;

    public IpdRegistration() {
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

    public int checkIpdRegistrationId(String mrno){
        int no=0;
        if(con != null)
        {
             try
             {
                 Statement st=con.createStatement();
                 ResultSet rs = null;
                 rs=st.executeQuery("select count(*) as mCnt FROM mst_ipd_patient where mrno='"+mrno+"'");
                 while(rs.next()){
                     no = rs.getInt("mCnt");
                     System.out.println("checkIpdRegistrationId ===" + no);
                 }
                 rs.close();
             }catch(Exception e)
             {
                  e.printStackTrace();
             }
        }
        return no;
    }

    public int IpdCountByDoctorId(String docobjid,String asondate){
		int no=0;
		if(con != null)
		{
			 try
			 {
				 String strDoctor="";
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 if(asondate!=null){
					strDoctor="select count(*) as mCnt FROM mst_ipd_patient where objid in (select ipd_objid from mst_ipd_patient_doctors where doc_objid="+docobjid+") and indate='" + asondate + "'";

			 	 }else{
					strDoctor="select count(*) as mCnt FROM mst_ipd_patient where objid in (select ipd_objid from mst_ipd_patient_doctors where doc_objid="+docobjid+")";

			 	 }
				 System.out.println("IpdCountByDoctorId ===" + strDoctor);
				 rs=st.executeQuery(strDoctor);
				 while(rs.next()){
					 no = rs.getInt("mCnt");
					 System.out.println("IpdCountByDoctorId ===" + no);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
    }

    public String GetIpdRegistrationObjId(String mrno){
		String objid="";
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 ResultSet rs = null;
				 rs=st.executeQuery("select objid FROM mst_ipd_patient where mrno ='"+mrno+"'");
				 while(rs.next()){
					 objid = rs.getString("objid");
					 System.out.println("GetIpdRegistrationObjId ===" + objid);
				 }
				 rs.close();
			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return objid;
	}


	public ResultSet listIpdRegistrationById(String objid){
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
				 rs=st.executeQuery("select * FROM mst_ipd_patient where objid="+objid);
			 	 }else{
				 rs=st.executeQuery("select * FROM mst_ipd_patient");
			 	 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return rs;
    }

    public ResultSet listIpdRegistration(String strSel){
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


	public int deleteIpdRegistration(String objid){
		int no = 0;
		ResultSet rs = null;
		if(con != null)
		{
			 try
			 {
				 Statement st=con.createStatement();
				 if(objid != null ){
					String strDelete = "Delete FROM mst_ipd_patient where objid=" + objid;
					System.out.println("deleteIpdRegistration===" + strDelete);
				 	no=st.executeUpdate(strDelete);

				 }

			 }catch(Exception e)
			 {
				  e.printStackTrace();
			 }
		}
		return no;
	}

	public void addIpdRegistration(String mrno,String indate,String visitno,String empobjid,String oldnew,
									String patientname,String fmsh_guardians,String patientphoto,String patageyrs,
									String patagemts,String patageday,String patsex,String patmarriedyn,String birthplace,
									String proffession,String medicalpolyn,String height,String bloodgroup,String allergies,
									String isactive,String byuser,String createddate,String updateddatetime) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
			try
			{
				Statement st=con.createStatement();
				String strInsert="insert into mst_ipd_patient(mrno,indate,visitno,empobjid,oldnew,patientname,fmsh_guardians,"
				+ "patientphoto,patageyrs,patagemts,patageday,patsex,patmarriedyn,birthplace,proffession,medicalpolyn,"
				+ "height,bloodgroup,allergies,isactive,byuser,createddate,updateddatetime) values("
						+ "'" + mrno + "',"
						+ "'" + indate + "',"
						+ "'" + visitno + "',"
						+ "" + empobjid + ","
						+ "'" + oldnew + "',"
						+ "'" + patientname + "',"
						+ "'" + fmsh_guardians + "',"
						+ "'" + patientphoto + "',"
						+ "" + patageyrs + ","
						+ "" + patagemts + ","
						+ "" + patageday + ","
						+ "'" + patsex + "',"
						+ "'" + patmarriedyn + "',"
						+ "'" + birthplace + "',"
						+ "'" + proffession + "',"
						+ "'" + medicalpolyn + "',"
						+ "'" + height + "',"
						+ "'" + bloodgroup + "',"
						+ "'" + allergies + "',"
						+ "'" + isactive + "',"
						+ "'" + byuser + "',"
						+ "'" + createddate + "',"
						+ "'" + updateddatetime + "')";

				System.out.println("addIpdRegistration===" + strInsert);
				no=st.executeUpdate(strInsert);

			}catch(Exception e){
			  e.printStackTrace();
			}
		}
    }

    public int updateIpdRegistration(String objid,String mrno,String indate,String visitno,String empobjid,String oldnew,
									String patientname,String fmsh_guardians,String patientphoto,String patageyrs,
									String patagemts,String patageday,String patsex,String patmarriedyn,String birthplace,
									String proffession,String medicalpolyn,String height,String bloodgroup,String allergies,
									String isactive,String byuser,String createddate,String updateddatetime) throws SQLException
	{
		int no=0;
		if(con!=null)
		 {
		   try{
			   	Statement st=con.createStatement();
			   	String strUpdate="update mst_ipd_patient set "
										+ "mrno='" + mrno + "',"
										+ "indate='" + indate + "',"
										+ "visitno='" + visitno + "',"
										+ "empobjid=" + empobjid + ","
										+ "oldnew='" + oldnew + "',"
										+ "patientname='" + patientname + "',"
										+ "fmsh_guardians='" + fmsh_guardians + "',"
										+ "patientphoto='" + patientphoto + "',"
										+ "patageyrs=" + patageyrs + ","
										+ "patagemts=" + patagemts + ","
										+ "patageday=" + patageday + ","
										+ "patsex='" + patsex + "',"
										+ "patmarriedyn='" + patmarriedyn + "',"
										+ "birthplace='" + birthplace + "',"
										+ "proffession='" + proffession + "',"
										+ "medicalpolyn='" + medicalpolyn + "',"
										+ "height='" + height + "',"
										+ "bloodgroup='" + bloodgroup + "',"
										+ "allergies='" + allergies + "',"
										+ "isactive='" + isactive + "',"
										+ "byuser='" + byuser + "',"
										+ "updateddatetime='" + updateddatetime + "' "
			   							+ "where objid="+objid;

				System.out.println("updateIpdRegistration===" + strUpdate);
			   	no=st.executeUpdate(strUpdate);
			}catch(Exception e)
			{
			  e.printStackTrace();
			}
		}
	  return no;
   }


}

