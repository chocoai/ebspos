package com.ebspos.ck.model;

import com.jfinal.plugin.activerecord.Model;

import net.loyin.jFinal.anatation.TableBind;

@TableBind(name="ckmove")
public class Ckmove extends Model<Ckmove>  {	
	private static final long serialVersionUID = -48379031542099868L;
	public static final Ckmove dao=new Ckmove();
}
