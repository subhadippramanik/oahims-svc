<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.util.*"%>

<%@ page import="com.oa.kh.common.*" %>
<jsp:useBean id="checkSecurity" class="com.oa.kh.common.Login"/>
<%
String UserNM = null,UserRole = null;
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HIMS </title>
<link href="./common/Styles.css" rel=stylesheet type=text/css>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
 <tr>
    <td><img src="images/appheader.jpg" height="60" width="100%" /></td>
    <td style="width:1px" bgcolor="#E5E5E5"></td>
    <td bgcolor="#E5E5E5" style="WIDTH:170PX" valign="bottom">
		<table border="0" align="right">
          <tr>
          	<%if(UserNM!=null){%>
           	<td class="Font7v">Welcome : <font class="Font8v"><%=UserNM.toUpperCase()%></font></td>
            <%}%>
			<td class="Font7v">|</td>
            <td class="Font7v"><a href="index.htm" target="_self">Log Out</a></td>
		  </TR>
		  <TR>
            <td class="Font7v">About Us</td>
            <td class="Font7v">|</td>
            <td class="Font7v">Contact Us</td>
          </tr>
        </table>
	</td>
  </tr>
  <tr>
    <td colspan="3">
    	<table width="100%" border="0" cellpadding="1" cellspacing="0">
          <tr>
            <td style="HEIGHT:10px;"></td>
          </tr>
          <tr>
            <td width="18%" valign="top">
            	<table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/bg.gif">                  
                  <tr>
                    <td>
                    	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="HEIGHT:450px;BORDER:1px solid #d2e4ff;">
                          <tr>
                            <td  valign="top">
								<SCRIPT language="javascript" src="./common/admin_leftmenu.htm"></SCRIPT>
                            </td>
                          </tr>
                        </table>
                    </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                </table>   
            </td>
            <td>
            	<iframe class="iframeControl" id="main" name="main" height="500" width="100%" FRAMEBORDER="0" src="first_admin.htm"></iframe>            
            </td>
          </tr>
        </table>
    </td>
  </tr>
</table>

</body>
</html>
