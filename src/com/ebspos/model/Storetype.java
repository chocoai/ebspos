package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

/***
 * 仓库类别
 * @author 熊涛
 *  2013-8-12
 */
@TableBind(name="storetype")
public class Storetype extends Model<Storetype> {
	private static final long serialVersionUID = 6796096785063988638L;
	public static final Storetype dao=new Storetype();
}