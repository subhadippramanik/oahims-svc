<%@ page contentType="text/html; charset=ISO-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="employee" class="com.oa.kh.hrm.Employee"/>
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
String objid = null;
String empcode  = "",emptitle = "",empnamef = "",empnamem = "",empnamel = "",empsex = "", empdob = "",contactno = "",empadd = "",empphoto = "",empdoj = "",isactive = "",byuser = UserNM;

if(request.getParameter("formAction")!=null){
    String formAction=request.getParameter("formAction");

    /*   Doctor's Details */
	objid = request.getParameter("objid");
    empcode = request.getParameter("empcode");
    emptitle = request.getParameter("emptitle");
	empnamef = request.getParameter("empnamef");
	empnamem = request.getParameter("empnamem");
	empnamel = request.getParameter("empnamel");
	empsex = request.getParameter("empsex");
	empdob = request.getParameter("empdob");
	//System.out.println("========================empdob=============================="+empdob);
	contactno = request.getParameter("contactno");
	empadd = request.getParameter("empadd");
	empdoj = request.getParameter("empdoj");
	empphoto = request.getParameter("empphoto");
	isactive = request.getParameter("isactive");		
    /*   Save Action For Doctor's Add   */

    employee.Connect();

    /* For perform Actions based on Request */

      if(formAction.equals("Add"))
          {
            int mCnt = employee.checkEmployeeId(empcode);
            if(mCnt==0){
				employee.addEmployee(empcode,emptitle,empnamef,empnamem,empnamel,empsex,empdob,contactno,empadd,empphoto,empdoj,isactive,byuser);
				%><center><h2>Information Posted Successfully</h2></center><%
			}else{
				%><center><h2>Code : <%=empcode%> already exists. Please try with another.</h2></center><%
			}
     }

     if(formAction.equals("Delete"))
          {
               	int no=0;
               	no=employee.deleteEmployee(objid);
           		if(no!=0){
               		%><center><h2>Successfully data Deleted</h2></center><%
          		}else{
             		%><center><h2>Unable to Delete.Because there is no data with <%=objid%> </h2></center><% 
                }
       }

     if(formAction.equals("Update"))
          {
               int no=0;
			   //System.out.println("========================empdob=============================="+empdob);
               no=employee.updateEmployee(objid,empcode,emptitle,empnamef,empnamem,empnamel,empsex,empdob,contactno,empadd,empphoto,empdoj,isactive,byuser);
			   if(no!=0){
				   %><center><h2>Data successfully Updated</h2></center><%
			   }else{
				 %><center><h2>Unable to Update.Because there is no data with <%=objid%> </h2></center><% 
               }
       }
      
    employee.DisConnect();
}

if(request.getParameter("id")!=null){
	objid = request.getParameter("id");
	employee.Connect();	
	try{
		ResultSet tempRs = employee.listEmployeeById(objid);
		while(tempRs.next()){
			objid = tempRs.getString("objid");
			empcode = tempRs.getString("empcode");
			emptitle = tempRs.getString("emptitle");
			empnamef = tempRs.getString("empnamef");
			empnamem = tempRs.getString("empnamem");
			empnamel = tempRs.getString("empnamel");
			empsex = tempRs.getString("empsex");
			empdob = tempRs.getString("empdob");
			contactno = tempRs.getString("contactno");
			empadd = tempRs.getString("empadd");
			empphoto = tempRs.getString("empphoto");
			empdoj = tempRs.getString("empdoj");
			isactive = tempRs.getString("isactive");
		}
		tempRs.close();
		employee.DisConnect();	
	}catch(Exception e){}	
}else{
	objid = null;
	empcode = "";
	emptitle = "";
	empnamef = "";
	empnamem = "";
	empnamel = "";
	empsex = "";
	empdob = "";	
	contactno = "";
	empadd = "";
	empphoto = "";
	empdoj = "";
	isactive = "";
}
%>
<HTML lang=en>
<HEAD><TITLE>SISL Tab </TITLE>
<META http-equiv=Content-Type content="text/html; charset=ISO-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
<script language="javascript">
	function DoSubmitAction(mAction){
		document.frmEmployee.formAction.value = mAction;
		//alert("mAction");			
		if((mAction=="Add") || (mAction=="Update")){
			//alert(mAction);	
			var dcode=document.frmEmployee.empcode.value;
			if(dcode=="" || dcode.length==0){
				alert("Please enter Employee Code to continue....");
				document.frmEmployee.empcode.focus();
				return false;
			}
			var dnamef=document.frmEmployee.empnamef.value;
			if(dnamef=="" || dnamef.length==0){
				alert("Please enter Employee First Name to continue....");
				document.frmEmployee.empnamef.focus();
				return false;
			}
			var dnamel=document.frmEmployee.empnamel.value;
			if(dnamel=="" || dnamel.length==0){
				alert("Please enter Employee Last Name to continue....");
				document.frmEmployee.empnamel.focus();
				return false;
			}
			var contactno=document.frmEmployee.contactno.value;
			if(contactno=="" || contactno.length==0){
				alert("Please enter Employee Contact No to continue....");
				document.frmEmployee.contactno.focus();
				return false;
			}
			var empdob=document.frmEmployee.empdob.value;
			if(empdob=="" || empdob.length==0){
				alert("Please enter Employee DOB No to continue....");
				document.frmEmployee.empdob.focus();
				return false;
			}
					
		}
		if(mAction=="Update"){
			var objid=document.frmEmployee.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a Employee to Update....");
				document.frmEmployee.dcode.focus();
				return false;
			}	
		}
		if(mAction=="Delete"){
			var objid=document.frmEmployee.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a Employee to Delete....");
				document.frmEmployee.dcode.focus();
				return false;
			}
		}
		
		if(mAction=="Cancel"){	
			location.href="AddEmployee.jsp";		
		}
		
		document.frmEmployee.submit();
		return true;
	}
