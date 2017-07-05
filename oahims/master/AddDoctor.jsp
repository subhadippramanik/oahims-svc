<%@ page contentType="text/html; charset=ISO-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
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
String objid = null;
String dcode = "",dtitle = "",dnamef = "",dnamem = "",dnamel = "",contactno = "",dadd = "",isactive = "",byuser = UserNM;

if(request.getParameter("formAction")!=null){
    String formAction=request.getParameter("formAction");

    /*   Doctor's Details */
	objid = request.getParameter("objid");
    dcode = request.getParameter("dcode");
    dtitle = request.getParameter("dtitle");
	dnamef = request.getParameter("dnamef");
	dnamem = request.getParameter("dnamem");
	dnamel = request.getParameter("dnamel");
	contactno = request.getParameter("contactno");
	dadd = request.getParameter("dadd");
	isactive = request.getParameter("isactive");
		
    /*   Save Action For Doctor's Add   */

    doctor.Connect();

    /* For perform Actions based on Request */

      if(formAction.equals("Add"))
          {
            int mCnt = doctor.checkDoctorId(dcode);
            if(mCnt==0){
				doctor.addDoctor(dcode,dnamef,dnamem,dnamel,contactno,dadd,isactive,byuser);
				%><center><h2>Successfully Inserted </h2></center><%
			}else{
				%><center><h2>Code : <%=dcode%> already exists. Please try with another.</h2></center><%
			}
     }

     if(formAction.equals("Delete"))
          {
               	int no=0;
               	no=doctor.deleteDoctor(objid);
           		if(no!=0){
               		%><center><h2>Successfully data Deleted</h2></center><%
          		}else{
             		%><center><h2>Unable to Delete.Because there is no data with <%=objid%> </h2></center><% 
                }
       }

     if(formAction.equals("Update"))
          {
               int no=0;
               no=doctor.updateDoctor(objid,dcode,dnamef,dnamem,dnamel,contactno,dadd,isactive,byuser);
			   if(no!=0){
				   %><center><h2>Data successfully Updated</h2></center><%
			   }else{
				 %><center><h2>Unable to Update.Because there is no data with <%=objid%> </h2></center><% 
               }
       }
      
    doctor.DisConnect();
}

if(request.getParameter("id")!=null){
	objid = request.getParameter("id");
	doctor.Connect();
	
	try{
		ResultSet tempRs = doctor.listDoctorById(objid);
		while(tempRs.next()){
			objid = tempRs.getString("objid");
			dcode = tempRs.getString("dcode");
			dtitle = tempRs.getString("dtitle");
			dnamef = tempRs.getString("dnamef");
			dnamem = tempRs.getString("dnamem");
			dnamel = tempRs.getString("dnamel");
			contactno = tempRs.getString("contactno");
			dadd = tempRs.getString("dadd");
			isactive = tempRs.getString("isactive");
		}
		tempRs.close();
		doctor.DisConnect();	
	}catch(Exception e){}	
}else{
	objid = null;
	dcode = "";
	dtitle = "";
	dnamef = "";
	dnamem = "";
	dnamel = "";
	contactno = "";
	dadd = "";
	isactive = "";
}
%>
<HTML lang=en>
<HEAD><TITLE>SISL Tab </TITLE>
<META http-equiv=Content-Type content="text/html; charset=ISO-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
<script language="javascript">
	function DoSubmitAction(mAction){
		document.frmDoctor.formAction.value = mAction;
		//alert("mAction");			
		if((mAction=="Add") || (mAction=="Update")){
			//alert(mAction);	
			var dcode=document.frmDoctor.dcode.value;
			if(dcode=="" || dcode.length==0){
				alert("Please enter Doctor's Code to continue....");
				document.frmDoctor.dcode.focus();
				return false;
			}
			var dnamef=document.frmDoctor.dnamef.value;
			if(dnamef=="" || dnamef.length==0){
				alert("Please enter Doctor's First Name to continue....");
				document.frmDoctor.dnamef.focus();
				return false;
			}
			var dnamel=document.frmDoctor.dnamel.value;
			if(dnamel=="" || dnamel.length==0){
				alert("Please enter Doctor's Last Name to continue....");
				document.frmDoctor.dnamel.focus();
				return false;
			}
			var contactno=document.frmDoctor.contactno.value;
			if(contactno=="" || contactno.length==0){
				alert("Please enter Doctor's Contact No to continue....");
				document.frmDoctor.contactno.focus();
				return false;
			}		
		}
		if(mAction=="Update"){
			var objid=document.frmDoctor.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a Doctor to Update....");
				document.frmDoctor.dcode.focus();
				return false;
			}	
		}
		if(mAction=="Delete"){
			var objid=document.frmDoctor.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a Doctor to Delete....");
				document.frmDoctor.dcode.focus();
				return false;
			}
		}
		
		if(mAction=="Cancel"){	
			location.href="AddDoctor.jsp";		
		}
		
		document.frmDoctor.submit();
		return true;
	}
</script>
</HEAD>
<BODY topmargin="5px">
<form name="frmDoctor" method="post" action="AddDoctor.jsp">
	<table width="700" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
			:: DOCTOR ENTRY ::
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
                    		background="../images/tabs_on.gif" class="Font8vB" >&nbsp;&nbsp;&nbsp;&nbsp;DOCTOR</td> 
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
                              <td class="grdback">Doctor Reg. No. : <font class="Font8vRed">*</font></td>
                              <td><input class="mandtxtbox" type="text" name="dcode" id="dcode" maxlength="12" value="<%=dcode%>"/></td>
                              <td>&nbsp;</td>
                              <td class="Font8v">&nbsp;</td>
                            </tr>
                            <tr>
                              <td class="grdback">Doctor's Name : <font class="Font8vRed">*</font></td>
                              <td class="Font8v" nowrap colspan="3">
                                <select name="dtitle" class="mandtxtbox">
                                	<option value="Dr.">DR.</option>
                                </select>
                                <input class="mandtxtbox" name="dnamef" type="text" id="dnamef" size="15" maxlength="16" value="<%=dnamef%>" />
                                <input class="mandtxtbox" name="dnamem" type="text" id="dnamem" size="4" maxlength="16" value="<%=dnamem%>"/>
                                <input class="mandtxtbox" name="dnamel" type="text" id="dnamel" size="15" maxlength="16" value="<%=dnamel%>" />
                              </td>
                            </tr>
                            <tr>
                              <td class="grdback">Contact no : <font class="Font8vRed">*</font></td>
                              <td colspan="3"><input class="mandtxtbox" type="text" name="contactno" id="contactno" size="32" maxlength="32" value="<%=contactno%>"/></td>
                            </tr>
                            <tr>
                              <td class="grdback" valign="top">Doctor's address :</td>
                              <td colspan="3"><textarea name="dadd" class="mandtxtbox" rows="3" cols="50"><%=dadd%></textarea></td>
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
