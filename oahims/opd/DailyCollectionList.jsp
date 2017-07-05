<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="employee" class="com.oa.kh.opd.Employee"/>
<jsp:useBean id="adduser" class="com.oa.kh.common.AddUser"/>

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

String fromdt="",todt="",opdtype="A",doctorobjid="",getuserobjid="";
String strQry="",strQry_FS="";
ResultSet rsOPD = null;
ResultSet rsOPD_FS = null;
if(request.getParameter("Submit")!=null){
	fromdt = request.getParameter("fromDT");
	todt = request.getParameter("toDT");
	opdtype = request.getParameter("OPDType");
	doctorobjid = request.getParameter("DoctorList");
	getuserobjid = request.getParameter("UserList");
	
	strQry="select * from mst_opd_registration where createddate between '" + fromdt + "' and '" + todt + "'" ;
	if(!doctorobjid.equals("-1")){
		strQry += " and doctorobjid=" + doctorobjid;
	}
	
	if(opdtype.equals("A")){
		strQry_FS = strQry + " and stafffree in('S','F')" ;
		strQry += " and stafffree not in('S','F')" ;		
	}else if(opdtype.equals("B")){
		strQry += " and stafffree not in('S','F')" ;
	}else{
		strQry_FS = strQry + " and stafffree in('S','F')" ;
	}
	
	if(!getuserobjid.equals("-1")){
		strQry += " and byuser='" + getuserobjid +"'";
		strQry_FS += " and byuser='" + getuserobjid +"'";
	}
	//out.println(UserRole + "strQry=========================" + strQry);
	//out.println(UserRole + "strQry_FS=========================" + strQry_FS);
}
%>    
<html>
<head>
<title>Grade List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript src="../common/date_picker.js"></SCRIPT>