</script>
<SCRIPT language=JavaScript src="../common/date_picker.js"></SCRIPT>
</HEAD>
<BODY topmargin="5px">
<form name="frmEmployee" method="post" action="AddEmployee.jsp">
	<table width="700" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
			:: EMPLOYEE ENTRY ::
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
                    		background="../images/tabs_on.gif" class="Font8vB" >&nbsp;&nbsp;&nbsp;&nbsp;EMPLOYEE</td> 
                    <td style="BORDER-BOTTOM: #c3d5ff 1PX SOLID;WIDTH:580px">&nbsp;</td>
               </tr>
               <tr>
               		<td colspan="2" 
                    	style="BORDER-LEFT: #c3d5ff 1PX SOLID;BORDER-BOTTOM: #c3d5ff 1PX SOLID;BORDER-RIGHT: #c3d5ff 1PX SOLID;"
                        		colspan="6">     
                       	<table border="0" align="center" cellpadding="3" cellspacing="3">
                            <tr>
                              <td colspan="5" style="HEIGHT:10px;">&nbsp;</td>							  
                            </tr>
                            <tr>
                              <td class="grdback">Employee Code : <font class="Font8vRed">*</font></td>
                              <td><input class="mandtxtbox" type="text" name="empcode" id="empcode" maxlength="12" value="<%=empcode%>"/></td>
                              <td>&nbsp;</td>
                              <td class="Font8v">&nbsp;</td>
							  <%if(empphoto.length()!=0){%>
							  <td class="Font8v" rowspan="4" valign="top" align="center" style="border:1px solid #FF33FF;">
								  <img src="../empphoto/<%=empphoto%>" width="100" height="120">
							  </td>
							  <%}else{%>
							  <td class="Font8v" rowspan="4" valign="top" align="center">&nbsp;</td>
							  <%}%>							  
                            </tr>
                            <tr>
                              <td class="grdback">Employee Name : <font class="Font8vRed">*</font></td>
                              <td class="Font8v" nowrap colspan="3">
                                <select name="emptitle" class="mandtxtbox">
                                	<%if(emptitle.equals("Dr.")){%>
									<option value="Dr." selected>Dr.</option>
									<option value="Mr.">Mr.</option>
									<option value="Mrs.">Mrs.</option>
									<option value="Miss.">Miss.</option>
									<%}else if(emptitle.equals("Mr.")){%>
									<option value="Dr.">Dr.</option>
									<option value="Mr." selected>Mr.</option>
									<option value="Mrs.">Mrs.</option>
									<option value="Miss.">Miss.</option>
									<%}else if(emptitle.equals("Mrs.")){%>
									<option value="Dr.">Dr.</option>
									<option value="Mr.">Mr.</option>
									<option value="Mrs." selected>Mrs.</option>
									<option value="Miss.">Miss.</option>
									<%}else{%>
									<option value="Dr.">Dr.</option>
									<option value="Mr.">Mr.</option>
									<option value="Mrs.">Mrs.</option>
									<option value="Miss." selected>Miss.</option>
									<%}%>
                                </select>
                                <input class="mandtxtbox" name="empnamef" type="text" id="empnamef" size="15" maxlength="16" value="<%=empnamef%>" />
                                <input class="mandtxtbox" name="empnamem" type="text" id="empnamem" size="4" maxlength="16" value="<%=empnamem%>"/>
                                <input class="mandtxtbox" name="empnamel" type="text" id="empnamel" size="15" maxlength="16" value="<%=empnamel%>" />
                              </td>
                            </tr>
							<tr>
                              <td class="grdback">Employee Sex : <font class="Font8vRed">*</font></td>
                              <td>
							  	<select name="empsex" class="mandtxtbox">
                                	<%if(empsex.equals("F")){%>
									<option value="M">Male</option>
									<option value="F" selected>Female</option>
									<%}else{%>
									<option value="M" selected>Male</option>
									<option value="F">Female</option>
									<%}%>
                                </select>
							  </td>
                              <td class="grdback">DOB : <font class="Font8vRed">*</font></td>
                              <td class="Font8v">
							  	<input class="mandtxtbox" type="text" name="empdob" id="empdob" maxlength="12" size="12" value="<%=empdob%>" onFocus="blur();"/>
                                <A href="javascript:show_calendar('frmEmployee.empdob')" onMouseOut="window.status='';return true;" onmouseover="window.status='Date Picker';return true;"><img src="../images/SHOWCAL.GIF" width="18" height="18" border="0"></a>
                            </tr>
							<tr>
                              <td class="grdback" valign="top">DOJ : <font class="Font8vRed">*</font></td>
                              <td colspan="3">
							  	<input class="mandtxtbox" type="text" name="empdoj" id="empdoj" maxlength="12" size="12" value="<%=empdoj%>" onFocus="blur();"/>
                                <A href="javascript:show_calendar('frmEmployee.empdoj')" onMouseOut="window.status='';return true;" onmouseover="window.status='Date Picker';return true;"><img src="../images/SHOWCAL.GIF" width="18" height="18" border="0"></a>
							  </td>
                            </tr>
                            <tr>
                              <td class="grdback">Contact no : <font class="Font8vRed">*</font></td>
                              <td colspan="3"><input class="mandtxtbox" type="text" name="contactno" id="contactno" size="32" maxlength="32" value="<%=contactno%>"/></td>
							  <td>&nbsp;</td>
                            </tr>
                            <tr>
                              <td class="grdback" valign="top">Address :</td>
                              <td colspan="3"><textarea name="empadd" class="mandtxtbox" rows="3" cols="50"><%=empadd%></textarea></td>
							  <td>&nbsp;</td>
                            </tr>
							<tr>
                              <td class="grdback">Employee Photo(PP) : <font class="Font8vRed">*</font></td>
                              <td colspan="4"><input class="mandtxtbox" type="text" name="empphoto" id="empphoto" size="32" maxlength="32" value="<%=empphoto%>"/></td>
                           </tr>
                           <tr>
                              <td class="grdback">Is Active ?</td>
                              <td>
                              	<select name="isactive" class="mandtxtbox">
                                	<%if(isactive.equals("N")){%>
                                    <option value="Y">Yes</option>
                                    <option value="N" selected>No</option>
                                    <%}else{%>
                                    <option value="Y" selected>Yes</option>
                                    <option value="N">No</option>
                                    <%}%>
                                </select>  
                              </td>
                              <td></td>
                              <td></td>
							  <td></td>
                            </tr>
                            <tr>
                              <td colspan="5" style="HEIGHT:10px;">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="5" style="HEIGHT:10px;" align="center">
                              	<input class="mandtxtbox" type="button" name="btnAdd" value=" Add " onClick="DoSubmitAction('Add')" <%if(objid != null){%> disabled<%}%>>
								<input class="mandtxtbox" type="button" name="btnUpdate" value="Update" onClick="DoSubmitAction('Update')" <%if(objid == null){%> disabled<%}%>>
								<input class="mandtxtbox" type="button" name="btnCancel" value="Cancel"  onClick="DoSubmitAction('Cancel');">
								<input class="mandtxtbox" type="button" name="btnDelete" value="Delete" onClick="DoSubmitAction('Delete')" <%if(objid == null){%> disabled<%}%>>
								<input class="mandtxtbox" type="hidden" name="objid" value="<%=objid%>">
								<input class="mandtxtbox" type="hidden" name="formAction" value="">
                              </td>
                            </tr>
							<tr>
                              <td colspan="5" style="HEIGHT:10px;">&nbsp;</td>
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
<iframe width=132 height=142 name="gToday:contrast:agenda.js" id="gToday:contrast:agenda.js" src="DateRange/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; top:-500px; left:-500px;">
</iframe>
</BODY>
</HTML>
