<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="docschlve" class="com.oa.kh.opd.DoctorScheduleAndLeave"/>
<jsp:useBean id="opdregistration" class="com.oa.kh.opd.OpdRegistration"/>
<jsp:useBean id="doctor" class="com.oa.kh.opd.Doctor"/>

<%@ page import="com.oa.kh.utility.*" %>
<jsp:useBean id="appUtility" class="com.oa.kh.utility.AppUtility"/>

<%//SECURITY CHECKING AREA START *********************************%>
<%@ page import="com.oa.kh.common.*" %>
<jsp:useBean id="checkSecurity" class="com.oa.kh.common.Login"/>
<%
String UserNM = null, UserRole  = null;
if(session.getAttribute("userName")!=null){
	UserNM = (String)session.getAttribute("userName");
	UserRole = (String)session.getAttribute("userRole");
	if(checkSecurity.CheckSecurity(UserNM,UserRole)==0){
		response.sendRedirect("index.htm?msg=1");
	}
}else{
	response.sendRedirect("index.htm?msg=1");
}
%>
<%//SECURITY CHECKING AREA END ***********************************%>

<%
String objid="";

if(request.getParameter("id")!=null){
    /*   Unit Details */
    objid=request.getParameter("id");
    /*   Save Action For Unit   */
    opdregistration.Connect();    
   	int no=0;
   	no=opdregistration.deleteOpdRegistration(objid);
   	if(no!=0){
	   	%><center><h2>Information Deleted Successfully</h2></center><%
 	}else{
	 	%><center><h2>Unable to Delete. Because there is no data with <%=objid%> </h2></center><% 
	}      
   opdregistration.DisConnect();
}

