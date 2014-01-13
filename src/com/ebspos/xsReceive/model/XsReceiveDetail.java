package com.ebspos.xsReceive.model;




import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

@TableBind(name="xsreceivedetail")
public class XsReceiveDetail extends Model<XsReceiveDetail> {
	private static final long serialVersionUID = -2937492030908845896L;
	public static final XsReceiveDetail dao=new XsReceiveDetail();
}