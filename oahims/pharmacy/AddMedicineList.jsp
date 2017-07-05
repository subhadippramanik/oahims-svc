<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="doctor" class="com.oa.kh.mst.Doctor"/>


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
    doctor.Connect();    
   	int no=0;
   	no=doctor.deleteDoctor(objid);
   	if(no!=0){
	   	%><center><h2>Information Deleted Successfully</h2></center><%
 	}else{
	 	%><center><h2>Unable to Delete. Because there is no data with <%=objid%> </h2></center><% 
	}      
   doctor.DisConnect();
}
%>    
<html>
<head>
<title>Grade List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
</head>
<body >
<form name="frmDoctorList" method="post" action="AddDoctorList.jsp">
	<table width="90%" border="0" align="center">  	
		<tr>
			<td>
				<table width="100%">
					<tr>
						<td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
                            :: DOCTOR LIST ::
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
									Doctor's Reg. No.
								</td>						  
								<td align="center">
									Doctor's Name
								</td>
								<td align="center">
									Doctor's Contactno
								</td>
                                <td align="center">
									Is Active ?
								</td>
							</tr>
								  <%
								  int i = 1;
								  doctor.Connect();
								  try{
										ResultSet tempRs = doctor.listDoctorById(null);
										while(tempRs.next()){																										
										if(i%2==0){%>
											<TR onMouseOver="this.className='selected'" onMouseOut="this.className='treven'" class="treven">
											<%}else{%>
											<TR onMouseOver="this.className='selected'" onMouseOut="this.className='trodd'" class="trodd">
											<%}%>
												<td align="left"> 
													<a href="AddDoctor.jsp?id=<%=tempRs.getInt("objid")%>"><img src="../images/icoEdit.gif" border="0"></a>
												</td>		
												<td align="left"> 
													<a href="AddDoctorList.jsp?id=<%=tempRs.getInt("objid")%>"><img src="../images/icoDel.gif" border="0"></a>
												</td>	
												<td align="left"> 
													<%=tempRs.getInt("dcode")%>
												</td>						  
												<td align="left">
													<%=tempRs.getString("dnamef")%>&nbsp;
                                                    <%=tempRs.getString("dnamem")%>&nbsp;
                                                    <%=tempRs.getString("dnamel")%>
												</td>
                                                <td align="left">
													<%=tempRs.getString("contactno")%>
												</td>
                                                <td align="left">
													<%=tempRs.getString("isactive")%>
												</td>
											</tr>
										  <%
										  i++;
										  }
											tempRs.close();
											doctor.DisConnect();
											
											}catch(Exception e){}
											if(i==1){
											%>
                                                <tr>
                                                    <td colspan="4"><font class="Font8vRed">No data fond</font></td>
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


