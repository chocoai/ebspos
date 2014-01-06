package com.ebspos.jhpay.model;


import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

@TableBind(name="jhpaydetail")
public class Jhpaydetail extends Model<Jhpaydetail> {
	private static final long serialVersionUID = 341704377515253821L;
	public static final Jhpaydetail dao=new Jhpaydetail();
}