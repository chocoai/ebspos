package com.ebspos.ckxscheck.model;

import com.jfinal.plugin.activerecord.Model;

import net.loyin.jFinal.anatation.TableBind;

@TableBind(name="ckxscheckdetail")
public class CkxscheckDetail extends Model<CkxscheckDetail> {
	private static final long serialVersionUID = -9113350747523107348L;
	public static final CkxscheckDetail dao=new CkxscheckDetail();
}
