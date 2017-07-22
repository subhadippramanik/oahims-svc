/*
	Author Name : Sagar Mukherjee
*/
	function Trim(TRIM_VALUE)
	{
		if(TRIM_VALUE.length < 1)
		{
		return"";
		}
		TRIM_VALUE = RTrim(TRIM_VALUE);
		TRIM_VALUE = LTrim(TRIM_VALUE);
		
		if(TRIM_VALUE=="")
		{
			return "";
		}
		else{
			return TRIM_VALUE;
		}
	} //End Function

	function RTrim(VALUE)
	{
		var w_space = String.fromCharCode(32);
		var v_length = VALUE.length;
		var strTemp = "";
		if(v_length < 0)
		{
			return"";
		}
		var iTemp = v_length -1;

		while(iTemp > -1)
		{
			if(VALUE.charAt(iTemp) == w_space)
			{
			}
			else
			{
				strTemp = VALUE.substring(0,iTemp +1);
				break;
			}
			iTemp = iTemp-1;
		} //End While
		
		return strTemp;

	} //End Function

	function LTrim(VALUE)
	{
		var w_space = String.fromCharCode(32);
		if(v_length < 1)
		{
			return"";
		}
		var v_length = VALUE.length;
		var strTemp = "";
		var iTemp = 0;

		while(iTemp < v_length)
		{
			if(VALUE.charAt(iTemp) == w_space)
			{
			}
			else
			{
				strTemp = VALUE.substring(iTemp,v_length);
				break;
			}
			iTemp = iTemp + 1;
		} //End While
		return strTemp;
	} //End Function
			
	//JavaScript Validation Function
		function validate(cntrlName, cntrlType, valType)
	{
		var temp, temp1;
	
		for(var i = 0 ; i < cntrlName.length ; i++)
		{
			if((cntrlType[i] == 'text')&&(valType[i] == 'blank'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)=="")
				{
					temp.select();
					alert("Value cannot be blank!");
					temp.focus();
					return false;
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'password'))
			{
				if(cntrlName[i].length < 2)
				{
					alert('Insufficient parameters supplied for password validation!');
					return false;
				}
				temp = document.getElementById(cntrlName[i][0]);
				temp1 = document.getElementById(cntrlName[i][1]);
				if(Trim(temp.value)!=Trim(temp1.value))
				{
					temp.select();
					alert("Password does not match");
					temp1.focus();
					return false;
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'email'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)!="")
				{
					with (Trim(temp.value))
					{
						apos=temp.value.indexOf("@");
						dotpos=temp.value.lastIndexOf(".");
						lastpos=temp.value.length-1;
						if (apos<1 || dotpos-apos<2 || lastpos-dotpos>3 || lastpos-dotpos<2)
						{
							temp.select();
							alert("Please enter valid emailid !");
							temp.focus(); 
							return false;
						}
					}
				}
			}
			
			if((cntrlType[i] == 'dropdown')&&(valType[i] == 'blank'))
			{
				alert("ok");
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)=="" || Trim(temp.value)=="0")
				{
					//temp.select();
					alert("Please a value from dropdown!");
					temp.focus();
					return false; 
				}
			}
				
			if((cntrlType[i] == 'text')&&(valType[i] == 'numeric'))
			{
				temp = document.getElementById(cntrlName[i]);
				
				if(Trim(temp.value)!="")
				{
					if(isNaN(temp.value))
					{
						temp.select();
						alert("Please enter numeric value !");
						temp.focus();
						return false;
					}
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'nonzero'))
			{
				temp = document.getElementById(cntrlName[i]);
				
				if(Trim(temp.value)!="")
				{
					if(temp.value <= 0)
					{
						temp.select();
						alert("Value cannot be less than or equal to zero !");
						temp.focus();
						return false;
					}
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'url'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)!="")
				{     
					var s=Trim(temp.value);
					var dot=temp.value.split(".");
              				
					if (s.substr(0,10)!="http://www" || dot.length <= 2)
					{
						temp.select();
						alert("Site name should be in http://www.xxx.xx  format");
						temp.focus();
						return false;
					}
				}
			}
			if((cntrlType[i] == 'text')&&(valType[i] == 'date'))
			{
				temp = document.getElementById(cntrlName[i][0]);
				temp1 = cntrlName[i][1];
				
				if(cntrlName[i].length < 2)
				{
					temp.select();
					alert('Insufficient parameters supplied for date validation!');
					temp.focus();
					return false;
				}
				if(chkdate(temp, temp1) == false)
				{
					temp.select();
					alert('Date is invalid, please try again!');
					temp.focus();
					return false;
				}
			}
		}
			
		return true;
	}
	
	function validatenew(cntrlName, cntrlType, valType)
	{
		var temp, temp1;
	
		for(var i = 0 ; i < cntrlName.length ; i++)
		{
			if((cntrlType[i] == 'text')&&(valType[i][0] == 'blank'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)=="")
				{
					temp.select();
					if(valType[i][1] != '')
							alert(valType[i][1] + " cannot be null!");
						else
							alert("Value cannot be null!");
					temp.focus();
					return false;
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'password'))
			{
				if(cntrlName[i].length < 2)
				{
					alert('Insufficient parameters supplied for password validation!');
					return false;
				}
				temp = document.getElementById(cntrlName[i][0]);
				temp1 = document.getElementById(cntrlName[i][1]);
				if(Trim(temp.value)!=Trim(temp1.value))
				{
					temp.select();
					alert("Password does not match");
					temp1.focus();
					return false;
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'email'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)!="")
				{
					with (Trim(temp.value))
					{
						apos=temp.value.indexOf("@");
						dotpos=temp.value.lastIndexOf(".");
						lastpos=temp.value.length-1;
						if (apos<1 || dotpos-apos<2 || lastpos-dotpos>3 || lastpos-dotpos<2)
						{
							temp.select();
							alert("Please enter valid emailid !");
							temp.focus(); 
							return false;
						}
					}
				}
			}
			
			if((cntrlType[i] == 'dropdown')&&(valType[i][0] == 'blank'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)=="" || Trim(temp.value)=="0")
				{
					//temp.select();
					alert("Please select a value from "+valType[i][0]+" !");
					temp.focus();
					return false; 
				}
			}
				
			if(valType[i].length == 4)
			{
				if((cntrlType[i] == 'text')&&(valType[i][0] == 'numeric'))
				{
					temp = document.getElementById(cntrlName[i]);
					alert("In numeric check..");
					alert(temp.value);
					if(Trim(temp.value)!="")
					{
						if(isNaN(temp.value))
						{
							temp.select();
							alert("Please enter numeric value !");
							temp.focus();
							return false;
						}
						else
						{
							if(valType[i][1][0] == 'decimal')
							{
								var t= temp.value;
								var count = 0;
								var indx = t.indexOf(".");
								var d = valType[i][1][1];
								
								if((d != '')&&(indx != -1))
								{
									for(var j = indx+1 ; j < t.length ; j++)
										count += 1;
										
									if(count > d)
									{
										temp.select();
										alert('Number of values after decimal must be ' + d);
										temp.focus();
										return false;
									}
								}
							}
							else if(valType[i][1] == 'integer')
							{
								var s = temp.value;
								var indx = s.indexOf(".");
								
								if(indx > 0)
								{
									temp.select();
									alert('Number has to be a whole number !');
									temp.focus();
									return false;
								}
							}
							if(valType[i][2] == 'positive')
							{
								var t= temp.value;
								
								if(t < 0)
								{
									temp.select();
									alert('Number cannot be negative !');
									temp.focus();
									return false;
								}
							}
							if(valType[i][3] == 'nonzero')
							{
								var t = temp.value;
								
								if(t == 0)
								{
									temp.select();
									alert('Number cannot be zero !');
									temp.focus();
									return false;
								}
							}
						}
					}
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'url'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)!="")
				{     
					var s=temp.value ;
					var dot=temp.value.split(".");
              				
					if (s.substr(0,10)!="http://www" || dot.length <= 2)
					{
						temp.select();
						alert("Site name should be in http://www.xxx.xx  format");
						temp.focus();
						return false;
					}
				}
			}
			if((cntrlType[i] == 'text')&&(valType[i] == 'date'))
			{
				if(cntrlName[i].length < 2)
				{
					alert('Insufficient parameters supplied for date validation!');
					return false;
				}
				temp = document.getElementById(cntrlName[i][0]);
				temp1 = cntrlName[i][1];
				if(chkdate(temp, temp1) == false)
				{
					temp.select();
					alert('Date is invalid, please try again!');
					temp.focus();
					return false;
				}
			}
		}
			
		return true;
	}
	///////////////////////////////////////////////////////////
	function validateok(cntrlName, cntrlType, valType)
	{
		var temp, temp1;
		
		for(var i = 0 ; i < cntrlName.length ; i++)
		{
			if((cntrlType[i] == 'text')&&(valType[i][0] == 'blank'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)=="")
				{
					temp.select();
					if(valType[i][1] != '')
							alert(valType[i][1] + " cannot be blank!");
						else
							alert("Value cannot be blank!");
					temp.focus();
					return false;
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'password'))
			{
				if(cntrlName[i].length < 2)
				{
					alert('Insufficient parameters supplied for password validation!');
					return false;
				}
				temp = document.getElementById(cntrlName[i][0]);
				temp1 = document.getElementById(cntrlName[i][1]);
				if(Trim(temp.value)!=Trim(temp1.value))
				{
					temp.select();
					alert("Password does not match");
					temp1.focus();
					return false;
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'email'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)!="")
				{
					with (Trim(temp.value))
					{
						apos=temp.value.indexOf("@");
						dotpos=temp.value.lastIndexOf(".");
						lastpos=temp.value.length-1;
						if (apos<1 || dotpos-apos<2 || lastpos-dotpos>3 || lastpos-dotpos<2)
						{
							temp.select();
							alert("Please enter valid emailid !");
							temp.focus(); 
							return false;
						}
					}
				}
			}
			
			if((cntrlType[i] == 'dropdown')&&(valType[i][0] == 'blank'))
			{
				var DDL,temp;
				temp = document.getElementById(cntrlName[i]);
				DDL = document.all(cntrlName[i]);
				if(typeof(DDL.options) != "undefined")
				{
				if(Trim(DDL.options[DDL.selectedIndex].text) == "")
				{
					temp.select();
					alert("Please select a value from "+valType[i][1]+" !");
					temp.focus();
					return false; 
				}
				}
				
			}
			
			
			if(valType[i].length == 4)
			{
				if((cntrlType[i] == 'text')&&(valType[i][0] == 'numeric'))
				{
					temp = document.getElementById(cntrlName[i]);
					
					if(Trim(temp.value)!="")
					{
						if(isNaN(temp.value))
						{
							temp.select();
							alert("Please enter numeric value !");
							temp.focus();
							return false;
						}
						else
						{
							if(valType[i][1][0] == 'decimal')
							{
								var t= Trim(temp.value);
								var count = 0;
								var indx = t.indexOf(".");
								var d = valType[i][1][1];
								
								if((d != '')&&(indx != -1))
								{
									for(var j = indx+1 ; j < t.length ; j++)
										count += 1;
										
									if(count > d)
									{
										temp.select();
										alert('Number of values after decimal must be ' + d);
										temp.focus();
										return false;
									}
								}
							}
							else if(valType[i][1] == 'integer')
							{
								var s = Trim(temp.value);
								var indx = s.indexOf(".");
								
								if(indx > 0)
								{
									temp.select();
									alert('Number has to be a whole number !');
									temp.focus();
									return false;
								}
							}
							if(valType[i][2] == 'positive')
							{
								var t= Trim(temp.value);
								
								if(t < 0)
								{
									temp.select();
									alert('Number cannot be negative !');
									temp.focus();
									return false;
								}
							}
							if(valType[i][3] == 'nonzero')
							{
								var t = Trim(temp.value);
								
								if(t == 0)
								{
									temp.select();
									alert('Number cannot be zero !');
									temp.focus();
									return false;
								}
							}
						}
					}
				}
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'url'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)!="")
				{     
					var s=Trim(temp.value);
					var dot=temp.value.split(".");
              				
					if (s.substr(0,10)!="http://www" || dot.length <= 2)
					{
						temp.select();
						alert("Site name should be in http://www.xxx.xx  format");
						temp.focus();
						return false;
					}
				}
			}
			if((cntrlType[i] == 'text')&&(valType[i] == 'phone'))
			{
				temp = document.getElementById(cntrlName[i]);
				if(Trim(temp.value)!="")
				{
					var perm, perm1, perm2;
					temp1 = Trim(temp.value);
					if(temp1.length <= 3)
					{
						perm1 = "(";
						perm1 += temp1;
						perm1 += ")";
						temp.value = perm1;
						return;
					}
					else if(temp1.length <= 8)
					{
						if((temp1.charAt(0) == "(")&& (temp1.charAt(4) == ")"))
							return;
					}
					
					perm = temp2.substr(0,3);
					perm1 = temp2.substr(3,3);
					perm2 = temp2.substr(6,9);
					
					if(temp1.length > 14)
					{
						temp.select();
						alert("Invalid phone number format!");
						temp.focus();
						return false;
					}
					else
					{
						var s1;
						if(perm.length <= 3)
						{
						if(perm.charAt(0) != "(")
						{
							s1 = "(";
							s1 += perm;
						}
						else
						{
							s1 = perm;
						}
						}
						if(perm1.length <= 3)
						{
						if(perm1.charAt(1) != ")")
						{
							s1 += ")";
							s1 += perm1;
						}
						else
						{
							s1 += ")";
							s1 += perm1;
						}
						}
						if((perm2.length >= 3)||(perm2.length <= 3))
						{
							if(perm2.charAt(2) != "-")
							{
								s1 += perm2.substr(0,2);
								s1 += "-";
								s1 += perm2.substr(2,perm2.length);
							}
							else
							{
								s1 += perm2;
							}
						}
						temp.value = s1;
						
					}
				}
			}
			if((cntrlType[i] == 'text')&&(valType[i] == 'date'))
			{
				if(cntrlName[i].length < 2)
				{
					alert('Insufficient parameters supplied for date validation!');
					return false;
				}
				
				temp = document.getElementById(cntrlName[i][0]);
				temp1 = cntrlName[i][1];
				if(chkdate(temp, temp1) == false)
				{
					temp.select();
					alert('Date is invalid, please try again!');
					temp.focus();
					return false;
				}
				
			}
			if((cntrlType[i] == 'creditcard')&&(valType[i] == 'creditcard'))
			{
				var crCardPayType = cntrlName[i][0];
				var crCardType = cntrlName[i][1];
				var crCardExMonth = cntrlName[i][2];
				var crCardExYear = cntrlName[i][3];
				var crCardNumber = cntrlName[i][4];
				var crCardCode = cntrlName[i][5];
				
				if(!(validateCard(crCardPayType, crCardType, crCardExMonth, crCardExYear, crCardNumber, crCardCode)))
					return false;
			}
			
			if((cntrlType[i] == 'text')&&(valType[i] == 'time'))
			{
				var cntName = cntrlName[i];
				
				if(!(validateTime(cntName)))
					return false;
			}
		}
			
		return true;
	}
	
	///////////////// JAVASCRIPT VALIDATION FOR WINDOW CLOSE ///////////////
	
		//JavaScript function to hold control values
			
		function populateArrays(cntrlName,cntrlType)
		{
			// assign the default values to the items in the values array
			var val, str, arr;
			val = document.getElementById("hddValue");
			str = Trim(val.value);
			
			if(str != "")
			{
				arr = new Array();
				arr = str.split(":");
				values = new Array(arr.length);
				
				for(var i = 0 ; i < arr.length ; i++)
				{
					values[i] = arr[i];
				}
				val.value = "";
			}
			else
			{
				values = new Array(cntrlName.length);
				for (var i = 0; i < cntrlName.length; i++)
				{
					var elem = document.getElementById(cntrlName[i]);
					if (elem)
						if (cntrlType[i] == 'checkbox' || cntrlType[i] == 'radio')
						{
							values[i] = elem.checked;
						}
						else if(cntrlType[i] == 'text')
						{
							values[i] = elem.value;
						}
						else if(cntrlType[i] == 'dropdown')
						{
							var ddl = document.all(cntrlName[i]);
							values[i] = ddl.options[ddl.selectedIndex].text;
						}
						else if(cntrlType[i] == 'list')
						{
							var ddl = document.all(cntrlName[i]);
							values[i] = ddl.options[ddl.selectedIndex].text;
						}
				}
			}
		}
		
		//JavaScript function to hold control values

		function checkExit(cntrlName, cntrlType)
		{
				// check to see if any changes to the data entry fields have been made
				for(var i = 0 ; i < cntrlName.length ; i++)
				{
					var elem = document.getElementById(cntrlName[i]);
					if ((typeof(values[i]) != "undefined")&&(values[i] != null))
					{
						if ((cntrlType[i] == 'checkbox') || (cntrlType[i] == 'radio')
						&& (elem.checked != values[i]))
						{
							return false;
						}
						if(cntrlType[i] == 'text' && elem.value != values[i])
						{
							return false;
						}
						if(cntrlType[i] == 'dropdown' && elem.value != values[i])
						{
							return false;
						}
					}
				}
			return true;
		}
		
	///////////////// JAVASCRIPT VALIDATION FOR WINDOW CLOSE ///////////////
		
	//////////////////////////////////////////////////////////
	
	function chkdate(objName, tp) //DATE VALIDATION
	{
		var strDatestyle = tp; //United States date style
		//var strDatestyle = "EU";  //European date style
		var strDate;
		var strDateArray;
		var strDay;
		var strMonth;
		var strYear;
		var intday;
		var intMonth;
		var intYear;
		var booFound = false;
		var datefield = objName;
		var strSeparatorArray = new Array("-","/");
		var intElementNr;
		var err = 0;
		var strMonthArray = new Array(12);
		strMonthArray[0] = "01";
		strMonthArray[1] = "02";
		strMonthArray[2] = "03";
		strMonthArray[3] = "04";
		strMonthArray[4] = "05";
		strMonthArray[5] = "06";
		strMonthArray[6] = "07";
		strMonthArray[7] = "08";
		strMonthArray[8] = "09";
		strMonthArray[9] = "10";
		strMonthArray[10] = "11";
		strMonthArray[11] = "12";
		strDate = datefield.value;
		
		if (strDate.length < 1) 
		{
			return true;
		}
		
		for (intElementNr = 0; intElementNr < strSeparatorArray.length; intElementNr++) 
		{
			if (strDate.indexOf(strSeparatorArray[intElementNr]) != -1) {
				strDateArray = strDate.split(strSeparatorArray[intElementNr]);
				if (strDateArray.length != 3) {
					err = 1;
					return false;
				}
				else {
					strDay = strDateArray[0];
					strMonth = strDateArray[1];
					strYear = strDateArray[2];
				}
				booFound = true;
			}
		}
		if((typeof(strDay)=="undefined")||(isNaN(strDay)))
			return false;
		if((typeof(strMonth)=="undefined")||(isNaN(strMonth)))
			return false;
		if((typeof(strYear)=="undefined")||(isNaN(strYear)))
			return false;
			
		if (booFound == false) 
		{
			if (strDate.length>5) 
			{
				strDay = strDate.substr(0, 2);
				strMonth = strDate.substr(2, 2);
				strYear = strDate.substr(4);
			}
		}
		if (strYear.length == 2) 
		{
			strYear = '20' + strYear;
		}
		// US & other style
		if (strDatestyle == "US") 
		{
			strTemp = strDay;
			strDay = strMonth;
			strMonth = strTemp;
		}
		intday = parseInt(strDay, 10);
		if (isNaN(intday)) 
		{
			err = 2;
			return false;
		}
		intMonth = parseInt(strMonth, 10);
		if((intMonth > 12)||(intMonth < 1))
			return false;

		if (isNaN(intMonth)) 
		{
			for (i = 0;i<12;i++) {
				if (strMonth.toUpperCase() == strMonthArray[i].toUpperCase()) {
					intMonth = i+1;
					strMonth = strMonthArray[i];
					i = 12;
				}
			}
			if (isNaN(intMonth)) {
				err = 3;
				return false;
			}
		}
		intYear = parseInt(strYear, 10);
		if (isNaN(intYear)) {
			err = 4;
			return false;
		}
		if (intMonth>12 || intMonth<1) {
			err = 5;
			return false;
		}
		if ((intMonth == 1 || intMonth == 3 || intMonth == 5 || intMonth == 7 || intMonth == 8 || intMonth == 10 || intMonth == 12) && (intday > 31 || intday < 1)) {
			err = 6;
			return false;
		}
		if ((intMonth == 4 || intMonth == 6 || intMonth == 9 || intMonth == 11) && (intday > 30 || intday < 1)) {
			err = 7;
			return false;
		}
		if (intMonth == 2) {
			if (intday < 1) {
				err = 8;
				return false;
			}
			if (LeapYear(intYear) == true) {
				if (intday > 29) {
					err = 9;
					return false;
				}
			}
			else {
				if (intday > 28) {
					err = 10;
					return false;
				}
			}
		}
		if (strDatestyle == "US") 
		{
			datefield.value = strMonthArray[intMonth-1] + "/" + intday+"/" + strYear;
		}
		else 
		{
			datefield.value = intday + "/" + strMonthArray[intMonth-1] + "/" + strYear;
		}
			return true;
	}
		
	function LeapYear(intYear) 
	{
		if (intYear % 100 == 0) {
			if (intYear % 400 == 0) { return true; }
		}
		else {
			if ((intYear % 4) == 0) { return true; }
		}
		return false;
	}
	
	////////// Date Greater Check ////////////
	function checkDateGreater(stDate1, stDate2, tp)
	{
		var strDatestyle = tp; //United States date style
		//var strDatestyle = "EU";  //European date style
		var st1 = document.getElementById(stDate1);
		var st2 = document.getElementById(stDate2);
		var startDate = st1.value;
		var endDate = st2.value;
		if((startDate != "")&&(endDate != ""))
		{
			var strDate,strDate1;
			var strDateArray;
			var strDay,strDay1;
			var strMonth,strMonth1;
			var strYear,strYear1;
			var intday,intday1;
			var intMonth,intMonth1;
			var intYear,intYear1;
			var booFound = false;
			//var datefield = objName;
			var strSeparatorArray = new Array("-","/");
			var intElementNr;
			var err = 0;
			var strMonthArray = new Array(12);
			strMonthArray[0] = "01";
			strMonthArray[1] = "02";
			strMonthArray[2] = "03";
			strMonthArray[3] = "04";
			strMonthArray[4] = "05";
			strMonthArray[5] = "06";
			strMonthArray[6] = "07";
			strMonthArray[7] = "08";
			strMonthArray[8] = "09";
			strMonthArray[9] = "10";
			strMonthArray[10] = "11";
			strMonthArray[11] = "12";
			
			//for start date
			for (intElementNr = 0; intElementNr < strSeparatorArray.length; intElementNr++) 
			{
				if (startDate.indexOf(strSeparatorArray[intElementNr]) != -1) {
					strDateArray = startDate.split(strSeparatorArray[intElementNr]);
					if (strDateArray.length != 3) {
						err = 1;
						return false;
					}
					else {
						strDay = strDateArray[0];
						strMonth = strDateArray[1];
						strYear = strDateArray[2];
					}
					booFound = true;
				}
		}
		if (strYear.length == 2) 
		{
			strYear = '20' + strYear;
		}
		
		if((typeof(strDay)=="undefined")||(isNaN(strDay)))
		{
			alert("Invalid date format!");
			return false;
		}
		if((typeof(strMonth)=="undefined")||(isNaN(strMonth)))
		{
			alert("Invalid date format!");
			return false;
		}
		if((typeof(strYear)=="undefined")||(isNaN(strYear)))
		{
			alert("Invalid date format!");
			return false;
		}
			
		if (booFound == false) 
		{
			if (strDate.length>5) 
			{
				strDay = startDate.substr(0, 2);
				strMonth = startDate.substr(2, 2);
				strYear = startDate.substr(4);
			}
		}
		//for end date
		for (intElementNr = 0; intElementNr < strSeparatorArray.length; intElementNr++) 
		{
			if (endDate.indexOf(strSeparatorArray[intElementNr]) != -1) {
				strDateArray = endDate.split(strSeparatorArray[intElementNr]);
				if (strDateArray.length != 3) {
					err = 1;
					return false;
				}
				else {
					strDay1 = strDateArray[0];
					strMonth1 = strDateArray[1];
					strYear1 = strDateArray[2];
				}
				booFound = true;
			}
		}
		if (strYear1.length == 2) 
		{
			strYear1 = '20' + strYear1;
		}
		
		if((typeof(strDay1)=="undefined")||(isNaN(strDay1)))
		{
			alert("Invalid date format!");
			return false;
		}
		if((typeof(strMonth1)=="undefined")||(isNaN(strMonth1)))
		{
			alert("Invalid date format!");
			return false;
		}
		if((typeof(strYear1)=="undefined")||(isNaN(strYear1)))
		{
			alert("Invalid date format!");
			return false;
		}
			
		if (booFound == false) 
		{
			if (endDate.length>5) 
			{
				strDay1 = endDate.substr(0, 2);
				strMonth1 = endDate.substr(2, 2);
				strYear1 = endDate.substr(4);
			}
		}
		
		//Check for greater or less
		if(strYear > strYear1)
		{
			alert("Start date cannot be greater than end date!");
			return false;
		}
		else if((strYear <= strYear1)&&(strMonth > strMonth1))
		{
			alert("Start date cannot be greater than end date!");
			return false;
		}
		else if((strYear <= strYear1)&&(strMonth <= strMonth1)&&(strDay > strDay1))
		{
			alert("Start date cannot be greater than end date!");
			return false;
		}
		
	}
	return true;
}
	////////// Date Greater Check ////////////
	
	///////// Credit Card Validation ///////////
	function mod10( cardNumber ) 
			{ // LUHN Formula for validation of credit card numbers.
				var ar = new Array( cardNumber.length );
				var i = 0,sum = 0;
				
				for( i = 0; i < cardNumber.length; ++i )
				{
				ar[i] = parseInt(cardNumber.charAt(i));
				}
				for( i = ar.length -2; i >= 0; i-=2 )
				{ // you have to start from the right, and work back.
				ar[i] *= 2;						// every second digit starting with the right most (check digit)
				if( ar[i] > 9 ) ar[i]-=9;		// will be doubled, and summed with the skipped digits.
				}								// if the double digit is > 9, ADD those individual digits together 
				
				
				for( i = 0; i < ar.length; ++i )
				{
				sum += ar[i];					// if the sum is divisible by 10 mod10 succeeds
				}
				return (((sum%10)==0)?true:false);	 	
			}	
			
			
			function expired( month, year )
			{
				var now = new Date();							// this function is designed to be Y2K compliant.
				var expiresIn = new Date(year,month,0,0,0);		// create an expired on date object with valid thru expiration date
				expiresIn.setMonth(expiresIn.getMonth()+1);		// adjust the month, to first day, hour, minute & second of expired month
				if( now.getTime() < expiresIn.getTime() ) return false;
				return true;									// then we get the miliseconds, and do a long integer comparison
			}
			

			/////////////////  !! VALIDATION FOR CREDIT CARD !! ////////////////////////			
			function validateCard(crPayType, crCardType, crExMonth, crExYear, crCardNumber, crCardCode)
			{
				var DDLPType;
				var PType;
				var txtCardCode;
				
				if(crPayType != 'null')
				{
					DDLPType = document.all(crPayType);	
					PType = Trim(DDLPType.options[DDLPType.selectedIndex].text);
				}
				else
				{
					DDLPType = null;
					PType = null;
				}
				
				var DDLType = document.all(crCardType);
				var DDLMonth = document.all(crExMonth);
				var DDLYear = document.all(crExYear);
				var txtCardNumber = document.getElementById(crCardNumber);

				if(crCardCode != 'null')
					txtCardCode = document.getElementById(crCardCode);
				else
					txtCardCode = null;
								
				if((PType=="Credit Card")||(PType == null))
				{
					var cardNumber = Trim(txtCardNumber.value);
					var cardCode;
					
					if(txtCardCode != null)
						cardCode = Trim(txtCardCode.value);
					else
						cardCode = null;
					
					var cardMonth = Trim(DDLMonth.options[DDLMonth.selectedIndex].value);
					var cardYear = Trim(DDLYear.options[DDLYear.selectedIndex].text);
					var cardType = Trim(DDLType.options[DDLType.selectedIndex].text);
					
					if(cardNumber.length == 0 )
					{	
						txtCardNumber.select();
						alert("Please enter a valid card number.");
						txtCardNumber.focus();
						return false;				
					}
						
					for( var i = 0; i < cardNumber.length; ++i )
					{// make sure the number is all digits.. (by design)
						var c = cardNumber.charAt(i);
						if( c < '0' || c > '9' ) {
							txtCardNumber.select();
							alert("Please enter a valid card number. Use only digits. do not use spaces or hyphens.");
							txtCardNumber.focus();
							return false;
						}
					}
					var length = cardNumber.length;	//perform card specific length and prefix tests
						
					switch( cardType ) {
						case 'AMERICAN EXPRESS':
							if( length != 15 ) {
								txtCardNumber.select();
								alert("Please enter a valid American Express Card number.");
								txtCardNumber.focus();
								return false;
							}
							var prefix = parseInt( cardNumber.substring(0,2));
								if( prefix != 34 && prefix != 37 ) {
									txtCardNumber.select();
									alert("Please enter a valid American Express Card number.");
									txtCardNumber.focus();
									return false;
								}
								break;
						case 'DISCOVER':
							if( length != 16 ) {
								txtCardNumber.select();
								alert("Please enter a valid Discover Card number.");
								txtCardNumber.focus();
								return false;
							}
							var prefix = parseInt( cardNumber.substring(0,4));
				
				
							if( prefix != 6011 ) {
								txtCardNumber.select();
								alert("Please enter a valid Discover Card number.");
								txtCardNumber.focus();
								return false;
							}
							break;
						case 'MASTERCARD':
							if( length != 16 ) {
								txtCardNumber.select();
								alert("Please enter a valid MasterCard number.");
								txtCardNumber.focus();
								return false;
							}
							var prefix = parseInt( cardNumber.substring(0,2));
				
							if( prefix < 51 || prefix > 55) {
								txtCardNumber.select();
								alert("Please enter a valid MasterCard Card number.");
								txtCardNumber.focus();
								return false;
							}
							break;
						case 'VISA':		
							if( length != 16 && length != 13 ) {
								txtCardNumber.select();
								alert("Please enter a valid Visa Card number.");
								txtCardNumber.focus();
								return false;
							}
							var prefix = parseInt( cardNumber.substring(0,1));

							if( prefix != 4 ) {
								txtCardNumber.select();
								alert("Please enter a valid Visa Card number.");
								txtCardNumber.focus();
								return false;
							}
							break;
					}
					
					if( !mod10( cardNumber ) ) { 		// run the check digit algorithm
						txtCardNumber.select();
						alert("Sorry! this is not a valid credit card number.");
						txtCardNumber.focus();
						return false;
					}
				
					//alert(cardMonth);
					if( expired( cardMonth, cardYear )) {	// check if entered date is already expired.
						txtCardNumber.select();
						alert("Sorry! The expiration date you have entered would make this card invalid.");
						txtCardNumber.focus();
						return false;
					}
						
					if(txtCardCode != null)
					{
						if(txtCardCode.value.length < 3)
						{
							txtCardCode.select();
							alert("Card Security code should of 3 digits");
							txtCardCode.focus();
							return false;
						}
					}
				}
				return true;
			}

