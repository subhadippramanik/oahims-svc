/*
 * Created on Jul 4, 2006
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package com.oa.kh.utility;

import java.text.*;
import java.util.*;
import java.io.*;

/**
 * @author Administrator
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class Test {

	String COUNTRY_PHONE_ACCESS_US = "1";

	public Test() {}

	public static void main(String[] args){
		Test mtest = new Test();
		String mret = mtest.PersePhoneNumber("2234567890123");

		System.out.println("Out put :" + mret);
	}

	public String FormatPhoneNumber(String phoneNumber){
		 String tempNumber ="";
		 if (phoneNumber != null){
			 if(phoneNumber.length()==10){
				tempNumber=phoneNumber.substring(0,3).concat("-");
				tempNumber+=phoneNumber.substring(3,6).concat("-");
				tempNumber+=phoneNumber.substring(6,phoneNumber.length());
			 }else{
				 tempNumber = phoneNumber;
			 }
		 }
		 return tempNumber;
    }

	public String PersePhoneNumber(String tempContactNumber){
		String mCntryCd="",mPhNum="",mPhEx="";

		if(tempContactNumber != null){
			tempContactNumber = tempContactNumber.replaceAll(" +","");
			tempContactNumber = tempContactNumber.replaceAll("-+","");
			tempContactNumber = tempContactNumber.replaceAll("x","");
			tempContactNumber = tempContactNumber.replaceAll("\\+","");

			if(tempContactNumber.length() <= 10){
				mCntryCd="";
				mPhNum=FormatPhoneNumber(tempContactNumber);
				mPhEx="";
			}else if(tempContactNumber.length()==11){
					if(tempContactNumber.startsWith(COUNTRY_PHONE_ACCESS_US)){
						mCntryCd=COUNTRY_PHONE_ACCESS_US;
						mPhNum=FormatPhoneNumber(tempContactNumber.substring(1,tempContactNumber.length()));
						mPhEx="";
					}else{
						mCntryCd=tempContactNumber.substring(0,1);
						mPhNum=tempContactNumber.substring(1,tempContactNumber.length());
						mPhEx="";
					}
			}else if(tempContactNumber.length()==12){
				if(tempContactNumber.startsWith(COUNTRY_PHONE_ACCESS_US)){
					mCntryCd=COUNTRY_PHONE_ACCESS_US;
					mPhNum=FormatPhoneNumber(tempContactNumber.substring(1,11));
					mPhEx="x".concat(tempContactNumber.substring(11,tempContactNumber.length()));
				}else{
					mCntryCd=tempContactNumber.substring(0,2);
					mPhNum=FormatPhoneNumber(tempContactNumber.substring(2,tempContactNumber.length()));
					mPhEx="";
				}
			}else{
				if(tempContactNumber.startsWith(COUNTRY_PHONE_ACCESS_US)){
					mCntryCd=COUNTRY_PHONE_ACCESS_US;
					mPhNum=FormatPhoneNumber(tempContactNumber.substring(1,11));
					if(tempContactNumber.length()>0)
					mPhEx="x".concat(tempContactNumber.substring(11,tempContactNumber.length()));
				}else{
					mCntryCd=tempContactNumber.substring(0,3);
					mPhNum=FormatPhoneNumber(tempContactNumber.substring(3,13));
					if(tempContactNumber.length()>0)
					mPhEx="x".concat(tempContactNumber.substring(13,tempContactNumber.length()));
				}
			}
		}
		if(tempContactNumber.startsWith(COUNTRY_PHONE_ACCESS_US)){
			return mCntryCd.concat(" ").concat(mPhNum).concat(" ").concat(mPhEx);
		}else{
			if(mCntryCd.length()>0){
					if(mPhEx.length()>0){
						return "+".concat(mCntryCd).concat(" ").concat(mPhNum).concat(" ").concat(mPhEx);
					}else{
						return "+".concat(mCntryCd).concat(" ").concat(mPhNum);
					}
			}else{
				if(mPhEx.length()>0){
					return mPhNum.concat(" ").concat(mPhEx);
				}else{
					return mPhNum;
				}
			}

		}
    }
}