String curmonth="",curyear="",doctorobjid="";
String strQry="",strQry_FS="";
ResultSet rsOPD = null;
ResultSet rsOPD_FS = null;
if(request.getParameter("Show")!=null){
	doctorobjid = request.getParameter("DoctorList");
	curmonth = request.getParameter("selMonth");
	curyear = request.getParameter("selYear");
	
	out.println("strQry==" + doctorobjid + "==curmonth==" + curmonth + "==curyear==" + curyear);
	
	
	
}
if(request.getParameter("Submit")!=null){
	doctorobjid = request.getParameter("DoctorList");
	curmonth = request.getParameter("selMonth");
	curyear = request.getParameter("selYear");
	/*
	String musrnm=(String)session.getAttribute("userName");
	if(UserRole.equals("2")){
		strQry += " and byuser='" + musrnm  + "'";
		strQry_FS += " and byuser='" + musrnm  + "'";
	}*/
	
	String [] chksch = new String[100];
	String [] chklve = new String[100];
	String [] chkattnd = new String[100];
	chksch=request.getParameterValues("chkSchedule");
	chklve=request.getParameterValues("chkLeave");
	chkattnd=request.getParameterValues("chkAttend");
	if(chksch != null){
		out.println("strQry=========================" + chksch);
	}
	if(chklve != null){
		out.println("strQry=========================" + chklve.length);
	}
	if(chkattnd != null){
		out.println("strQry=========================" + chkattnd.length);
	}
	//out.println(UserRole + "strQry_FS=========================" + strQry_FS);
}
%>    
<html>
<head>
<title>Grade List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="../common/basiccalendar.js"></SCRIPT>
<script language="javascript">
	function ChekForm(){
		var doctor = document.frmDoctorSchedule.DoctorList.value;
		if(doctor == "-1"){
			alert("Please select doctor to continue");
			document.frmDoctorSchedule.DoctorList.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body topmargin="10px">
<form name="frmDoctorSchedule" method="post" action="AddDoctorScheduleLeave.jsp" onSubmit="return ChekForm();">
	<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">  	
		<tr>
			<td>
				<table width="100%">										
					<tr>
						<td class="Font8vB" align="center" style="HEIGHT:30px"> 
							<table width="100%" border="0" cellspacing="3" cellpadding="1" style="border: 1px solid #6699FF;">
							  <tr>
									<td colspan="4" class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
									:: DCOTOR SCHEDULE ::
									</td>
							  	</tr>	
								<tr>
									<td colspan="4" style="height:5px"></td>
								</tr>
								<tr>
									<td colspan="2">
										<table border="0" cellspacing="3" cellpadding="1" width="100%">							  	
											<tr>
												<td class="grdback" colspan="2">Select Doctor :</td>
												<td colspan="2">
													<select class="mandtxtbox" name="DoctorList">
														<option value="-1">-- Select Doctor --</option>
														<%
														String docname="",docobjid="";
														doctor.Connect();
														try{
															ResultSet docRS  = doctor.listDoctorById(null);
															while(docRS.next()){
																docobjid = docRS.getString("objid");
																docname = docRS.getString("dnamef") + " " + docRS.getString("dnamem") + " " + docRS.getString("dnamel");
																if(doctorobjid.equals(docobjid)){
																%>
																<option value="<%=docobjid%>" selected><%=docname%></option>
																<%}else{%>
																<option value="<%=docobjid%>"><%=docname%></option>
																<%}
															}									
															docRS.close();
															
														}catch(Exception e){}
														
														doctor.DisConnect();									
														%>
													</select>
												</td>
												<td><input name="Show" type="Submit" value="Show" class="mandtxtbox"></td>
											</tr>
											<tr>
												<td colspan="4" style="height:10px"></td>
											</tr>
											<tr>
												<td class="grdback">Month :</td>
												<td class="Font8v">
													<select name="selMonth" onChange="updatecalendar(this.options,document.frmDoctorSchedule.selYear.options)" class="mandtxtbox">
													<script type="text/javascript">
														var themonths=['January','February','March','April','May','June',
														'July','August','September','October','November','December']
														
														var todaydate=new Date()
														var curmonth=todaydate.getMonth()+1 //get current month (1-12)
														var curyear=todaydate.getFullYear() //get current year
														
														function updatecalendar(theselectionM,theselectionY){
															var themonth=parseInt(theselectionM[theselectionM.selectedIndex].value)+1
															var curyear=parseInt(theselectionY[theselectionY.selectedIndex].value)
															alert("themonth==="+themonth + "==="+curyear);
															
															var calendarstr=buildCal(themonth, curyear, "main", "month", "daysofweek", "days", 0)
															if (document.getElementById)
															document.getElementById("calendarspace").innerHTML=calendarstr
														}
														
														
														for (i=0; i<12; i++){ //display option for 12 months of the year
															if(curmonth-1==i){
																document.write('<option value="'+i+'" selected="yes">'+themonths[i]+'</option>')
															}else{
																document.write('<option value="'+i+'">'+themonths[i]+'</option>');
															}
														}
													</script>
													</select>
												</td>
												<td class="grdback">Year :</td>
												<td class="Font8v">
													<select name="selYear" onChange="updatecalendar(document.frmDoctorSchedule.selMonth.options,this.options)" class="mandtxtbox">
													<script type="text/javascript">											
														for (i=0; i<12; i++) {//display option for 12 months of the year
															if(curyear-1==i){
																document.write('<option value="'+(curyear)+'" selected="yes">'+(curyear)+'</option>');
															}else{
																document.write('<option value="'+(curyear+i)+'">'+(curyear+i)+'</option>');
															}
														}
													</script>
													</select>
												</td>
												<td class="grdback">Select Type :</td>
												<td class="Font8v">
													<select name="selType" id="selType" class="mandtxtbox">
														<option value="OPD">OPD</option>
														<option value="SPE">Speciality</option>
													</select>
												</td>
											</tr>
										</table>
									</td>									
									<td width="50%">
										<table width="70%" border="0" cellspacing="1" cellpadding="1">
										  <tr>
											<td bgcolor="#66FF99" width="10px" style="height:10px"></td>
											<td class="Font8v">Schedule</td>
										  </tr>
										  <tr>
											<td bgcolor="#FFCACA" style="height:10px"></td>
											<td class="Font8v">Leave</td>
										  </tr>
										  <tr>
											<td bgcolor="#9999FF" style="height:10px"></td>
											<td class="Font8v">Schedule Attended by Doctor</td>
										  </tr>
										</table>
									</td>								
							  	</tr>								
								<tr>
									<td colspan="4" style="height:5px"></td>
								</tr>
                                <tr>
                                	<td colspan="4">
                                    	<div id="calendarspace">
											<script>
                                            //write out current month's calendar to start
                                            document.write(buildCal(curmonth, curyear, "main", "month", "daysofweek", "weekdays", 0))
                                            </script>
                                        </div>
                                    </td>
                                </tr>
								<tr>
									<td colspan="4" align="center">
										<input type="Submit" name="Submit" value="Submit" class="mandtxtbox">
										&nbsp;&nbsp;&nbsp;
										<input type="button" name="Cancel" value="Cancel" class="mandtxtbox" onClick="JavaScript:alert('ok');location.href='./AddDoctorScheduleLeave.jsp';">
									</td>
								</tr>
								<tr>
									<td colspan="4" style="height:5px"> </td>
								</tr>													
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>	
</body>
</html>