///////// Credit Card Validation ///////////

//////// Time Validation //////////

	function validateTime(txtvalTime)
	{
		var temp = document.getElementById(txtvalTime);
		var valTime = Trim(temp.value);
		var valTime2 =valTime;
		var cnt = 0
		var index1, index2;
		var tcs,ibm,inf;
		var items = "0123456789";
		var check = false;
				
		if(valTime.length > 8)
		{
			temp.select();
			alert("Invalid time format !");
			temp.focus();
			return false;
		}
		
		var chkTime = valTime.search(":");

		if(chkTime != -1)
		{
			for(var j = 0 ; j < valTime.length ; j++)
			{
				if(valTime.charAt(j) == ":")
				{
					cnt += 1;
				}
			}
			if(cnt < 1)
			{
				temp.select();
				alert("Invalid time format !");
				temp.focus();
				return false;
			}
			else
			{
				
				index1 = valTime.indexOf(":");
				index2 = valTime.lastIndexOf(":");
				
				tcs = valTime.substr(0,index1);
				ibm = valTime.substr(index1+1,index2-3);
				inf = valTime.substr(index2+1,valTime.length-1);
				
				if(inf.length == 0)
				{
					temp.select();
					alert("invalid time format !");
					temp.focus();
					return false;
				}
				for(var i = 0 ; i < tcs.length ; i++)
				{
					var it = tcs.charAt(i);
					
					if(items.indexOf(it) == -1)
					{
						check = true;
					}
				}
				if(check == true)
				{
					temp.select();
					alert("Invalid time format !");
					temp.focus();
					return false;
				}
				if(tcs >= 24)
				{
					temp.select();
					alert("Invalid time format !");
					temp.focus();
					return false;
				}
				if(ibm >= 60)
				{
					temp.select();
					alert("Invalid time format !");
					temp.focus();
					return false;
				}
				if(inf >= 60)
				{
					temp.select();
					alert("Invalid time format !");
					temp.focus();
					return false;
				}
				
			}
			
		}
		else
		{
			if((valTime.length > 2)||(valTime >= 24))
			{
				temp.select();
				alert("Invalid time format !");
				temp.focus();
				return false;
			}
		}
		
		return true;			
	}
	
