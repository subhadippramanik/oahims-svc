<%@ page contentType="text/html; charset=ISO-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.util.*"%>

<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="opdregistration" class="com.oa.kh.opd.OpdRegistration"/>
<jsp:useBean id="doctor" class="com.oa.kh.mst.Doctor"/>
<jsp:useBean id="employee" class="com.oa.kh.hrm.Employee"/>
<jsp:useBean id="employeerelation" class="com.oa.kh.hrm.EmployeeRelationship"/>

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
String regnno = "",stafffree = "",empobjid = "",oldnew = "",patientname = "",patientphoto = "";
String patstate = "",patdistrict = "",patps = "",patageyrs = "",patagemts = "",patageday = "";
String patsex = "",doctorobjid = "",isactive = "",byuser = UserNM;
String createddate="", updateddatetime="";
String billamnt ="40";

if(request.getParameter("formAction")!=null){
    String formAction=request.getParameter("formAction");

    /*   OPD's Details */
	objid = request.getParameter("objid");
    regnno = request.getParameter("regnno");
    stafffree = request.getParameter("stafffree");
	if(stafffree.equals("S") || stafffree.equals("F")){
		billamnt = "0";
	}else{
		billamnt = "40";
		stafffree="B";
	}	
	empobjid = request.getParameter("empobjid").trim();
	if(empobjid.length()==0){empobjid="0";}
	
	oldnew = request.getParameter("oldnew");
	patientname = request.getParameter("patientname");
	patientphoto = request.getParameter("patientphoto");
	patstate = request.getParameter("patstate");
	patdistrict = request.getParameter("patdistrict");
	patps = request.getParameter("patps");
	patageyrs = request.getParameter("patageyrs");
	if(patageyrs.length()==0){patageyrs="0";}
	patagemts = request.getParameter("patagemts");
	if(patagemts.length()==0){patagemts="0";}
	patageday = request.getParameter("patageday");
	if(patageday.length()==0){patageday="0";}
	patsex = request.getParameter("patsex");
	doctorobjid = request.getParameter("doctorobjid");
	isactive = "Y";
	createddate=request.getParameter("createddate");
	updateddatetime=request.getParameter("updateddatetime");
	System.out.println("createddate===" + createddate + "=====updateddatetime===" + updateddatetime);		
    /*   Save Action For Doctor's Add   */

    opdregistration.Connect();

    /* For perform Actions based on Request */

      if(formAction.equals("Add")){
	  	apputility.Connect();
		regnno = apputility.GenerateFormatedNo("OPD_REG");
		System.out.println("regnno === " + regnno);
		opdregistration.addOpdRegistration(billamnt,regnno,stafffree,empobjid,oldnew,patientname,patientphoto,patstate,patdistrict,patps,patageyrs,patagemts,patageday,patsex,doctorobjid,isactive,byuser,createddate,updateddatetime);
		%><center><h2>Information Posted Successfully</h2></center><%		
     }

     if(formAction.equals("Delete"))
     {
		int no=0;
		no=opdregistration.deleteOpdRegistration(objid);
		if(no!=0){
			%><center><h2>Successfully data Deleted</h2></center><%
		}else{
			%><center><h2>Unable to Delete.Because there is no data with <%=objid%> </h2></center><% 
		}
     }

     if(formAction.equals("Update"))
  	 {
		   int no=0;
		   no=opdregistration.updateOpdRegistration(billamnt,objid,regnno,stafffree,empobjid,oldnew,patientname,patientphoto,patstate,patdistrict,patps,patageyrs,patagemts,patageday,patsex,doctorobjid,isactive,byuser,createddate,updateddatetime);
		   if(no!=0){
			   %><center><h2>Data successfully Updated</h2></center><%
		   }else{
			 %><center><h2>Unable to Update.Because there is no data with <%=objid%> </h2></center><% 
		   }
      }
    opdregistration.DisConnect();
}

