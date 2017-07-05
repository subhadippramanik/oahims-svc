<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,javax.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.util.*"%>

<%@ page import="com.oa.kh.opd.*" %>
<jsp:useBean id="employee" class="com.oa.kh.opd.Employee"/>
<jsp:useBean id="employeerelation" class="com.oa.kh.opd.EmployeeRelationship"/>

<%@ page import="com.oa.kh.utility.*" %>
<jsp:useBean id="apputility" class="com.oa.kh.utility.AppUtility"/>

<html>
<head>
<title>Family Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK media=screen href="../common/Styles.css" type=text/css rel=stylesheet>
<script language="JavaScript">
	function SetFamilyData(mVal,mptdob,ptmf,ptphoto){
		//alert(mVal + "====" + document.getElementById(mVal).innerText);
		var ptNM = document.getElementById(mVal).innerText;
		var ptDOB = document.getElementById(mptdob).innerText;
		var ptSex = document.getElementById(ptmf).innerText;
		var ptphot = document.getElementById(ptphoto).innerText;
		//alert("ptphot==="+ptphot);
		self.opener.document.frmOPD.patientname.value = ptNM;
		self.opener.document.frmOPD.ptdob.value = ptDOB;
		self.opener.document.frmOPD.patsex.value=ptSex;
		self.opener.document.frmOPD.patientphoto.value=ptphot;
		//alert("ptphot==="+ptDOB.substr(0,2) +"==="+ptDOB.substr(3,2)+"==="+ptDOB.substr(6,4));
		self.opener.document.frmOPD.patageyrs.value=calage(ptDOB.substr(0,2),ptDOB.substr(3,2),ptDOB.substr(6,4),"y");
		self.opener.document.frmOPD.patagemts.value=calage(ptDOB.substr(0,2),ptDOB.substr(3,2),ptDOB.substr(6,4),"m");
		self.opener.document.frmOPD.patageday.value=calage(ptDOB.substr(0,2),ptDOB.substr(3,2),ptDOB.substr(6,4),"d");
		
		self.opener.document.getElementById("ptPhotoShow").innerHTML="<img src='../empphoto/"+ptphot+"' width='100' height='120'>";
		//alert("self.opener.document.getElementById(ptphoto).innerHTML==="+self.opener.document.getElementById(ptphoto).innerHTML);
		window.close();
	}

</script>

<script language="javascript">
var startyear = "1950";
var endyear = "2010";
var dat = new Date();

var curday = dat.getDate();
var curmon = dat.getMonth()+1;
var curyear = dat.getFullYear();

function checkleapyear(datea)
{
	if(datea.getYear()%4 == 0)
	{
		if(datea.getYear()% 10 != 0)
		{
			return true;
		}
		else
		{
			if(datea.getYear()% 400 == 0)
				return true;
			else
				return false;
		}
	}
return false;
}
function DaysInMonth(Y, M) {
    with (new Date(Y, M, 1, 12)) {
        setDate(0);
        return getDate();
    }
}
function datediff(date1, date2) {
    var y1 = date1.getFullYear(), m1 = date1.getMonth(), d1 = date1.getDate(),
	 y2 = date2.getFullYear(), m2 = date2.getMonth(), d2 = date2.getDate();

    if (d1 < d2) {
        m1--;
        d1 += DaysInMonth(y2, m2);
    }
    if (m1 < m2) {
        y1--;
        m1 += 12;
    }
    return [y1 - y2, m1 - m2, d1 - d2];
}

function calage(calmon,calday,calyear,mtype)
{
	if(curday == "" || curmon=="" || curyear=="" || calday=="" || calmon=="" || calyear=="")
	{
		alert("please fill all the values and click go -");
	}	
	else
	{
		var curd = new Date(curyear,curmon-1,curday);
		var cald = new Date(calyear,calmon-1,calday);
		
		var diff =  Date.UTC(curyear,curmon,curday,0,0,0) - Date.UTC(calyear,calmon,calday,0,0,0);

		var dife = datediff(curd,cald);
		if(mtype=="d")
			return dife[2];
		if(mtype=="m")
			return dife[1];
		if(mtype=="y")
			return dife[0];	
		//return dife[0]+" years, "+dife[1]+" months, and "+dife[2]+" days";
		
	}
}


function setVisibility(id, visibility) {
	document.getElementById(id).style.display = visibility;
}

