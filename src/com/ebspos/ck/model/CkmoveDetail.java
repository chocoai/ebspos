package com.ebspos.ck.model;

import com.jfinal.plugin.activerecord.Model;

import net.loyin.jFinal.anatation.TableBind;

@TableBind(name="ckmovedetail")
public class CkmoveDetail extends Model<CkmoveDetail>  {
	private static final long serialVersionUID = 1754088844462905986L;
	public static final CkmoveDetail dao=new CkmoveDetail();
}