String goRegNo="",dcode="",dname="",empcode="",empname="",printstatus="";
if(request.getParameter("id")!=null){
	objid = request.getParameter("id");
	opdregistration.Connect();		
	try{
		ResultSet tempRs = opdregistration.listOpdRegistrationById(objid);
		while(tempRs.next()){
			objid = tempRs.getString("objid");
			regnno = tempRs.getString("regnno");
			stafffree = tempRs.getString("stafffree");
			empobjid = tempRs.getString("empobjid");
			oldnew = tempRs.getString("oldnew");
			patientname = tempRs.getString("patientname");
			patientphoto = tempRs.getString("patientphoto");
			patstate = tempRs.getString("patstate");
			patdistrict = tempRs.getString("patdistrict");
			patps = tempRs.getString("patps");
			patageyrs = tempRs.getString("patageyrs");
			patagemts = tempRs.getString("patagemts");
			patageday = tempRs.getString("patageday");
			patsex = tempRs.getString("patsex");
			doctorobjid = tempRs.getString("doctorobjid");
			printstatus = tempRs.getString("printstatus");
			isactive = tempRs.getString("isactive");
			createddate= tempRs.getString("createddate");
			updateddatetime= tempRs.getString("updateddatetime");
			
			doctor.Connect();
			dcode = doctor.getDoctorCode(doctorobjid);
			dname = doctor.getDoctorName(dcode);
			doctor.DisConnect();
			
			employee.Connect();			
			empcode = employee.getEmployeeCode(empobjid);
			empname = employee.getEmployeeName(empcode);
			employee.DisConnect();
		}
		tempRs.close();
		opdregistration.DisConnect();	
	}catch(Exception e){}	
}else{
	dcode = "";
	dname = "";
	empcode = "";
	empname = "";
	
	objid = null;
	regnno = "";
	stafffree = "";
	empobjid = "";
	oldnew = "";
	patientname = "";
	patientphoto = "";
	patstate = "";
	patdistrict = "";
	patps = "";
	patageyrs = "";
	patagemts = "";
	patageday = "";
	patsex = "";
	doctorobjid = "";
	printstatus = "";
	isactive = "";
	createddate = apputility.GetSystemDateToDisplay();
	updateddatetime = apputility.GetSystemDateTimeToDisplay();
}

