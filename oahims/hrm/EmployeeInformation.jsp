<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.util.*"%>

<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="employee" class="com.oa.kh.opd.Employee"/>
<jsp:useBean id="opdregistration" class="com.oa.kh.opd.OpdRegistration"/>

<%
String empcode ="",empname="";
int objid=0;
response.flushBuffer();

if(request.getParameter("code")!=null){
	String mType = request.getParameter("type");
	//System.out.println("mType====" + mType);
	if(mType!=null && mType.equals("1")){
		empcode = request.getParameter("code");
		//System.out.println("Type 1====" + request.getParameter("type"));
		employee.Connect();	
		try{
			empname = employee.getEmployeeName(empcode);
			System.out.println("empname====" + empname );		
			employee.DisConnect();	
		}catch(Exception e){}
		
		out.println(empname);	
	}else if(mType!=null && mType.equals("2")){
		empcode = request.getParameter("code");
		//System.out.println("Type 2====" + request.getParameter("type"));
		employee.Connect();	
		try{
			objid = employee.getEmployeeObjid(empcode);
			System.out.println("objid====" + objid);		
			employee.DisConnect();	
		}catch(Exception e){}
		
		out.println(objid);	
	}else if(mType!=null && mType.equals("3")){
		empcode = request.getParameter("code");
		System.out.println("objid ====" + empcode);				
		if(empcode == null || empcode.equals("null") || empcode == ""){
			opdregistration.Connect();	
			try{
				objid = opdregistration.CreateSeqNo();
				System.out.println("objid seq no == " + objid);
				opdregistration.DisConnect();	
			}catch(Exception e){}
			
			out.println(objid);
		}	
	}
}
%>
