package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;
/***
 * 菜单
 * @author 刘声凤
 *  2012-9-4 上午10:39:04
 */
@TableBind(name="menu")
public class Menu extends Model<Menu> {
	private static final long serialVersionUID = 2930684285217028262L;
	public static final Menu dao=new Menu();
}
