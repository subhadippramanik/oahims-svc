<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.util.*"%>

<%@ page import="com.oa.kh.common.*" %>
<jsp:useBean id="loginCheck" class="com.oa.kh.common.Login"/>

<%
if(request.getParameter("Submit")!=null){ 
  	//response.write("ok==" + request.getParameter("value_for_action"));
  	HttpSession mysession = request.getSession(true);
  	String value_for_action=request.getParameter("Submit");
  	/*   User Details  */
  	String userId=request.getParameter("txtUserId");
  	String userPwd=request.getParameter("txtPwd");
  	String userType=request.getParameter("usrRole");
  	/*   Save Action For CompAdd   */
  	System.out.println("userId==" + userId);
    
  	loginCheck.Connect();    
	if(value_for_action.equals("Login"))
	{
		int loginFlg = loginCheck.CheckLogin(userId,userPwd,userType);
		if(loginFlg>0){
  			System.out.println("Ok here==userType===" + userType);
			session.setAttribute("userRole",userType);
  			session.setAttribute("userName",userId);
			if(loginFlg==2){
  				response.sendRedirect("home.jsp");
			}else{
				response.sendRedirect("admin_home.jsp");
			}
		}else{
  			response.sendRedirect("index.htm?msg=1");
		}       
	}
	loginCheck.DisConnect(); 
}
%>
