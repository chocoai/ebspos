package com.ebspos.ckxscheck.model;

import com.jfinal.plugin.activerecord.Model;
import net.loyin.jFinal.anatation.TableBind;

@TableBind(name="ckxscheck")
public class Ckxscheck extends Model<Ckxscheck> {
	private static final long serialVersionUID = 5216272629919656559L;
	public static final Ckxscheck dao=new Ckxscheck();
}
