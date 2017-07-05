<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.oa.sng.utility.OAERPConnection"%>

<%@ page import="com.oa.sng.common.*" %>
<jsp:useBean id="Login_Check" class="com.oa.sng.common.Login"/>
<%@ page import="com.oa.sng.user.*" %>
<jsp:useBean id="adduser" class="com.oa.sng.user.AddUser"/>


<%
Connection con=null;
Statement statement=null;
OAERPConnection userConn = new OAERPConnection();
try{
    con = userConn.connect();
    statement=con.createStatement();
    }catch(Exception e){
          e.printStackTrace();
    }
    String empId="";
    String userId="";
    String passWrd="";
    String[] role=new String[5];
    role[0]="1";
    System.out.println("role== "+role[0]);
    String msg="";
    HashMap user=new HashMap();
    System.out.println("user.size()"+user.size());
    if(request.getParameter("empId")!=null){
        empId=request.getParameter("empId");
        user.put("empId",empId);
    }    
    if(request.getParameter("userId")!=null){
        userId=request.getParameter("userId");
        user.put("userId",userId);
    }
    if(request.getParameter("passWrd")!=null){
        passWrd=request.getParameter("passWrd");
        user.put("passWrd",passWrd);
    }
    System.out.println("here..."+request.getParameterValues("role"));
    if(request.getParameterValues("role")!=null){
        System.out.println("here...in if");
        role=request.getParameterValues("role");
        user.put("role",role);
    }
    System.out.println("here...out if");
    if(!user.isEmpty()){
        //System.out.println("user is "+user);
        try{
        adduser.createUser(user);
        msg=adduser.getMessage();
        }catch(Exception e){
            e.printStackTrace();
        }
    }  
    
    if(request.getParameter("id")!=null){
    	String objid=request.getParameter("id").toString();
    	String qry="select * from user_mst where objid="+objid;
    	ResultSet rsUser=statement.executeQuery(qry);
    	int i=0;
    	while(rsUser.next()){
    		empId=rsUser.getString("empid");
    		userId=rsUser.getString("login");
    		passWrd=rsUser.getString("pswd");
    		role[i]=rsUser.getString("access_type");
    		i++;
    	}
    	rsUser.close();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Training Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../scripts/Styles.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
    var req;
    function validate(){
    	document.getElementById("msg").innerHTML="";
        var idField = document.getElementById("EmpId");
        var url = "validate.jsp?empid=" + encodeURIComponent(idField.value);
        //alert("url=="+url);
        if (typeof XMLHttpRequest != "undefined") {
            req = new XMLHttpRequest();
            alert("req=="+req);
        } else if (window.ActiveXObject) {
        req = new ActiveXObject("Microsoft.XMLHTTP");
        }
        req.open("GET", url, true);
        req.onreadystatechange = callback;
        req.send(null);
    }
    
    function callback() {
            if (req.readyState == 4) {
                // if (req.status == 200) {
                // update the HTML DOM based on whether or not message is valid
                parseMessage();
            //  }
            }
    }
    
    function parseMessage() {
    	//alert(req.responseXML.xml);
        var message = req.responseXML.getElementsByTagName("message")[0];
        
        //alert(message.childNodes[0]);
        setMessage(message.childNodes[0].nodeValue);
        
        var accessid = req.responseXML.getElementsByTagName("accessid")[0];
        var password = req.responseXML.getElementsByTagName("password")[0];
        setAccessID(accessid.childNodes[0].nodeValue,password.childNodes[0].nodeValue);
    }
    
    function setMessage(message) {
        var mdiv = document.getElementById("usermessage");
        
        //alert("message== "+message);    
        if(message!="No Data"){
            document.getElementById("userId").value=message;            
            mdiv.innerHTML = "<div style=\"color:red\"></ div>";
        }else{
            mdiv.innerHTML = "<div style=\"color:red\">"+message+"</ div>";
            document.getElementById("userId").value="";
        }
        
    }
    
    function setAccessID(accessid,password){
    	//alert("password== "+password);
    	var roleLen=document.AddUser.role.length;
    	//var roleLen=document.getElementById("Role").length;
    	//alert("rolelen== "+roleLen);
    	if(accessid!="NoData"){
    		document.AddUser.passWrd.value=password;
    		//alert("accessid== "+accessid);
    		var idArr=accessid.split('|');
    		//alert(idArr[1]);
    		for(var i=0;i < idArr.length;i++){
    			if(idArr[i]!=""){
    				//alert("here 1*"+idArr[i]);
    				for(var k=0;k<roleLen;k++){
    					//alert("chk value== "+document.AddUser.role[k].value);
					if(document.AddUser.role[k].value==idArr[i]){
						//alert("here 2");
						document.AddUser.role[k].checked=true;
					}
				}
    				
    			}
    		}
    	}
    }
 function ValidateForm(){
	var EmpId=document.AddUser.EmpId.value;
	if(EmpId==""){
		alert("Employee id should not be blank");
		document.AddUser.EmpId.focus()
		return false;
	}
	var UserId=document.AddUser.UserId.value;
	if(UserId==""){
		alert("User id should not be blank");
		document.AddUser.UserId.focus()
		return false;
	}
        var PassWrd=document.AddUser.PassWrd.value;
	if(PassWrd==""){
		alert("Password should not be blank");
		document.AddUser.PassWrd.focus()
		return false;
	}
	return true;
   }
   
   function showData(){
        document.AddUser.EmpId.value="<%= empId%>";
        document.AddUser.userId.value="<%= userId%>";
        document.AddUser.passWrd.value="<%= passWrd%>";
<%
        for(int i=0;i<role.length;i++){
            if(role[i]!=null){
                System.out.println("here...in for "+(Integer.parseInt(role[i])-1));
%>
                //alert("len== "+document.AddUser.Role.length);
               // document.AddUser.Role[<%= Integer.parseInt(role[i])-1%>].selected=true;
<%
            }
        }
%>        
        
   }
</script>
</head>
<body class="ScrollBar" onload="showData()">
<form name="AddUser" method="post" action="Add_User.jsp">
<table id="Tree1" border="0" cellpadding="0" align="center">
    <tr>
        <td colspan="2" class="lblhdr" align="center">Add user</td>
    </tr>    
    <tr>
        <td class="Font8v">Employee Id: </td>
        <td ><input name="empId" type="text"  class="mandtxtbox" id="EmpId" onkeyup="validate();"></td>
        <td><div id="usermessage"></div></td>
    </tr>
    <tr>
        <td class="Font8v">User Id: </td>	
        <td ><input name="userId" type="text"  class="mandtxtbox" id="UserId" ></td>
        
    </tr>
    <tr>
        <td class="Font8v">Password: </td>
        <td ><input name="passWrd" type="password"  class="mandtxtbox" id="PassWrd" ></td>
    </tr>    
    <tr>
        <td class="Font8v" valign="top">Role: </td>
        <td align="left">
            <table align="left">
				<%
				Login_Check.Connect(); 
				adduser.Connect();
				String access_type = "";
				String access_desc = "";
				ResultSet rsRole = Login_Check.Acct_Type_List();
				while(rsRole.next()){
				access_type = rsRole.getString("access_type");
				access_desc = rsRole.getString("access_desc");
																	
					if(adduser.checkRole(access_type,empId)==true){
				%>
						<tr>
							<td><input name="role" type="checkbox" value="<%=access_type%>" checked="true"><%=access_desc%></td>
							
						</tr>						
				<%
					}else{
				%>
						<tr>
							<td><input name="role" type="checkbox" value="<%=access_type%>"><%=access_desc%></td>
							
						</tr>															
				<%      }
				}
				rsRole.close();
				Login_Check.disConnect();
				%>
			</table>
	</td>
    </tr>
    <tr></tr>
    <tr></tr>
    <tr>
        <td></td>
        <td align="left"><input  class="mandtxtbox" type="submit" value="Save" name="Save" onclick="return ValidateForm();">&nbsp;<input  class="mandtxtbox" type="reset" value="Cancel" name="Cancel"></td>	
   </tr>     
    <tr></tr>
    <tr></tr>
    <tr><td colspan="2"><div align="center" class="Font7vRed" id="msg"><%= msg%></td></tr>
</table>
</form>
</body>
</html>
