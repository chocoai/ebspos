package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

/**
 * 期初库存明细表
 * @author 熊涛
 * 2013-08-15
 */
@TableBind(name="ckinitstoredetail")
public class CKinitStoreDetail extends Model<CKinitStoreDetail> {
	private static final long serialVersionUID = 6992124176791394802L;
	public static final CKinitStoreDetail dao=new CKinitStoreDetail();
}

