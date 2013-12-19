package com.ebspos.xs.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

@TableBind(name="xsorder")
public class Xsorder extends Model<Xsorder> {
	private static final long serialVersionUID = 8466777331639144465L;
	public static final Xsorder dao=new Xsorder();
}
