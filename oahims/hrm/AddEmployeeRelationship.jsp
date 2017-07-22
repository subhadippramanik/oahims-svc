<%@ page contentType="text/html; charset=ISO-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
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
String UserNM = null, UserRole  = null ;
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
String empobjid = "",emprelationship  = "",emprelname = "",empreldob = "", emprelsex = "",emprelphoto = "",isactive = "",byuser = UserNM;
String comboVal = "";
String empcodeG="",empnameG="";


if(request.getParameter("formAction")!=null){
    String formAction=request.getParameter("formAction");

    /*   Doctor's Details */
	empobjid = request.getParameter("empobjid").trim();	
	String strAllData = request.getParameter("formListValue");
	System.out.println("empobjid==="+empobjid+"===="+strAllData.indexOf("#"));
	
	
	int arrLen = 0;
	String [] temp = new String[5];	
		
	try{
		if(strAllData.indexOf("#")>0){		
			temp = strAllData.split("#");	
			arrLen = temp.length;
			System.out.println("temp.length 3==="+arrLen);		
		}else{
			temp[0] = strAllData ;
		}
	}catch(Exception e){
		   System.out.println("temp.length 4==="+arrLen);
		   e.printStackTrace();
	}
	
	
    employeerelation.Connect();
    // For perform Actions based on Request 
      if(formAction.equals("Add"))
      	{
            if(arrLen>0){
				for(int k=0;k<arrLen;k++){				
					employeerelation.addEmployeeRelationship(temp[k] + ",'" + UserNM + "'");				
				}
			}else{
				employeerelation.addEmployeeRelationship(strAllData + ",'" + UserNM + "'");	
			}
     	}

     if(formAction.equals("Delete"))
          {
               	int no=0;
               	no=employeerelation.deleteEmployeeRelationship(empobjid);
           		if(no!=0){
               		%><center><h2>Successfully data Deleted</h2></center><%
          		}else{
             		%><center><h2>Unable to Delete.Because there is no data with <%=objid%> </h2></center><% 
                }
       }

     if(formAction.equals("Update"))
          {
               int no=0;
			   no = employeerelation.deleteEmployeeRelationship(empobjid);
			   if(arrLen>0){
				   for(int k=0;k<arrLen;k++){				
						no=employeerelation.updateEmployeeRelationship(temp[k] + ",'" + UserNM + "'",empobjid);
				   }
				}else{
					no=employeerelation.updateEmployeeRelationship(strAllData + ",'" + UserNM + "'",empobjid);
				}
       }
      
    employeerelation.DisConnect();
}