</head>
<body topmargin="10px">
<form name="frmOPDRegList" method="post" action="DailyCollectionList.jsp">
	<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">  	
		<tr>
			<td>
				<table width="100%">										
					<tr>
						<td class="Font8vB" align="center" style="HEIGHT:30px"> 
							<table width="100%" border="0" cellspacing="1" cellpadding="1" style="border: 1px solid #6699FF;">
							  <tr>
								<td colspan="6" class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
									:: OPD REGISTRATION REPORT ::
								</td>
							  </tr>
							  <tr>
								<td class="grdback">From Date :</td>
								<td>
									<input class="mandtxtbox" type="text" name="fromDT" id="fromDT" maxlength="12" size="12" value="<%if(fromdt.length() == 0){%><%=appUtility.ChangeDateFormatToMySQL(fromdt)%><%}else{%><%=fromdt%><%}%>" onFocus="blur();"/>
                                	<A href="javascript:show_calendar('frmOPDRegList.fromDT')" onMouseOut="window.status='';return true;" onMouseOver="window.status='Date Picker';return true;">
									<img src="../images/SHOWCAL.GIF" width="18" height="18" border="0"></a>
								</td>
								<td>&nbsp;</td>
								<td class="grdback">To Date :</td>
								<td>
									<input class="mandtxtbox" type="text" name="toDT" id="toDT" maxlength="12" size="12" value="<%if(todt.length() == 0){%><%=appUtility.ChangeDateFormatToMySQL(todt)%><%}else{%><%=todt%><%}%>" onFocus="blur();"/>
                                	<A href="javascript:show_calendar('frmOPDRegList.toDT')" onMouseOut="window.status='';return true;" onMouseOver="window.status='Date Picker';return true;">
									<img src="../images/SHOWCAL.GIF" width="18" height="18" border="0"></a>
								</td>
								<td>&nbsp;</td>								
							  </tr>
							  <tr>
								<td class="grdback">OPD Type :</td>
								<td>
									<select class="mandtxtbox" name="OPDType">
										<%if(opdtype.equals("F")){%>
										<option value="A" >-- All --</option>
										<option value="B">Bill</option>
										<option value="F" selected>Staff/Free</option>
										<%}else if(opdtype.equals("B")){%>
										<option value="A" >-- All --</option>
										<option value="B" selected>Bill</option>
										<option value="F">Staff/Free</option>
										<%}else{%>
										<option value="A" selected>-- All --</option>
										<option value="B">Bill</option>
										<option value="F">Staff/Free</option>
										<%}%>
									</select>
								</td>
								<td>&nbsp;</td>
								<td class="grdback">Select Doctor :</td>
								<td>
									<select class="mandtxtbox" name="DoctorList">
										<option value="-1">-- All --</option>
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
								<td>&nbsp;</td>
							  </tr>
							   <tr>
								<td class="grdback">Select User :</td>
								<td>
									<select class="mandtxtbox" name="UserList">
										<option value="-1">-- All --</option>
									<%
									String userName1="",userobjid1="";
									adduser.Connect();
									try{
										ResultSet userRS  = adduser.listUserbyId(null);
										while(userRS.next()){
											userobjid1 = userRS.getString("objid");
											userName1 = userRS.getString("login");
											if(getuserobjid.equals(userName1)){
											%>
											<option value="<%=userName1%>" selected><%=userName1%></option>
											<%}else{%>
											<option value="<%=userName1%>"><%=userName1%></option>
											<%}
										}									
										userRS.close();
										
									}catch(Exception e){}
									
									adduser.DisConnect();									
									%>
									</select>
								</td>
								<td><input class="mandtxtbox" type="Submit" name="Submit" value="Submit"></td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>								
							  </tr>
							  <tr>
								<td colspan="6" style="HEIGHT:10px"></td>
							  </tr>
							</table>							
                        </td>
					</tr>
					
					<tr>					
						<td valign="top"> 
							<table class="input" border="0" cellpadding="2"width="100%">
							  <tr class="lblhdr"> 
								<td align="center" colspan="2"> 
									Action
								</td>			
								<td align="center"> 
									Reg. No.
								</td>						  
								<td align="center">
									Patient Name
								</td>
								<td align="center">
									Doctor Name
								</td>
								<td align="center">
									Sex
								</td>
								<td align="center">
									Old<br>/New
								</td>
								<td align="center">
									Staff<br>/Free
								</td>
                                <td align="center">
									Emp Name
								</td>
								<td align="center">
									Printed?
								</td>
								<td align="center">
									Amount
								</td>								
							</tr>
								  <%
								  int i = 1,ptCnt = 0,i1=0,i2=0;
								  int mtot=0;
								  try{								  
									opdregistration.Connect();
									if(opdtype.equals("A") || opdtype.equals("B")){
										rsOPD = opdregistration.listOpdRegistration(strQry);	
										while(rsOPD.next()){																										
											if(i%2==0){%>
											<TR onMouseOver="this.className='selected'" onMouseOut="this.className='treven'" class="treven">
											<%}else{%>
											<TR onMouseOver="this.className='selected'" onMouseOut="this.className='trodd'" class="trodd">
											<%}%>
												<%if(UserRole.equals("2")){%>
												<td align="left" colspan="2"> 
													<a href="OpdRegistration.jsp?id=<%=rsOPD.getInt("objid")%>"><img src="../images/icoEdit.gif" border="0"></a>
												</td>
												<%}else{%>														
												<td align="left"> 
													<a href="OpdRegistration.jsp?id=<%=rsOPD.getInt("objid")%>"><img src="../images/icoEdit.gif" border="0"></a>
												</td>
												<td align="left">
													<a href="OpdRegistrationList.jsp?id=<%=rsOPD.getInt("objid")%>"><img src="../images/icoDel.gif" border="0"></a>
												</td>
												<%}%>													
												<td align="right"> 
													<%=rsOPD.getString("regnno")%>
												</td>
												<td align="left">
													<%=rsOPD.getString("patientname")%>
												</td>
												<td align="left">
													<%
													String dcode="",dname="",dobjid="";
													doctor.Connect();
													dobjid = rsOPD.getString("doctorobjid");
													dcode = doctor.getDoctorCode(dobjid);
													dname = doctor.getDoctorName(dcode);
													doctor.DisConnect();													
													%>
													<%=dname%>
												</td>
												<td align="center">
													<%=rsOPD.getString("patsex")%>
												</td>
												<td align="center">
													<%=rsOPD.getString("oldnew")%>
												</td>
												<td align="center">
													<%=rsOPD.getString("stafffree")%>
												</td>
												<td align="left">
												<%
												String empcode="",empname="",empobjid="";
												employee.Connect();
												empobjid = rsOPD.getString("empobjid");		
												empcode = employee.getEmployeeCode(empobjid);
												empname = employee.getEmployeeName(empcode);
												employee.DisConnect();																					
												%>
												<%=empname%>
												</td>
												<td align="center">
													<%=rsOPD.getString("printstatus")%>
												</td>
												<td align="right">
													<%
													mtot+=Integer.parseInt(rsOPD.getString("billamnt"));
													%>
													<%=rsOPD.getString("billamnt")%>
												</td>
											</tr>
										  <%
										  i++;
										  i1++;
										  ptCnt++;
										  }
										rsOPD.close();
										if(ptCnt>0){%>										
										<tr class="grdback">
											<td colspan="8">Total Visit : <%=ptCnt%></td>
											<td class="Font8vB" colspan="2">Total Amount(Rs.) :</td>
											<td class="Font8vB" align="right"><%=mtot%></td>
										</tr>
                                        <tr>
											<td colspan="11">&nbsp;</td>
										</tr>
										<%
										}
									}									
									if(opdtype.equals("A") || opdtype.equals("F")){
										ptCnt = 0;
										mtot = 0;
										rsOPD = opdregistration.listOpdRegistration(strQry_FS);	
										while(rsOPD.next()){																										
											if(i%2==0){%>
											<TR onMouseOver="this.className='selected'" onMouseOut="this.className='treven'" class="treven">
											<%}else{%>
											<TR onMouseOver="this.className='selected'" onMouseOut="this.className='trodd'" class="trodd">
											<%}%>
												<%if(UserRole.equals("2")){%>
												<td align="left" colspan="2"> 
													<a href="OpdRegistration.jsp?id=<%=rsOPD.getInt("objid")%>"><img src="../images/icoEdit.gif" border="0"></a>
												</td>
												<%}else{%>														
												<td align="left"> 
													<a href="OpdRegistration.jsp?id=<%=rsOPD.getInt("objid")%>"><img src="../images/icoEdit.gif" border="0"></a>
												</td>
												<td align="left">
													<a href="OpdRegistrationList.jsp?id=<%=rsOPD.getInt("objid")%>"><img src="../images/icoDel.gif" border="0"></a>
												</td>
												<%}%>													
												<td align="right"> 
													<%=rsOPD.getString("regnno")%>
												</td>
												<td align="left">
													<%=rsOPD.getString("patientname")%>
												</td>
												<td align="left">
													<%
													String dcode="",dname="",dobjid="";
													doctor.Connect();
													dobjid = rsOPD.getString("doctorobjid");
													dcode = doctor.getDoctorCode(dobjid);
													dname = doctor.getDoctorName(dcode);
													doctor.DisConnect();													
													%>
													<%=dname%>
												</td>
												<td align="center">
													<%=rsOPD.getString("patsex")%>
												</td>
												<td align="center">
													<%=rsOPD.getString("oldnew")%>
												</td>
												<td align="center">
													<%=rsOPD.getString("stafffree")%>
												</td>
												<td align="left">
												<%
												String empcode="",empname="",empobjid="";
												employee.Connect();
												empobjid = rsOPD.getString("empobjid");		
												empcode = employee.getEmployeeCode(empobjid);
												empname = employee.getEmployeeName(empcode);
												employee.DisConnect();																					
												%>
												<%=empname%>
												</td>
												<td align="center">
													<%=rsOPD.getString("printstatus")%>
												</td>
												<td align="right">
													<%
													mtot+=Integer.parseInt(rsOPD.getString("billamnt"));
													%>
													<%=rsOPD.getString("billamnt")%>
												</td>
											</tr>
										  <%
										  i++;
										  i2++;
										  ptCnt++;
										}
										rsOPD.close();
									}
									
									opdregistration.DisConnect();
									
									}catch(Exception e){}
									if(ptCnt>0){%>										
									<tr class="grdback">
										<td colspan="8">Total Visit : <%=ptCnt%></td>
										<td class="Font8vB" colspan="2">Total Amount(Rs.) :</td>
										<td class="Font8vB" align="right"><%=mtot%></td>
									</tr>
									<%}
									if(i1==0 && i2==0){
									%>
									<tr>
										<td colspan="10"><font class="Font8vRed">No data fond</font></td>
									</tr>
									<%}%>								
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


