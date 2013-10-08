package com.ebspos.ckjh.model;
import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

/**
 * 采购入库主表
 * @author 熊涛
 * 2013-08-15
 */
@TableBind(name="ckjhcheck")
public class Ckjhcheck extends Model<Ckjhcheck> {
	private static final long serialVersionUID = -450844781220375446L;
	public static final Ckjhcheck dao=new Ckjhcheck();
}