//**********************************************************************
if(request.getParameter("id")!=null){
	AppUtility appUtility = new AppUtility();
	
	String addedValue = "",addedText = "";
	objid = request.getParameter("id");
	employeerelation.Connect();	
	try{
		ResultSet tempRs = employeerelation.listEmployeeRelationshipById(objid);
		while(tempRs.next()){
			objid = tempRs.getString("objid");
			empobjid = tempRs.getString("empobjid");;			
			emprelationship = tempRs.getString("emprelationship");
			emprelname = tempRs.getString("emprelname");
			empreldob = tempRs.getString("empreldob");
			emprelsex = tempRs.getString("emprelsex");
			emprelphoto = tempRs.getString("emprelphoto");
			isactive = tempRs.getString("isactive");
			
			addedValue = "'" + empobjid + "','"
										+ emprelationship + "','"
										+ emprelname.toUpperCase() + "','"
										+ appUtility.ChangeDateFormatToMySQL(empreldob) + "','"
										+ emprelsex + "','"
										+ emprelphoto + "','"										
										+ isactive + "'";			

			addedText =  emprelationship + " | "
									+ emprelname.toUpperCase() + " | "
									+ appUtility.ChangeDateFormatToMySQL(empreldob) + " | "
									+ emprelsex + " | "
									+ emprelphoto + " | "
									+ isactive;

			comboVal += "<OPTION value=\"" + addedValue + "\" >" + addedText + "</OPTION>";
			
		}
		tempRs.close();
		employeerelation.DisConnect();
	}catch(Exception e){}
	
	try{	
		//GETTING EMPLOYEE INFORMATION
		employee.Connect();	
		ResultSet empRS = employee.listEmployeeById(empobjid);
		while(empRS.next()){			 
		 empcodeG = empRS.getString("empcode");
		 empnameG = empRS.getString("empnamef") + " " + empRS.getString("empnamem") + " " + empRS.getString("empnamel");
		 System.out.println("From JSp Page===" + empcodeG + "======empnameG===" + empnameG);
		 }
		empRS.close();
		employee.DisConnect();
	}catch(Exception e){}
}
%>
<HTML lang=en>
<HEAD><TITLE>SISL Tab </TITLE>
<META http-equiv=Content-Type content="text/html; charset=ISO-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
<script language="javascript">
	function DoSubmitAction(mAction){
		document.frmEmployeeRelation.formAction.value = mAction;
		//alert("mAction====" +mAction);	
		//empobjid,emprelationship,emprelname,empreldob,emprelsex,isactive
		var frm = document.frmEmployeeRelation;
		if(mAction == 'INCLUDE')
		{	
			var empobjid=frm.empobjid.value;
			if(empobjid.length == 0){
				alert("Please enter Employee Code to proceed..");
				return false;
			}
			var emprelationship=frm.emprelationship.value;
			if(emprelationship.length == 0){
				alert("Please select Relationship with Employee..");
				return false;
			}
			var emprelname=frm.emprelname.value;
			if(emprelname.length == 0){
				alert("Please enter " + frm.emprelationship.value + " Name..");
				return false;
			}
			var empreldob=frm.empreldob.value;
			if(empreldob.length == 0){
				alert("Please enter " + frm.emprelationship.value + " DOB..");
				return false;
			}
			var emprelsex=frm.emprelsex.value;
			if(emprelsex.length == 0){
				alert("Please enter " + frm.emprelationship.value + " Sex..");
				return false;
			}			
			var mYes=confirm("Are you sure to add this record ?");
			if(mYes==false)
			{
				return false;
			}
			var defaultSelected = true;
			var selected = true;
			//alert("frm.selectedRecord.value==="+frm.selectedRecord.value);
			if(frm.selectedRecord.value.length>0){
				var Current = frm.cmbAddedFamilyMember.selectedIndex;
				frm.selectedRecord.value = ""
				if(Current < 0) return false;
				frm.cmbAddedFamilyMember.options[Current] = null;
			}
			//empobjid,emprelationship,emprelname,empreldob,emprelsex,isactive
			//alert("ok");
			var addedValue = frm.empobjid.value + ",'"
											+ frm.emprelationship.value + "','" + frm.emprelname.value.toUpperCase() + "','"
											+ frm.empreldob.value + "','" + frm.emprelsex.value + "','"
											 + frm.emprelphoto.value + "','"
											+ frm.isactive.value + "'";
	
			addedValue = addedValue.replace(/,,/g, ",NULL,");
			addedValue = addedValue.replace(/,,/g, ",NULL,");
			//alert("addedValue==" + addedValue);
			var addedText = frm.emprelationship.value + " | "
											+ frm.emprelname.value.toUpperCase()	+ " | "
											+ frm.empreldob.value + " | "
											+ frm.emprelsex.value + " | "
											+ frm.emprelphoto.value + " | "
											+ frm.isactive.value;
			//alert("addedText==" + addedText);
			var length = frm.cmbAddedFamilyMember.length;
			var optionName = new Option(addedText, addedValue, defaultSelected, selected);
			frm.cmbAddedFamilyMember.options[length] = optionName;
			frm.selectedRecord.value = "";
			cleanUPForm();
	
			return false;
		}
	
		if(mAction == 'REMOVE')
		{
			var lengthDel = frm.cmbAddedFamilyMember.length;
			if(lengthDel == 0){
				alert("Nothing is there in the List to DELETE....");
				return false;
			}
			if (frm.cmbAddedFamilyMember.selectedIndex == -1)
			{
				alert('Please select a record to DELETE....');
				return false;
			}
			var mYes=confirm("Are you sure to delete ?");
			if(mYes==false) return false;
	
			var Current = frm.cmbAddedFamilyMember.selectedIndex;
			frm.selectedRecord.value = ""
			if(Current < 0) return false;
			frm.cmbAddedFamilyMember.options[Current] = null;
	
			return false;
		}
		
		//empobjid,emprelationship,emprelname,empreldob,emprelsex,isactive
		if(mAction=="Add"){
			var empobjid=frm.empobjid.value;
			if(empobjid.length == 0){
				alert("Please enter Employee Code to proceed..");
				return false;
			}
			var getAllValue = "";
			var optLen = frm.cmbAddedFamilyMember.options.length;
			for(var i=0;i<optLen;i++){
				if(i<optLen-1)
					getAllValue += frm.cmbAddedFamilyMember.options[i].value + "#";
				else
					getAllValue += frm.cmbAddedFamilyMember.options[i].value;
			}
			frm.formListValue.value	= getAllValue;	
		}
		if(mAction=="Update"){
			var objid=frm.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a Employee to Update....");
				frm.dcode.focus();
				return false;
			}	
			var getAllValue = "";
			var optLen = frm.cmbAddedFamilyMember.options.length;
			for(var i=0;i<optLen;i++){
				if(i<optLen-1)
					getAllValue += frm.cmbAddedFamilyMember.options[i].value + "#";
				else
					getAllValue += frm.cmbAddedFamilyMember.options[i].value;
			}
			frm.formListValue.value	= getAllValue;
		}
		
		if(mAction=="Delete"){
			var objid=frm.objid.value;
			if(objid=="" || objid.length==0){
				alert("Please select a Employee to Delete....");
				frm.dcode.focus();
				return false;
			}
		}
		
		if(mAction=="Cancel"){	
			location.href="AddEmployeeRelationship.jsp";		
		}
		
		frm.submit();
		return true;
	}
	
	//On scrolling of DIV tag.
	function OnDivScroll()
	{
	  var cmbMapUserList = document.getElementById("cmbAddedFamilyMember");
	  if (cmbMapUserList.options.length > 10)
	  {
		  cmbMapUserList.size=cmbMapUserList.options.length;
	  }
	  else
	  {
		  cmbMapUserList.size=10;
	  }
	}
	//On focus of Selectbox
	function OnSelectFocus()
	{
	  if (document.getElementById("divUserDtls").scrollLeft != 0)
	  {
		  document.getElementById("divUserDtls").scrollLeft = 0;
	  }
	
	  var cmbMapUserList = document.getElementById('cmbAddedFamilyMember');
	  if( cmbMapUserList.options.length > 10)
	  {
		  cmbMapUserList.focus();
		  cmbMapUserList.size=10;
	  }
	}
	
	function setDetails(detailStr, detailVal)
	{
		var dtlArray,userMapID;
		dtlArray = detailStr.split("|");
		userMapID = detailVal.split(",");
		var frm = document.frmEmployeeRelation;
		frm.selectedRecord.value = frm.cmbAddedFamilyMember.selectedIndex;
		//empobjid,emprelationship,emprelname,empreldob,emprelsex,isactive
		frm.emprelationship.value = trim(dtlArray[0]);
		frm.emprelname.value = trim(dtlArray[1]);
		frm.empreldob.value = trim(dtlArray[2]);
		frm.emprelsex.value = trim(dtlArray[3]);
		frm.emprelphoto.value = trim(dtlArray[4]);
		document.getElementById("SelectedPhoto").innerHTML="<img src='../empphoto/"+trim(dtlArray[4])+"' width='100px' height='120px'>";		
		frm.isactive.value = trim(dtlArray[5]);
			
		frm.selectedRecord.value="--";
	}
	
	function cleanUPForm()
	{
		var frm = document.frmEmployeeRelation;
		frm.emprelationship.value = "";
		frm.emprelname.value = "";
		frm.empreldob.value = "";
		frm.emprelsex.value = "";
		frm.emprelphoto.value = "";
		frm.isactive.value = "";
	}
	function trim(stringToTrim) {
		return stringToTrim.replace(/^\s+|\s+$/g,"");
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
				document.getElementById("EmpNM").innerHTML = mret;
        	}
      	} //txtPwd,txtUserId
    	xmlHttp.open("GET","EmployeeInformation.jsp?type=1&code=" + document.frmEmployeeRelation.empcode.value,true);
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
    	xmlHttp.open("GET","EmployeeInformation.jsp?type=2&code=" + document.frmEmployeeRelation.empcode.value,true);
    	xmlHttp.send(null);
	}
