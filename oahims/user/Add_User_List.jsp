<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.util.*"%>

<%@ page import="com.oa.sng.user.*" %>
<jsp:useBean id="User_List" class="com.oa.sng.user.AddUser"/>
<%@ page import="com.oa.sng.hrpay.*" %>
<jsp:useBean id="Emp_Name" class="com.oa.sng.hrpay.EmployeeDetails"/>
<%
String user_id="";

if(request.getParameter("id")!=null){
    /*   Unit Details */
    user_id=request.getParameter("id");
    /*   Save Action For Unit   */

    User_List.Connect();
    
   	int no=0;
   	no=User_List.deleteUser(user_id);
   	if(no!=0){
	   %><center><h2>Successfully data Deleted</h2></center><%
 	}else{
	 %><center><h2>Unable to Delete. Because there is no company whose eCompany id is <%=user_id%> </h2></center><% 
	}
      
   User_List.disConnect();
}
%>      
<html>
<head>
<title>Unit</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK href="../scripts/Styles.css" type=text/css rel=stylesheet>
</head>
<body >
<form method="post" action="./Add_User.jsp">
	<table width="50%" border="0" align="center">  	
		<tr>
		<td>
			<table width="100%">
        		<tr>
				  	<td class="lblhdr">
						Unit List
					</td>
				</tr>
				<tr>					
         			<td valign="top"> 
						<table class="input" border="0" cellpadding="0" width="100%">
						  <tr> 
							<td align="center" colspan="2" class="lblhdr"> 
								Action
							</td>
							<td align="center" class="lblhdr"> 
							  	User Name
							</td>
							<td align="center" class="lblhdr">
								Password
							</td>
							<td align="center" class="lblhdr">
								Access Type
							</td>
							<td align="center" class="lblhdr">
								Emp Id
							</td>
						  </tr>
						   <%
						  int i = 1;
						  User_List.Connect();
						  try{
							ResultSet tempRs = User_List.listUserbyId(null);
							while(tempRs.next()){																										
							if(i%2==0){%>
									<TR onmouseover="this.className='selected'" onmouseout="this.className='treven'" class="treven">
									<%}else{%>
									<TR onmouseover="this.className='selected'" onmouseout="this.className='trodd'" class="trodd">
									<%} i++;%>
										<td align="left"> 
											<a href="./Add_User.jsp?id=<%=tempRs.getInt("objid")%>"><img src="../images/icoEdit.gif" border="0"></a>
										</td>		
										<td align="left"> 
											<a href="./Add_User.jsp?id=<%=tempRs.getInt("objid")%>"><img src="../images/icoDel.gif" border="0"></a>
										</td>						  
										<td align="left">
											<%=tempRs.getString("login")%>
										</td>
										<td align="left">
											<%=tempRs.getString("pswd")%>
										</td>
										<td  align="left">
											<%=User_List.getAccessType(tempRs.getInt("access_type"))%>
										</td>
										<td  align="left">
											<%=tempRs.getInt("empid")%>
										</td>
									</tr>
							  <%
							  
							  }
							tempRs.close();
							User_List.disConnect();							
							}catch(Exception e){}
							if(i==1){
							%>							
							  <tr>
								<td colspan="6" class="Font7BolRed">No data found</td>
							  </tr>
							<%}%>
			  			   	<tr>
								<td colspan="6">&nbsp;</td>
							</tr>
						  	<tr>
                				<td background="../images/collabhealth_01.gif" colspan="6"></td>
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


