package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

/***
 * 仓库类别
 * @author 熊涛
 *  2013-8-12
 */
@TableBind(name="jbstore")
public class Jbstore extends Model<Jbstore> {
	private static final long serialVersionUID = -6778734962602882508L;
	public static final Jbstore dao=new Jbstore();
}