</script>
<SCRIPT language=JavaScript src="../common/date_picker.js"></SCRIPT>
</HEAD>
<BODY topmargin="5px"  onLoad="document.frmEmployeeRelation.empcode.focus();">
<form name="frmEmployeeRelation" method="post" action="AddEmployeeRelationship.jsp">
	<table width="650" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
			:: EMPLOYEE FAMILY MEMBER ENTRY ::
        </td>
      </tr>
      <tr>
        <td class="Font8vB">&nbsp;        	
			
        </td>
      </tr>
      <tr>
        <td>  
        	<table border="0" cellpadding="0" cellspacing="0" width="100%">
            	<tr>
                	<td style="BORDER-BOTTOM: #c3d5ff 0PX SOLID;WIDTH:120px;HEIGHT:33px" 
                    		background="../images/tabs_on.gif" class="Font7vB" >&nbsp;&nbsp;FAMILY MEMBER</td> 
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
                              <td class="grdback" width="30%">Employee Code : <font class="Font8vRed">*</font></td>
                              <td>
							  	<input class="mandtxtbox" type="text" name="empcode" id="empcode"  size="8"
							  		maxlength="12" value="<%=empcodeG%>" onKeyUp="ajaxFunctionEmpCode();ajaxFunctionEmpObjid();"/>
                              	<input class="mandtxtbox" type="hidden" name="empobjid" id="empobjid" size="3" maxlength="12" value="<%=empobjid%>"/>      
                              </td>
                              <td colspan="2" id="EmpNM" class="Font8vB"><%=empnameG%></td>
                            </tr>
							<tr>
								<td colspan="4">
									<table width="100%" border="0" cellspacing="3" cellpadding="1">
									  	<tr>
                                            <td colspan="6" style="HEIGHT:5px;" class="Font8vB">Family Member Information :</td>											
                                        </tr>
                                      	<tr>
											<td class="grdback">Relation</td>
											<td class="grdback">Name</td>
                                            <td class="grdback">DOB</td>
											<td class="grdback">Sex</td>
											<td class="grdback">Photo</td>
                                            <td class="grdback">Active?</td>											
									  	</tr>
                                        <tr>
											<td>
                                            <select name="emprelationship" class="mandtxtbox">
                                                <%if(emprelationship=="FATHER"){%>
                                                <option value="FATHER" selected>FATHER</option>
                                                <%}else{%>
                                                <option value="FATHER">FATHER</option>
                                                <%}%>
                                                <%if(emprelationship=="MOTHER"){%>
                                                <option value="MOTHER" selected>MOTHER</option>
                                                <%}else{%>
                                                <option value="MOTHER">MOTHER</option>
                                                <%}%>
                                                <%if(emprelationship=="CHILD"){%>
                                                <option value="CHILD" selected>CHILD</option>
                                                <%}else{%>
                                                <option value="CHILD">CHILD</option>
                                                <%}%>
                                                <%if(emprelationship=="SPOUSE"){%>
                                                <option value="SPOUSE" selected>SPOUSE</option>
                                                <%}else{%>
                                                <option value="SPOUSE">SPOUSE</option>
                                                <%}%>
                                            </select>
                                            </td>
											<td>
                                             <input class="mandtxtbox" name="emprelname" type="text" id="emprelname" size="25" maxlength="52" value="<%=emprelname%>" />
                                            </td>
                                            <td nowrap>
                                            <input class="mandtxtbox" type="text" name="empreldob" id="empreldob" size="12" maxlength="12" value="<%=apputility.ChangeDateFormatToMySQL(empreldob)%>" onFocus="blur();"/>
                                            <A href="javascript:show_calendar('frmEmployeeRelation.empreldob')" onMouseOut="window.status='';return true;" onmouseover="window.status='Date Picker';return true;"><img src="../images/SHOWCAL.GIF" width="18" height="18" border="0"></a>
                                            </td>
											<td>
                                            <select name="emprelsex" class="mandtxtbox">
												<%if(emprelsex=="F"){%>
                                                <option value="M">Male</option>
                                                <option value="F" selected>Female</option>
                                                <%}else{%>
                                                <option value="M" selected>Male</option>
                                                <option value="F">Female</option>
                                                <%}%>
                                            </select>
                                            </td>
											<td>
                                             <input class="mandtxtbox" name="emprelphoto" type="text" id="emprelphoto" size="15" maxlength="32" value="<%=emprelphoto%>" />
                                            </td>
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
									  	</tr>
                                        <tr>
                                            <td colspan="4" style="HEIGHT:5px;" class="Font8vB">
                                            	<input class="mandtxtbox" type="button" name="btnInclude" value="Include"  onClick="DoSubmitAction('INCLUDE');">
												<%if(request.getParameter("selectedRecord")!=null){%>
                                                <input type="hidden" name="selectedRecord" value="<%=request.getParameter("selectedRecord")%>"></input>
                                                <%}else{%>
                                                <input type="hidden" name="selectedRecord" value=""></input>
                                                <%}%>
												<input class="mandtxtbox" type="button" name="btnRemove" value="Remove"  onClick="DoSubmitAction('REMOVE');">                                            
                                            </td>
											<td rowspan="2" width="100px" id="SelectedPhoto" colspan="2" valign="top"></td>
                                        </tr>
									  	<tr>
											<td colspan="4">
                                        		<div id='divUserDtls' style="OVERFLOW: auto; line-height:inherit; WIDTH: 450px;HEIGHT: 150px;" class="scrollStyle" onscroll="OnDivScroll();" >
                                            		<SELECT class="mandtxtbox" NAME="cmbAddedFamilyMember" SIZE="10" style="width=1000px; word-wrap:break-word"
                                                		onfocus="OnSelectFocus();"
                                                		onchange="setDetails(this.options[this.selectedIndex].innerText,this.options[this.selectedIndex].value)">
                                                		<%=comboVal%>
                                            		</SELECT>
                                        		</div>                                        
                                        	</td>
											
									  	</tr>
									</table>
								</td>							
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
                                
                                <input type="hidden" name="formListValue" value="">
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
  </form>
</BODY>
</HTML>
