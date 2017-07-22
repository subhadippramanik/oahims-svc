<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.util.*"%>

<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="employee" class="com.oa.kh.opd.Employee"/>
<jsp:useBean id="opdregistration" class="com.oa.kh.opd.OpdRegistration"/>
<jsp:useBean id="doctor" class="com.oa.kh.opd.Doctor"/>
<jsp:useBean id="employeerelation" class="com.oa.kh.opd.EmployeeRelationship"/>

<%@ page import="com.oa.kh.utility.*" %>
<jsp:useBean id="apputility" class="com.oa.kh.utility.AppUtility"/>

<html>
<head>
<title>Print Patient No <%if(request.getParameter("code")!=null){ %>: <%=request.getParameter("code")%><%}%> </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
</head>
<body topmargin="10px">
	<table width="100%" border="0" cellpadding="2" cellspacing="3" align="center">
      <tr>
      	<td colspan="5">
        	<table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="Font8vB" align="center" style="HEIGHT:30px">        	
					<!--:: PATIENT  REGISTRATION ::<br>
					==================== -->&nbsp;
        		</td>
              </tr>
            </table>
          </td>
      </tr>
	  <tr>
		<td colspan="4" style="height:10px"></td>
	  </tr>	 	
	  <%
	  String empobjid="",empcode="",ptObjid="",ptNm="",ptAge="",freestaff="",docobjid="",doccode="",docNm="",regno="",ptON="",ptSex="",totRs="";
	  int dSlNo=0,totNo=0;
	  if(request.getParameter("code")!=null){
	  	ptObjid = request.getParameter("code");
		//System.out.println("ptObjid====="+ptObjid);
		opdregistration.Connect();
		
		//UPDATE PRINT STATUS IN OPD FORM
		opdregistration.updatePrintStatus(ptObjid);
		
		try{
			ResultSet rsPrint = opdregistration.listOpdRegistrationById(ptObjid);
			while(rsPrint.next()){
	  			ptNm = rsPrint.getString("patientname");
				ptAge = rsPrint.getInt("patageyrs") + " YR " + rsPrint.getInt("patagemts") + " MT " + rsPrint.getInt("patageday") + " DY";
	  			regno = rsPrint.getString("regnno");
				ptON = rsPrint.getString("oldnew");
				ptSex = rsPrint.getString("patsex");			
				docobjid = rsPrint.getString("doctorobjid");
				freestaff = rsPrint.getString("stafffree");			
				
				//Others
				if(freestaff.equals("S") || freestaff.equals("F")){
					totRs = "STAFF";
					if(freestaff.equals("S")){
						empobjid = rsPrint.getString("empobjid");
						employee.Connect();
						empcode = employee.getEmployeeCode(empobjid);
						totRs += "/" + empcode;
						employee.DisConnect();
					}
				}else{
	  				totRs = rsPrint.getString("billamnt") + "/=";
				}
				
				//Doctor Related ===================================================
				doctor.Connect();
				doccode = doctor.getDoctorCode(docobjid);
				docNm = doctor.getDoctorName(doccode);
				doctor.DisConnect();
	  		}
			rsPrint.close();
	  	}catch(Exception e){}
	  	opdregistration.DisConnect();
		
		//COUNT RELATED ====================================================
		opdregistration.Connect();
		String sysDt = apputility.GetSystemDateToDisplay();
		dSlNo = opdregistration.OpdCountByDoctorId(docobjid,sysDt);
		totNo = opdregistration.OpdCountByDoctorId(docobjid,null);
		opdregistration.DisConnect();
	  %>
	  <tr>
		<td class="Font8vB" width="20%">Patient Name :</td>
		<td class="Font8v" width="30%"><%=ptNm%></td>
		<td colspan="2"><font class="Font8vB">Age : </font>&nbsp;<font class="Font8v"><%=ptAge%></font></td>
	  </tr>
	  <tr>
		<td class="Font8vB">Name of Doctor :</td>
		<td class="Font8v"><%=docNm%></td>
		<td class="Font8vB">OPD Registration No. :</td>
		<td class="Font8v" width="25%"><%=regno%></td>
	  </tr>
	  <tr>
		<td class="Font8vB">Daily Serial No :</td>
		<td class="Font8v"><%=dSlNo%></td>
		<td><font class="Font8vB">New/Old : </font>&nbsp;<font class="Font8v"><%=ptON%></font></td>
		<td><font class="Font8vB">Sex : </font>&nbsp;<font class="Font8v"><%=ptSex%></font></td>
	  </tr>
	  <tr>
		<td class="Font8vB">Total No :</td>
		<td class="Font8v"><%=totNo%></td>
		<td><font class="Font8vB">Rupees : </font>&nbsp;<font class="Font8v"><%=totRs%></font></td>
		<td class="Font8v">&nbsp;</td>
	  </tr>	   
	</table>	
	<%}%>
</body>
</HTML>




