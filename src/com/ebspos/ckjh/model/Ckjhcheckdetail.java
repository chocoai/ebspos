package com.ebspos.ckjh.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

/**
 * 采购入库明细表
 * @author 熊涛
 * 2013-08-15
 */
@TableBind(name="ckjhcheckdetail")
public class Ckjhcheckdetail  extends Model<Ckjhcheckdetail> {
	private static final long serialVersionUID = 6182912405475193922L;
	public static final Ckjhcheckdetail dao=new Ckjhcheckdetail();
}
