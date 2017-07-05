<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="employee" class="com.oa.kh.opd.Employee"/>
<jsp:useBean id="employeerelation" class="com.oa.kh.opd.EmployeeRelationship"/>

<%@ page import="com.oa.kh.utility.*" %>
<jsp:useBean id="apputility" class="com.oa.kh.utility.AppUtility"/>

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
    employee.Connect();    
   	int no=0;
   	no=employee.deleteEmployee(objid);
   	if(no!=0){
	   	%><center><h2>Information Deleted Successfully</h2></center><%
 	}else{
	 	%><center><h2>Unable to Delete. Because there is no data with <%=objid%> </h2></center><% 
	}      
   employee.DisConnect();
}
%>    
<html>
<head>
<title>Grade List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
</head>
<body >
<form name="frmAddEmployeeRelationshipList" method="post" action="AddEmployeeRelationshipList.jsp">
	<table width="90%" border="0" align="center">  	
		<tr>
			<td>
				<table width="100%">
					<tr>
						<td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
                            :: EMPLOYEE FAMILY MEMBER LIST ::
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
									Emp Code
								</td>						  
								<td align="center">
									Relationship
								</td>
								<td align="center">
									Name
								</td>
								<td align="center">
									DOB
								</td>
								<td align="center">
									Sex
								</td>
								<td align="center">
									Photo
								</td>
                                <td align="center">
									Status
								</td>
							</tr>
								  <%
								  int i = 1;
								  employeerelation.Connect();
								  try{
										ResultSet tempRs = employeerelation.listDistinctEmployeeRelationshipById();
										while(tempRs.next()){	
												String mObjId = tempRs.getString("empobjid");																									
												int rCnt = employeerelation.checkEmployeeRelationshipId(mObjId)+1;
												if(i%2==0){%>
                                                    <TR onMouseOver="this.className='selected'" onMouseOut="this.className='treven'" class="treven">
                                                    <%}else{%>
                                                    <TR onMouseOver="this.className='selected'" onMouseOut="this.className='trodd'" class="trodd">
                                                    <%}%>
                                                        <td align="left" rowspan="<%=rCnt%>" valign="top"> 
                                                            <a href="AddEmployeeRelationship.jsp?id=<%=tempRs.getInt("empobjid")%>"><img src="../images/icoEdit.gif" border="0"></a>
                                                        </td>		
                                                        <td align="left" rowspan="<%=rCnt%>" valign="top"> 
                                                            <a href="AddEmployeeRelationshipList.jsp?id=<%=tempRs.getInt("empobjid")%>"><img src="../images/icoDel.gif" border="0"></a>
                                                        </td>
                                                       <%
                                                       try{	
															//GETTING EMPLOYEE INFORMATION
															employee.Connect();	
															ResultSet empRS = employee.listEmployeeById(mObjId);
															while(empRS.next()){
															%>			 
															<td align="left" rowspan="<%=rCnt%>" valign="top"> 
																<%=empRS.getString("empcode")%>
                                                            </td>
                                                            <td align="left" valign="top"> 
																SELF
                                                            </td>
                                                            <td align="left" valign="top"> 
																<%=empRS.getString("empnamef")%>&nbsp;<%=empRS.getString("empnamem")%>&nbsp;<%=empRS.getString("empnamel")%>
                                                            </td>                                                            
                                                            <td align="left" valign="top"> 
																<%=empRS.getString("empdob")%>
                                                            </td>
                                                            <td align="left" valign="top"> 
																<%=empRS.getString("empsex")%>
                                                            </td>
															<td align="left" valign="top"> 
																<%=empRS.getString("empphoto")%>
                                                            </td>
                                                            <td align="left" valign="top"> 
																<%=empRS.getString("isactive")%>
                                                            </td>
															 <%}
															empRS.close();
															employee.DisConnect();
														}catch(Exception e){}
														%>
                                                        </TR>
                                                        <%
														ResultSet tempRsMember = employeerelation.listEmployeeRelationshipById(tempRs.getString("empobjid"));							
														while(tempRsMember.next()){
															if(i%2==0){%>
                                                            <TR onMouseOver="this.className='selected'" onMouseOut="this.className='treven'" class="treven">
                                                            <%}else{%>
                                                            <TR onMouseOver="this.className='selected'" onMouseOut="this.className='trodd'" class="trodd">
                                                            <%}%>
                                                                <td align="left">
                                                                    <%=tempRsMember.getString("emprelationship")%>
                                                                </td>
                                                                <td align="left">
                                                                    <%=tempRsMember.getString("emprelname")%>
                                                                </td>
                                                                <td align="left">
                                                                    <%=tempRsMember.getString("empreldob")%>
                                                                </td>
                                                                <td align="left">
                                                                    <%=tempRsMember.getString("emprelsex")%>
                                                                </td>
																<td align="left">
                                                                    <%=tempRsMember.getString("emprelphoto")%>
                                                                </td>
                                                                <td align="left">
                                                                    <%=tempRsMember.getString("isactive")%>
                                                                </td>
                                                            </tr>
													  <%
													  
												}
												i++;
										  	}
											tempRs.close();
											employeerelation.DisConnect();
											
											}catch(Exception e){}
											if(i==1){
											%>
											<tr>
												<td colspan="9"><font class="Font8vRed">No data fond</font></td>
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


