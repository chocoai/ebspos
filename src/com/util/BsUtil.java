package com.util;

import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class BsUtil {
	
         public static String getMaxOrdNo(String fieldNm,String prefix,String tblNm) {
        	    String ordCdNw;
				String selectMaxOrdCd = "select max(" + fieldNm  +") as ordcd from " + tblNm  +" where " + fieldNm + " like '%" +  prefix +"-" + DateUtil.date2String(new Date(), DateUtil.FORMAT_DATE_1)+ "%'";
				Record max = Db.findFirst(selectMaxOrdCd);
				String ordCd = max.get("ordcd");
				String qx = prefix + "-" + DateUtil.date2String(new Date(), DateUtil.FORMAT_DATE_1) + "-";
				if (ordCd != null) {
					int num = Integer.parseInt(ordCd.substring(ordCd.lastIndexOf("-")+1)) + 1;
					ordCdNw = qx  + numToFmtStr(num);
				} else {
					ordCdNw = qx + numToFmtStr(1);
				}
				return ordCdNw;
         }
         
     	private static String numToFmtStr(int num) {
    		if (num < 10) {
    			return "00" + num;
    		} else if (num >= 10 && num < 100) {
    			return "0" + num;
    		} else if (num >=100 && num < 1000) {
    			return "" + num;
    		}
    		return "";
    	}
}
