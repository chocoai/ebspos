package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

/**
 * 期初库存主表
 * @author 熊涛
 * 2013-08-15
 */
@TableBind(name="ckinitstore")
public class CKinitStore extends Model<CKinitStore> {
	private static final long serialVersionUID = 8855952602660614169L;
	public static final CKinitStore dao=new CKinitStore();
}

