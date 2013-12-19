package com.util;

import java.math.BigDecimal;
import java.util.Date;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class BsUtil {
	    // 应付款
	    public static int NEED_PAY = 45;
	    // 预付款
	    public static int ADV_PAY = 47;
	    // 预付冲应付
	    public static int ADV_TO_NEED_PAY = 48;
	    // 应付转预付
	    public static int NEED_TO_ADV_PAY = 49;
	    // 直接付款
	    public static int DIR_PAY = 50;
	    // 查看类型
	    public static String VIEW_INDEX = "index";
	    // 查看类型
	    public static String VIEW_LOOKUP = "lookup";
	    
	    public static Double add(BigDecimal... params) {
			Double total = 0.0;
            for (int i = 0; i < params.length; i++) {
            	if (params[i] != null) {
            		total += params[i].doubleValue();
            	}
			}
			return total;
	    }
	    
	    public static Double plus(BigDecimal... params) {
	    	Double total = 0.0;
	    	for (int i = 0; i < params.length; i++) {
	    		if (i == 0) {
	    			if (params[0] != null) {
	    				total = params[0].doubleValue();
	    			}
	    		} else {
	    			if (params[i] != null) {
	    				total -= params[i].doubleValue();
	    			}
	    		}
	    	}
	    	return total;
	    }
	    
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
