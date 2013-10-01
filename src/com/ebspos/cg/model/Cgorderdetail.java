package com.ebspos.cg.model;

import com.jfinal.plugin.activerecord.Model;

import net.loyin.jFinal.anatation.TableBind;

@TableBind(name="cgorderdetail")
public class Cgorderdetail extends Model<Cgorderdetail> {
	private static final long serialVersionUID = -6015038111512050535L;
	public static final Cgorderdetail dao=new Cgorderdetail();
}