//////// Blank/Email check for CCGA ///////
        function checkEmail(val,type)
		  {
			 var temp, temp1, temp2;
			 temp1 = document.all(type);
						
			if(Trim(temp1.options[temp1.selectedIndex].text) != "")
			{
				temp = document.getElementById(val);
				if(Trim(temp.value)!="")
				{
					if((Trim(temp1.options[temp1.selectedIndex].text) == 'Email')||(Trim(temp1.options[temp1.selectedIndex].text) == 'E-mail')||(Trim(temp1.options[temp1.selectedIndex].text) == 'E-mail 2')||(Trim(temp1.options[temp1.selectedIndex].text) == 'Asst. Email')||(Trim(temp1.options[temp1.selectedIndex].text) == 'Asst. Email2'))
					{
						with (Trim(temp.value))
						{
							apos=temp.value.indexOf("@");
							anum = temp.value.lastIndexOf("@");
							strTemp = anum - apos;
							dotpos=temp.value.indexOf(".");
							lastpos=temp.value.length-1;
							if (apos<1 || strTemp>=1 || dotpos-apos<2 || lastpos-dotpos>3 || lastpos-dotpos<2)
							{
								temp.select();
								alert("Please enter valid email id !");
								temp.focus(); 
								return false;
							}
						}
					}
					else if(Trim(temp1.options[temp1.selectedIndex].text) == 'Website')
					{
						if(Trim(temp.value)!="")
						{     
							var s=temp.value ;
							var dot=temp.value.split(".");
              				
							if (s.substr(0,10)!="http://www" || dot.length <= 2)
							{
								temp.select();
								alert("Site name should be in http://www.xxx.xx  format");
								temp.focus();
								return false;
							}
						}
					}
					else if((Trim(temp1.options[temp1.selectedIndex].text) == 'Business Phone')||(Trim(temp1.options[temp1.selectedIndex].text) == 'Cell Phone')||(Trim(temp1.options[temp1.selectedIndex].text) == 'Home Phone')||(Trim(temp1.options[temp1.selectedIndex].text) == 'Day Phone')||(Trim(temp1.options[temp1.selectedIndex].text) == 'Evening Telephone')||(Trim(temp1.options[temp1.selectedIndex].text) == 'Evening Phone')||(Trim(temp1.options[temp1.selectedIndex].text) == 'Daytime Telephone')||(Trim(temp1.options[temp1.selectedIndex].text)=='Alternate Phone'))
					{
						var perm, perm1, perm2;
						temp2 = temp.value;
						if(temp2.length <= 3)
						{
							perm1 = "(";
							perm1 += temp2;
							perm1 += ")";
							temp.value = perm1;
							return;
						}
						
						perm = temp2.substr(0,3);
						perm1 = temp2.substr(3,3);
						perm2 = temp2.substr(6,9);
						
						if(temp2.length <= 8)
						{
							if((temp2.charAt(0) == "(")&& (temp2.charAt(4) == ")"))
								return;
						}
						
						if(temp2.length > 20)
						{
							temp.select();
							alert("Invalid phone number format!");
							temp.focus();
							return false;
						}
						else
						{
							var s1;
							if(perm.length <= 3)
							{
								if(perm.charAt(0) != "(")
								{
									s1 = "(";
									s1 += perm;
								}
								else
								{
									s1 = perm;
								}
							}
							if(perm1.length <= 3)
							{
								if(perm1.charAt(1) != ")")
								{
									s1 += ") ";
									s1 += perm1;
								}
								else
								{
									s1 += perm1;
								}
							}
							if((perm2.length >= 3)||(perm2.length <= 3))
							{
								if(perm2.charAt(3) != "-")
								{
									s1 += "-";
									s1 += perm2;
								}
								else
								{
									s1 += perm2;
								}
							}
							temp.value = s1;
						}
					}
				}
				else
				{
					temp.select();
					alert("Value cannot be blank!");
					temp.focus();
					return false;
				}
			}
			else
			{
				alert("Please select a value from dropdown!");
				temp1.focus();
				return false;
			}
		}
			
//////// Blank/Email check for CCGA ///////

//////// Time Validation //////////

	function confirmSubmit()
	{
		var agree=confirm("Are you sure you wish to continue?");
		if (agree)
			return true ;
		else
			return false ;
	} 
/*  Message Box before deletion from Grid */
		function deleteConfirm()
		{
			if(confirm('Are you sure that you want to delete this record ?'))
				return true;
			else
				return false;
		}