if(request.getParameter("go")!=null){
	goRegNo = request.getParameter("regno");	
	opdregistration.Connect();
	objid = opdregistration.GetOpdRegistrationObjId(goRegNo);
				
	try{
		ResultSet tempRs = opdregistration.listOpdRegistrationById(objid);
		while(tempRs.next()){
			objid = tempRs.getString("objid");
			regnno = tempRs.getString("regnno");
			stafffree = tempRs.getString("stafffree");
			empobjid = tempRs.getString("empobjid");
			oldnew = tempRs.getString("oldnew");
			patientname = tempRs.getString("patientname");
			patientphoto = tempRs.getString("patientphoto");			
			patstate = tempRs.getString("patstate");
			patdistrict = tempRs.getString("patdistrict");
			patps = tempRs.getString("patps");
			patageyrs = tempRs.getString("patageyrs");
			patagemts = tempRs.getString("patagemts");
			patageday = tempRs.getString("patageday");
			patsex = tempRs.getString("patsex");
			doctorobjid = tempRs.getString("doctorobjid");
			printstatus = tempRs.getString("printstatus");
			isactive = tempRs.getString("isactive");
			createddate= tempRs.getString("createddate");
			updateddatetime= tempRs.getString("updateddatetime");
			
			doctor.Connect();
			dcode = doctor.getDoctorCode(doctorobjid);
			dname = doctor.getDoctorName(dcode);
			doctor.DisConnect();
			
			employee.Connect();			
			empcode = employee.getEmployeeCode(empobjid);
			empname = employee.getEmployeeName(empcode);
			employee.DisConnect();
		}
		tempRs.close();
		opdregistration.DisConnect();	
	}catch(Exception e){}	
}
%>
<HTML lang=en>
<HEAD><TITLE>SISL Tab </TITLE>
<META http-equiv=Content-Type content="text/html; charset=ISO-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
<script language="javascript">
	function DoSubmitAction(mAction){
		var frm = document.frmOPD;
		frm.formAction.value = mAction;
		//alert("mAction=="+mAction);			
		if((mAction=="Add") || (mAction=="Update")){
			//alert(mAction);	
			var oldnew=frm.oldnew.value;
			if(oldnew=="" || oldnew.length==0){
				alert("Please enter Old/New to continue....");
				frm.oldnew.focus();
				return false;
			}
			var stafffree=frm.stafffree.value;
			if(stafffree=="S"){
				var empobjid=frm.empobjid.value;
				if(empobjid=="" || empobjid.length==0){
					alert("Please enter Employee Code to continue....");
					frm.empcode.focus();
					return false;
				}
			}
			var patientname=frm.patientname.value;
			if(patientname=="" || patientname.length==0){
				alert("Please enter Patient Name to continue....");
				frm.patientname.focus();
				return false;
			}
			var patageyrs=frm.patageyrs.value;
			var patagemts=frm.patagemts.value;
			var patageday=frm.patageday.value;
			
			if(patageyrs.length==0 && patagemts.length==0 && patageday.length==0 ){
				alert("Please enter Age to continue....");
				frm.patageyrs.focus();
				return false;
			}
			var patsex=frm.patsex.value;
			if(patsex=="" || patsex.length==0){
				alert("Please enter Sex to continue....");
				frm.patsex.focus();
				return false;
			}
			var doctorobjid=frm.doctorobjid.value;
			if(doctorobjid=="" || doctorobjid.length==0){
				alert("Please enter Doctor code to continue....");
				frm.doctorobjid.focus();
				return false;
			}
					
		}
		if(mAction=="Update"){
			var objid=frm.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a Patient Visit to Update....");
				frm.regnno.focus();
				return false;
			}	
		}
		if(mAction=="Delete"){
			var objid=frm.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a Employee to Delete....");
				frm.regnno.focus();
				return false;
			}
		}
		
		if(mAction=="Cancel"){	
			location.href="OpdRegistration.jsp";		
		}
		
		frm.submit();
		return true;
	}
</script>
<script language="javascript">
	function makeUppercase(mVal) {
		mVal.value = mVal.value.toUpperCase();
	}
	function HideUnhideRegno(mVal){
		//window.event.keyCode;
		if(mVal.toUpperCase() == "N" || mVal.toUpperCase() == "O"){		
			if(mVal.toUpperCase() == "N"){
				//ajaxFunctionSeqObjid();				
				//document.frmOPD.regnno.disabled=true;
				if(window.event.keyCode==13){document.frmOPD.stafffree.focus();}
			}else{
				document.frmOPD.regnno.disabled=false;
				if(window.event.keyCode==13){document.frmOPD.regnno.focus();}
			}
		}else{
			alert("Please enter 'N' or 'O'...");
			document.frmOPD.oldnew.value="";
			document.frmOPD.oldnew.focus();
		}
	}
	function HideUnhideEmpCode(mVal){
		if(mVal.toUpperCase() == "S" || mVal.toUpperCase() == "F" || mVal.length==0){		
			if(mVal.toUpperCase() == "S"){ // || mVal.toUpperCase() == "F"){
				document.frmOPD.empcode.disabled=false;
				if(window.event.keyCode==13){document.frmOPD.empcode.focus();}
			}else{
				document.frmOPD.empcode.disabled=true;
				if(window.event.keyCode==13){document.frmOPD.patientname.focus();}
			}
		}else{
			alert("Please enter 'S','F' or ''...");
			document.frmOPD.stafffree.value="";
			document.frmOPD.stafffree.focus();
		}
	}
	
	function setVisibility(id, visibility) {
		document.getElementById(id).style.display = visibility;
	}

</script>