function ShowDoctorCode(mValImg){
	setVisibility('FAMILY','inline');
	//alert(mValImg);
	document.getElementById("imgSel").innerHTML = "<img src='"+mValImg+"' width='100px' height='120px'>";
}	
</script>
</head>
<body topmargin="20px">
<table width="100%" border="0" cellpadding="1" cellspacing="1">
      <tr>
      	<td colspan="6">
        	<table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="Font8vB" background="../images/menu_head_m.gif" align="center" style="HEIGHT:30px">        	
					:: SELECT PATIENT ::
        		</td>
                <td background="../images/menu_head_m.gif" width="10px">
                	<img src="../images/icoDel.gif" onClick="javascript:self.close();">
                </td>
              </tr>
            </table>
          </td>
      </tr>	
	  <tr>
		<td class="grdback">Action</td>
		<td class="grdback">Name</td>
		<td class="grdback">Age</td>
		<td class="grdback">Relationship</td>
		<td class="grdback">Sex</td>
		<td class="grdback">Photo</td>
	  </tr>
		<%
		String empcode ="",retStr="";
		int objid=0,i=1;
		String ptNM="",ptAge="",ptRel="",ptSex="",ptPhoto="";
		System.out.println("retStr 1====" + retStr);
		
		if(request.getParameter("code")!=null){
			empcode = request.getParameter("code");
			//System.out.println("Type 1====" + request.getParameter("type"));
			//DISPLAY EMPLOYEE INFORMATION FIRST
			ResultSet emprelRS = null;
			employee.Connect();
			try{
				emprelRS = employee.listEmployeeById(empcode);
				while(emprelRS.next()){
					ptNM = emprelRS.getString("empnamef") + " " + emprelRS.getString("empnamem") + " " + emprelRS.getString("empnamel");
					ptAge = apputility.ChangeDateFormatToDisplay(emprelRS.getString("empdob"));
					ptRel = "SELF";
					ptSex = emprelRS.getString("empsex");
					ptPhoto = emprelRS.getString("empphoto");
					if(i%2==0){%>
					<TR onMouseOver="this.className='selected';ShowDoctorCode('../empphoto/<%=ptPhoto%>');" onMouseOut="this.className='treven';setVisibility('FAMILY','none');" class="treven">
					<%}else{%>
					<TR onMouseOver="this.className='selected';ShowDoctorCode('../empphoto/<%=ptPhoto%>');" onMouseOut="this.className='trodd';setVisibility('FAMILY','none');" class="trodd">
					<%}%>
						<td class="Font8v"><img src="../images/critical.gif" border="0" onClick="javascript:SetFamilyData('ptr<%=i%>','mdob<%=i%>','ptmf<%=i%>','ptphoto<%=i%>');"></td>
						<td class="Font8v" id='ptr<%=i%>'><%=ptNM%></td>
						<td class="Font8v" id='mdob<%=i%>'><%=ptAge%></td>
						<td class="Font8v"><%=ptRel%></td>
						<td class="Font8v" id="ptmf<%=i%>"><%=ptSex%></td>
						<td class="Font8v" id="ptphoto<%=i%>"><%=ptPhoto%></td>
					</tr>
					<%
					i++;
				}
			}catch(Exception e){}
			emprelRS.close();
			employee.DisConnect();
			//DISPLAY EMPLOYEE DEPENDENT THEN
			employeerelation.Connect();	
			try{
				emprelRS = employeerelation.listEmployeeRelationshipById(empcode);
				while(emprelRS.next()){
					ptNM = emprelRS.getString("emprelname");
					ptAge = apputility.ChangeDateFormatToDisplay(emprelRS.getString("empreldob"));
					ptRel = emprelRS.getString("emprelationship");
					ptSex = emprelRS.getString("emprelsex");
					ptPhoto = emprelRS.getString("emprelphoto");
					if(i%2==0){%>
					<TR onMouseOver="this.className='selected';ShowDoctorCode('../empphoto/<%=ptPhoto%>');" onMouseOut="this.className='treven';setVisibility('FAMILY','none');" class="treven" >
					<%}else{%>
					<TR onMouseOver="this.className='selected';ShowDoctorCode('../empphoto/<%=ptPhoto%>');" onMouseOut="this.className='trodd';setVisibility('FAMILY','none');" class="trodd">
					<%}%>
						<td class="Font8v"><img src="../images/critical.gif" border="0" onClick="javascript:SetFamilyData('ptr<%=i%>','mdob<%=i%>','ptmf<%=i%>','ptphoto<%=i%>');"></td>
						<td class="Font8v" id='ptr<%=i%>'><%=ptNM%></td>
						<td class="Font8v" id='mdob<%=i%>'><%=ptAge%></td>
						<td class="Font8v"><%=ptRel%></td>
						<td class="Font8v" id="ptmf<%=i%>"><%=ptSex%></td>
						<td class="Font8v" id="ptphoto<%=i%>"><%=ptPhoto%></td>
					</tr>
					<%
					i++;
				}
				System.out.println("retStr 2====" + retStr.trim());
				emprelRS.close();		
				employeerelation.DisConnect();	
			}catch(Exception e){}	
		}
		%>
	</table>    
    <div id="FAMILY" style="background:#CCCCCC;position: absolute;left: 270px;top: 100px;width: 100px;padding: 5px;color: black;border: #0000cc 2px solid;display: none;">
    	<table border="1">
          <tr>
            <td id="imgSel" style="width:100px;height:120px;">&nbsp;</td>
          </tr>
        </table>
    </div>
    
</body>
</HTML>




