package com.ebspos.cg.model;

import com.jfinal.plugin.activerecord.Model;

import net.loyin.jFinal.anatation.TableBind;

@TableBind(name="cgorder")
public class Cgorder extends Model<Cgorder> {
	private static final long serialVersionUID = -48379031542099866L;
	public static final Cgorder dao=new Cgorder();
}
