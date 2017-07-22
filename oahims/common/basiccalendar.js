function buildCal(m, y, cM, cH, cDW, cD, brdr){
	var mn=['January','February','March','April','May','June','July','August','September','October','November','December'];
	var dim=[31,0,31,30,31,30,31,31,30,31,30,31];
	
	var oD = new Date(y, m-1, 1); //DD replaced line to fix date bug when current day is 31st
	oD.od=oD.getDay()+1; //DD replaced line to fix date bug when current day is 31st
	
	var todaydate=new Date() //DD added
	var scanfortoday=(y==todaydate.getFullYear() && m==todaydate.getMonth()+1)? todaydate.getDate() : 0 //DD added
	var runM  = todaydate.getMonth()*1+1;
	var runY  = todaydate.getFullYear();
	dim[1]=(((oD.getFullYear()%100!=0)&&(oD.getFullYear()%4==0))||(oD.getFullYear()%400==0))?29:28;
	
	var t='<div class="'+cM+'"><table cellpadding="1" cellspacing="1" class="'+cM+'" cols="7" cellpadding="0" border="'+brdr+'" cellspacing="0"><tr align="center">';
	t+='<td colspan="7" align="center" background="../images/menu_head_m.gif" class="'+cH+'">'+mn[m-1]+' - '+y+'</td></tr><tr align="center">';
	for(s=0;s<21;s+=3){
		if(s==0){cDW="weekend";}else{cDW="daysofweek";}
		t+='<td class="'+cDW+'"><strong>'+"SUNMONTUEWEDTHUFRISAT".substr(s,3)+'</strong></td>';
	}
	
	t+='</tr><tr align="center">';
	var bgColorS = ' bgcolor="#66FF99"';
	var bgColorL = ' bgcolor="#FFCACA"';
	var bgColorA = ' bgcolor="#9999FF"';
	for(i=1;i<=42;i++){
		var x=((i-oD.od>=0)&&(i-oD.od<dim[m-1]))? i-oD.od+1 : '&nbsp;';		
		if(i%7==1){cD="weekend";}else{cD="weekdays";}
		var fnc = ' onClick="alert(this.value);"';
		//alert(<%=checkDoctorScheduleAndLeaveId(doctorobjid,)%>);
		if(x != "&nbsp;"){
			if(x<scanfortoday || (m<runM && y<=runY)){//DD added
				t+='<td><table border=0 cellpadding=1 cellspacing=1 width="100%"1><tr>';
				t+='<td class="'+cD+'" style="width:20px;" align="right">'+x+'</td><td'+bgColorS+'><input type="checkbox" name="chkSchedule"';
				t+=' value="'+x+'" disabled></td><td'+bgColorL+'><input type="checkbox" name="chkLeave" value="'+x+'" disabled></td><td'+bgColorA+'>';
				t+='<input type="checkbox" name="chkAttend" value="'+x+'" disabled></td></td></tr>';
				t+='<tr><td colspan="2"'+bgColorS+'><input type="hidden" class="mandtxtbox" name="fromTime" size="5" maxlength="5" disabled></td><td colspan="2"'+bgColorS+'><input type="hidden" class="mandtxtbox" name="fromTime" size="5" disabled></td></tr>';
				t+='</table></td>';
			}else if(x==scanfortoday){//DD added			
				t+='<td><table border=0 cellpadding=1 cellspacing=1 width="100%"><tr><td style="width:20px;" align="right" bgcolor="#ff0000">';
				t+='<font class="Font9vWBh">'+x+'</font></td><td'+bgColorS+'><input type="checkbox" name="chkSchedule" value="'+x+'">';
				t+='</td><td'+bgColorL+'><input type="checkbox" name="chkLeave" value="'+x+'" checked=true></td><td'+bgColorA+'>';
				t+='<input type="checkbox" name="chkAttend" value="'+x+'"></td></tr>';
				t+='<tr><td colspan="2"'+bgColorS+'><input type="hidden" class="mandtxtbox" name="fromTime" size="5" maxlength="5"></td><td colspan="2"'+bgColorS+'><input type="hidden" class="mandtxtbox" name="fromTime" size="5"></td></tr>';
				t+='</table></td>';
			}else{ //DD added			
				t+='<td><table border=0 cellpadding=1 cellspacing=1 width="100%"1><tr>';
				t+='<td class="'+cD+'" style="width:20px;" align="right">'+x+'</td><td'+bgColorS+'><input type="checkbox" name="chkSchedule"';
				t+=' value="'+x+'"></td><td'+bgColorL+'><input type="checkbox" name="chkLeave" value="'+x+'"></td><td'+bgColorA+'>';
				t+='<input type="checkbox" name="chkAttend" value="'+x+'"></td></td></tr>';
				t+='<tr><td colspan="2"'+bgColorS+'><input type="hidden" class="mandtxtbox" name="fromTime" size="5" maxlength="5"></td><td colspan="2"'+bgColorS+'><input type="hidden" class="mandtxtbox" name="fromTime" size="5"></td></tr>';
				t+='</table></td>';
			}
		}else{
			t+='<td class="'+cD+'">'+x+'</td>';
		}		
		if(((i)%7==0)&&(i<36))t+='</tr><tr align="center">';		
	}
	//alert("t=="+t );
	return t+='</tr></table></div>';
	
}

