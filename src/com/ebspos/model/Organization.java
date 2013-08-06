package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;
/***
 * 组织机构
 * 为公司及分公司
 * @author 刘声凤
 *  2012-9-4 上午10:39:04
 */
@TableBind(name="organization")
public class Organization extends Model<Organization> {
	private static final long serialVersionUID = 7217141922057302111L;
	public static final Organization dao=new Organization();
}
