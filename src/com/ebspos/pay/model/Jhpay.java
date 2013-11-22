package com.ebspos.pay.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

@TableBind(name="jhpay")
public class Jhpay extends Model<Jhpay> {
	private static final long serialVersionUID = -8308907780964556954L;
	public static final Jhpay dao=new Jhpay();
}
