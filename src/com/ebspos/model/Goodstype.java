package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;
/***
 * 商品类别
 * @author 湛原红
 *  2013-8-10
 */
@TableBind(name="goodstype")
public class Goodstype extends Model<Goodstype> {
	private static final long serialVersionUID = 800553527430796237L;
	public static final Goodstype dao=new Goodstype();
}