<script type="text/javascript">
	var xmlHttp;
  	function OpenResponse(){
		try
			{    // Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
			}catch (e){    // Internet Explorer
			try
				{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
				try
					{
					xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
					}catch (e){
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}
	}

	function ajaxFunctionEmpCode(){
		OpenResponse();
    	xmlHttp.onreadystatechange=function()
      	{
		  //alert(xmlHttp.readyState);
		  if(xmlHttp.readyState==4)
        	{
        		var mret = xmlHttp.responseText;
				document.getElementById("EmpName").innerHTML = mret;
        	}
      	} //txtPwd,txtUserId
    	xmlHttp.open("GET","EmployeeInformation.jsp?type=1&code=" + document.frmOPD.empcode.value,true);
    	xmlHttp.send(null);
	}
	
	function ajaxFunctionEmpObjid(){
		OpenResponse();
    	xmlHttp.onreadystatechange=function()
      	{
		  //alert(xmlHttp.readyState);
		  if(xmlHttp.readyState==4)
        	{
        		var mret = xmlHttp.responseText;
				document.getElementById("empobjid").value = mret;				
        	}
      	} //txtPwd,txtUserId
    	xmlHttp.open("GET","EmployeeInformation.jsp?type=2&code=" + document.frmOPD.empcode.value,true);
    	xmlHttp.send(null);
	}
	
	function ajaxFunctionSeqObjid(){
		OpenResponse();
    	xmlHttp.onreadystatechange=function()
      	{
		  //alert(xmlHttp.readyState);
		  if(xmlHttp.readyState==4)
        	{
        		var mret = xmlHttp.responseText;
				var currObjId = document.frmOPD.objid.value;
				if (currObjId == null || currObjId == "null"){
					alert("here====" + currObjId);
					document.getElementById("regnno").value = mret;
				}				
        	}
      	} //txtPwd,txtUserId
    	xmlHttp.open("GET","EmployeeInformation.jsp?type=3&code=" + document.frmOPD.objid.value,true);
    	xmlHttp.send(null);
	}
	
	
	var newwindow;
	function ShowPatientWindow(mVal){
		var mUrl = "FamilymemberInformation.jsp?code=" + mVal;
		newwindow=window.open(mUrl,'name','height=250,width=400,left=200,top=200');
 		if (window.focus){newwindow.focus()}
	}
</script>
</HEAD>
<BODY topmargin="5px" onLoad="document.frmOPD.oldnew.focus();">
<form name="frmOPD" method="post" action="OpdRegistration.jsp">
	<table width="700" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
			:: OPD REGISTRATION ENTRY ::
        </td>
      </tr>
      <tr>
        <td class="Font8vB" style="HEIGHT:5px;"></td>
      </tr>
      <tr>
        <td>  
        	<table border="0" cellpadding="0" cellspacing="0">
            	<tr>
                	<td style="BORDER-BOTTOM: #c3d5ff 0PX SOLID;WIDTH:120px;HEIGHT:33px" 
                    		background="../images/tabs_on.gif" class="Font8vB" >&nbsp;&nbsp;&nbsp;&nbsp;OPD</td> 
                    <td style="BORDER-BOTTOM: #c3d5ff 1PX SOLID;WIDTH:580px">&nbsp;</td>
               </tr>
               <tr>
               		<td colspan="2" 
                    	style="BORDER-LEFT: #c3d5ff 1PX SOLID;BORDER-BOTTOM: #c3d5ff 1PX SOLID;BORDER-RIGHT: #c3d5ff 1PX SOLID;" colspan="6">     
                       	<table border="0" align="center" cellpadding="2" cellspacing="3">
                            <tr>
                              <td colspan="4" style="HEIGHT:10px;">
							  <input class="mandtxtbox" type="hidden" name="updateddatetime" id="updateddatetime" value="<%=updateddatetime%>" size="24">
							  </td>
							  <td class="Font8vB">
							  Date :&nbsp;
							  <input class="mandtxtbox" type="text" name="createddate" id="createddate" value="<%=createddate%>" onfocus="blur();" size="12"></td>							  
                            </tr>
                            <tr>
                              <td class="grdback">Registration No. : <font class="Font8vRed">*</font></td>
                              <td colspan="2">
							  	<input class="mandtxtbox" type="text" name="regnno" id="regnno" maxlength="12" value="<%=regnno%>" size="12" onKeyUp="javascript:if(window.event.keyCode==13){document.frmOPD.stafffree.focus();}"/>
								<input class="mandtxtbox" type="button" name="Show" value="Go" onClick="DoSubmitShow();">								
							  </td>
							  <td>&nbsp;</td>
                              <%
							  if(patientphoto==null){patientphoto="";}
							  if(patientphoto.length()==0){%>
							  <td rowspan="4" id="ptPhotoShow" style="width:100px;height:120px;">&nbsp;
							  <%}else{%>
							  <td rowspan="4" id="ptPhotoShow" style="width:100px;height:120px;"><img src="../empphoto/<%=patientphoto%>" width="100px" height="120px" border="0">
							  <%}%>							  
							  </td>
                            </tr>
							<tr>
                              <td class="grdback">Old/New (O/N) ? : <font class="Font8vRed">*</font></td>
                              <td>
							  	<input class="mandtxtbox" type="text" name="oldnew" id="oldnew" maxlength="1" value="<%=oldnew%>" size="3" onKeyUp="javascript:HideUnhideRegno(this.value);makeUppercase(this);"/>							  
							  </td>
                              <td>&nbsp;</td>
							  <td>&nbsp;</td>
                            </tr>
							<tr>
                              <td class="grdback">Staff/Free (S/F) ? : </td>
                              <td>
							  	<input class="mandtxtbox" type="text" name="stafffree" id="stafffree" size="3" maxlength="1" value="<%=stafffree%>" onKeyUp="javascript:HideUnhideEmpCode(this.value);makeUppercase(this);"/>
							  </td>
                              <td>&nbsp;</td>
							  <td>&nbsp;</td>
                            </tr>
                            <tr>
                              <td class="grdback">Employee Code : </td>
                              <td class="Font8v" nowrap colspan="1">
                               <input class="mandtxtbox" type="text" name="empcode" id="empcode" size="10" maxlength="12" value="<%=empcode%>" onKeyUp="javascript: ajaxFunctionEmpCode();ajaxFunctionEmpObjid();if(window.event.keyCode==13){if(this.value.length==0){alert('Please enter Emp code');this.focus();}else{document.frmOPD.patientname.focus();}}" />
							   <input class="mandtxtbox" type="hidden" name="empobjid" id="empobjid" maxlength="12" value="<%=empobjid%>"/>
                              </td>
							  <td class="Font8v" nowrap id="EmpName" colspan="2"><%=empname%></td>
                            </tr>							
							<tr>
                              <td class="grdback">Patient Name : <font class="Font8vRed">*</font></td>
                              <td class="Font8v" nowrap colspan="3">
							  	<input class="mandtxtbox" type="text" name="patientname" size="30" id="patientname" maxlength="32" value="<%=patientname%>" onKeyUp="javascript:makeUppercase(this);if(window.event.keyCode==13){document.frmOPD.patstate.focus();if(document.frmOPD.empobjid.value.length>0){ShowPatientWindow(document.frmOPD.empobjid.value);}else if(document.frmOPD.patientname.value.length==0){alert('Please enter Patient Name');document.frmOPD.patientname.focus();}}"/>
							  </td>
							  <td>&nbsp;</td>
                            </tr>
							<tr>
                              <td class="grdback">State : </td>
                              <td>
							  	<input class="mandtxtbox" type="text" name="patstate" id="patstate" maxlength="12" value="<%=patstate%>" onKeyUp="javascript:makeUppercase(this);if(window.event.keyCode==13){document.frmOPD.patdistrict.focus();}"/>
							  </td>
                              <td class="grdback">Dist. : </td>
                              <td>
							  	<input class="mandtxtbox" type="text" name="patdistrict" id="patdistrict" maxlength="12" value="<%=patdistrict%>" onKeyUp="javascript:makeUppercase(this);if(window.event.keyCode==13){document.frmOPD.patps.focus();}"/>
							  </td>
							  <td>&nbsp;</td>
                            </tr>
							<tr>
                              <td class="grdback">Police Station : </td>
                              <td class="Font8v" nowrap colspan="3">
							  	<input class="mandtxtbox" type="text" name="patps" id="patps" maxlength="12" value="<%=patps%>" onKeyUp="javascript:makeUppercase(this);if(window.event.keyCode==13){document.frmOPD.patageyrs.focus();}"/>
							  </td>
							  <td>&nbsp;</td>
                            </tr>
							<tr>
                              <td class="grdback" valign="top">Age (Yr/Mt/Dy) : <font class="Font8vRed">*</font></td>
                              <td colspan="3" nowrap class="Font8v">
							  	<input class="mandtxtbox" type="hidden" name="ptdob" id="ptdob" size="12" maxlength="12" value=""/>
                                
							  	<input class="mandtxtbox" type="text" name="patageyrs" id="patageyrs" size="2" maxlength="2" value="<%=patageyrs%>" onKeyUp="javascript:if(window.event.keyCode==13){document.frmOPD.patagemts.focus();}"/>&nbsp;&nbsp;Yrs&nbsp;&nbsp;
                                <input class="mandtxtbox" type="text" name="patagemts" id="patagemts" size="2" maxlength="2" value="<%=patagemts%>" onKeyUp="javascript:if(window.event.keyCode==13){document.frmOPD.patageday.focus();}"/>&nbsp;&nbsp;Mts&nbsp;&nbsp;
                                <input class="mandtxtbox" type="text" name="patageday" id="patageday" size="2" maxlength="2" value="<%=patageday%>" onKeyUp="javascript:if(window.event.keyCode==13){document.frmOPD.patsex.focus();}"/>&nbsp;&nbsp;Day
							  </td>
							  <td>&nbsp;</td>
                            </tr>
                            <tr>
                              <td class="grdback" valign="top">Sex (M/F) : <font class="Font8vRed">*</font></td>
                              <td colspan="3">
							  	<input value="<%=patsex%>" type="text" size="2" maxlength="1" name="patsex" class="mandtxtbox" onKeyUp="javascript:makeUppercase(this);if(window.event.keyCode==13){document.frmOPD.doctorcode.focus();}">
                              </td>
							  <td>&nbsp;</td>
                            </tr>
                            <tr>
                              <td class="grdback" valign="top">Doctor Code : <font class="Font8vRed">*</font></td>
                              <td>
							  	<input class="mandtxtbox" type="text" name="doctorcode" id="doctorcode" size="10" maxlength="12" value="<%=dcode%>" onKeyUp="javascript:if(window.event.keyCode==13){ShowDoctorCode();}"/>
								<input class="mandtxtbox" type="hidden" name="doctorobjid" id="doctorobjid" size="10" maxlength="12" value="<%=doctorobjid%>"/>
							  </td>
							  <td class="Font8v" nowrap id="DoctorName" colspan="3"><%=dname%></td>
                            </tr>
                            <tr>
                              <td colspan="5" style="HEIGHT:5px;"></td>
                            </tr>
                            <tr>
                              <td colspan="5" style="HEIGHT:10px;" align="center">
                              	<input class="mandtxtbox" type="button" name="btnAdd" value=" Add " onClick="DoSubmitAction('Add')" <%if(objid != null && printstatus.equals("N")){%> disabled<%}%>>
								<input class="mandtxtbox" type="button" name="btnUpdate" value="Update" onClick="DoSubmitAction('Update')" <%if(objid == null || printstatus.equals("Y")){%> disabled<%}%>>
								<input class="mandtxtbox" type="button" name="btnCancel" value="Cancel"  onClick="DoSubmitAction('Cancel');">
								<%if(!UserRole.equals("2")){%>
								<input class="mandtxtbox" type="button" name="btnDelete" value="Delete" onClick="DoSubmitAction('Delete')" <%if(objid == null){%> disabled<%}%>>
								<%}%>								
								<input class="mandtxtbox" type="button" name="btnPrint" value="Print"  onClick="DoSubmitPrint();" <%if(objid == null){%>disabled<%}%>>
								<input class="mandtxtbox" type="hidden" name="objid" id="objid" value="<%=objid%>">
								<input class="mandtxtbox" type="hidden" name="formAction" value="">
								<input class="mandtxtbox" type="hidden" name="patientphoto" id="patientphoto" value="<%=patientphoto%>">
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
		  <td style="HEIGHT:10px;"></td>
		</tr>
    </table>
    <script language="JavaScript">	
		function DoSubmitPrint(){
			if(document.frmOPD.objid.value.length==0){
				alert("Please select a Patient to Print");
				return;			
			}
			var mURL = "OpdRegistrationPrint.jsp?code=" + document.frmOPD.objid.value;
			var newwindow;
			newwindow=window.open(mURL,'name','height=300,width=700,left=200,top=200');
 			if (window.focus){newwindow.focus()}
		}
		
		function DoSubmitShow(){
			var mURL = "OpdRegistration.jsp?go=1&regno=" + document.frmOPD.regnno.value;
			location.href=mURL;			
		}
	</script>	
	<!--START DISPLAYING DOCTOR CODE -->
	<script language="javascript">
		function ShowDoctorCode(){
			setVisibility('DOCTOR','inline');
		}		
		function SetDoctorData(mdc,mdnm,mdobjid){
			//alert("mdc=="+mdc+"==mdnm=="+mdnm);
			document.frmOPD.doctorcode.value=document.getElementById(mdc).innerText;
			document.getElementById("DoctorName").innerHTML=document.getElementById(mdnm).innerText;
			document.frmOPD.doctorobjid.value=mdobjid;
			setVisibility('DOCTOR','none');
		}
	</script>
    <div id="DOCTOR" style="background:#CCCCCC;position: absolute;left: 400px;top: 200px;width: 300px;padding: 5px;color: black;border: #0000cc 2px solid;display: none;">
    <table width="100%" border="0" cellpadding="1" cellspacing="1">
      <tr>
      	<td colspan="3">
        	<table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
			:: SELECT DOCTOR ::
        		</td>
                <td background="../images/menu_head_m.gif" width="10px">
                	<img src="../images/icoDel.gif" onClick="javascript:setVisibility('DOCTOR','none');">
                </td>
              </tr>
            </table>
          </td>
      </tr>
      <tr>
      	<td class="grdback">Action</td>
        <td class="grdback">Code</td>
        <td class="grdback">Name</td>
      </tr>
      <%
	  	doctor.Connect();
		int i=1;
		ResultSet docRS  = doctor.listDoctorById(null);
		try{
			while(docRS.next()){
			String mdobjid = docRS.getString("objid");			
			if(i%2==0){%>
             <TR onMouseOver="this.className='selected'" onMouseOut="this.className='treven'" class="treven">
			<%}else{%>
            <TR onMouseOver="this.className='selected'" onMouseOut="this.className='trodd'" class="trodd">
            <%}%>
            	<td class="Font8v">
                <img src="../images/critical.gif" border="0" onClick="SetDoctorData('dc<%=i%>','dnm<%=i%>','<%=mdobjid%>');">
                </td>
                <td class="Font8v" id="dc<%=i%>"><%=docRS.getString("dcode")%></td>
                <td class="Font8v" id="dnm<%=i%>"><%=docRS.getString("dnamef")%> &nbsp;<%=docRS.getString("dnamel")%>&nbsp;<%=docRS.getString("dnamem")%>                
                </td>
              </tr>
            <%
			i++;
			}
			docRS.close();
			doctor.DisConnect();
		}catch(Exception e){}
		%>        
    </table>
    </div>
    <!--END DISPLAYING DOCTOR CODE -->	
</form>
</BODY>
</HTML>
