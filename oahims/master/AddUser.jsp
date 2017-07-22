<%@ page contentType="text/html; charset=ISO-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="user" class="com.oa.kh.mst.User"/>


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
String objid = null;
String login = "",pswd = "",access_type = "";

if(request.getParameter("formAction")!=null){
    String formAction=request.getParameter("formAction");

    /*   Doctor's Details */
	objid = request.getParameter("objid");
    login = request.getParameter("login");
    pswd = request.getParameter("pswd");
	access_type = request.getParameter("access_type");		
    /*   Save Action For Doctor's Add   */

    user.Connect();
    /* For perform Actions based on Request */
      if(formAction.equals("Add"))
          {
            int mCnt = user.checkUserId(login);
            if(mCnt==0){
				user.addUser(login,pswd,access_type);
				%><center><h2>Successfully Inserted </h2></center><%
			}else{
				%><center><h2>Code : <%=login%> already exists. Please try with another.</h2></center><%
			}
     }

     if(formAction.equals("Delete"))
          {
               	int no=0;
               	no=user.deleteUser(objid);
           		if(no!=0){
               		%><center><h2>Successfully data Deleted</h2></center><%
          		}else{
             		%><center><h2>Unable to Delete.Because there is no data with <%=objid%> </h2></center><% 
                }
       }

     if(formAction.equals("Update"))
          {
               int no=0;
               no=user.updateUser(objid,login,pswd,access_type);
			   if(no!=0){
				   %><center><h2>Data successfully Updated</h2></center><%
			   }else{
				 %><center><h2>Unable to Update.Because there is no data with <%=objid%> </h2></center><% 
               }
       }
      
    user.DisConnect();
}

if(request.getParameter("id")!=null){
	objid = request.getParameter("id");
	user.Connect();
	
	try{
		ResultSet tempRs = user.listUserById(objid);
		while(tempRs.next()){
			objid = tempRs.getString("objid");
			login = tempRs.getString("login");
			pswd = tempRs.getString("pswd");
			access_type = tempRs.getString("access_type");
		}
		tempRs.close();
		user.DisConnect();	
	}catch(Exception e){}	
}else{
	objid = null;
	login = "";
	pswd = "";
	access_type = "";
}
%>
<HTML lang=en>
<HEAD><TITLE>SISL Tab </TITLE>
<META http-equiv=Content-Type content="text/html; charset=ISO-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
<script language="javascript">
	function DoSubmitAction(mAction){
		document.frmUser.formAction.value = mAction;
		//login,pswd,access_type			
		if((mAction=="Add") || (mAction=="Update")){
			//alert(mAction);	
			var login=document.frmUser.login.value;
			if(login=="" || login.length==0){
				alert("Please enter User Login Id to continue....");
				document.frmUser.login.focus();
				return false;
			}
			var pswd=document.frmUser.pswd.value;
			if(pswd=="" || pswd.length==0){
				alert("Please enter Password to continue....");
				document.frmUser.pswd.focus();
				return false;
			}
			var pswdc=document.frmUser.pswdc.value;
			if(pswdc!=pswd){
				alert("Password and Confirm Password must be same");
				document.frmUser.pswdc.focus();
				return false;
			}
		}
		if(mAction=="Update"){
			var objid=document.frmUser.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a User to Update....");
				document.frmUser.dcode.focus();
				return false;
			}	
		}
		if(mAction=="Delete"){
			var objid=document.frmUser.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a User to Delete....");
				document.frmUser.dcode.focus();
				return false;
			}
		}
		
		if(mAction=="Cancel"){	
			location.href="AddUser.jsp";		
		}
		
		document.frmUser.submit();
		return true;
	}
</script>
</HEAD>
<BODY topmargin="5px">
<form name="frmUser" method="post" action="AddUser.jsp">
	<table width="700" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
			:: USER ENTRY ::
        </td>
      </tr>
      <tr>
        <td class="Font8vB">&nbsp;        	
			
        </td>
      </tr>
      <tr>
        <td>  
        	<table border="0" cellpadding="0" cellspacing="0">
            	<tr>
                	<td style="BORDER-BOTTOM: #c3d5ff 0PX SOLID;WIDTH:120px;HEIGHT:33px" 
                    		background="../images/tabs_on.gif" class="Font8vB" >&nbsp;&nbsp;&nbsp;&nbsp;USER</td> 
                    <td style="BORDER-BOTTOM: #c3d5ff 1PX SOLID;WIDTH:580px">&nbsp;</td>
               </tr>
               <tr>
               		<td colspan="2" 
                    	style="BORDER-LEFT: #c3d5ff 1PX SOLID;BORDER-BOTTOM: #c3d5ff 1PX SOLID;BORDER-RIGHT: #c3d5ff 1PX SOLID;"
                        		colspan="6">     
                       	<table border="0" align="center" cellpadding="3" cellspacing="3">
                            <tr>
                              <td colspan="4" style="HEIGHT:10px;">&nbsp;</td>
                            </tr>
                            <tr>
                              <td class="grdback">Login Id : <font class="Font8vRed">*</font></td>
                              <td><input class="mandtxtbox" type="text" name="login" id="login" maxlength="12" value="<%=login%>"/></td>
                              <td>&nbsp;</td>
                              <td class="Font8v">&nbsp;</td>
                            </tr>
                            <tr>
                              <td class="grdback">Password : <font class="Font8vRed">*</font></td>
                              <td colspan="3"><input class="mandtxtbox" type="Password" name="pswd" id="pswd" size="32" maxlength="32" value="<%=pswd%>"/></td>
                            </tr>
                            <tr>
                              <td class="grdback" valign="top">Confirm Password :</td>
                              <td colspan="3"><input class="mandtxtbox" type="Password" name="pswdc" id="pswdc" size="32" maxlength="32" value="<%=pswd%>"/></td>
                            </tr>
							<tr>
                              <td class="grdback">User Role ?</td>
                              <td>
                              	<select name="access_type" class="mandtxtbox">
                                	<%if(access_type.equals("1")){%>
                                    <option value="2">User</option>
                                    <option value="1" selected>Admin</option>
                                    <%}else{%>
                                    <option value="2" selected>User</option>
                                    <option value="1">Admin</option>
                                    <%}%>
                                </select>  
                              </td>
                              <td></td>
                              <td></td>
                            </tr>
                            <tr>
                              <td colspan="4" style="HEIGHT:10px;">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="4" style="HEIGHT:10px;" align="center">
                              	<input class="mandtxtbox" type="button" name="btnAdd" value=" Add " onClick="DoSubmitAction('Add')" <%if(objid != null){%> disabled<%}%>>
								<input class="mandtxtbox" type="button" name="btnUpdate" value="Update" onClick="DoSubmitAction('Update')" <%if(objid == null){%> disabled<%}%>>
								<input class="mandtxtbox" type="button" name="btnCancel" value="Cancel"  onClick="DoSubmitAction('Cancel');">
								<input class="mandtxtbox" type="button" name="btnDelete" value="Delete" onClick="DoSubmitAction('Delete')" <%if(objid == null){%> disabled<%}%>>
								<input class="mandtxtbox" type="hidden" name="objid" value="<%=objid%>">
								<input class="mandtxtbox" type="hidden" name="formAction" value="">
                              </td>
                            </tr>
                          </table> 
                       </td>
                    </tr>
               </table> 
        	</td>
      	</tr>
      	<tr>
        	<td class="Font8vB">&nbsp;        	
			
        	</td>
      	</tr>
    </table>
</BODY>
</HTML>
