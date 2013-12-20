package com.ebspos.xs.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

@TableBind(name="xsorderdetail")
public class Xsorderdetail extends Model<Xsorderdetail> {
	private static final long serialVersionUID = 2392257045950756935L;
	public static final Xsorderdetail dao=new Xsorderdetail();
}
