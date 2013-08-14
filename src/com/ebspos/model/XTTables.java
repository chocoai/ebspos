package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;
import com.jfinal.plugin.activerecord.Model;
/**
 * 系统表信息
 * @author 湛原红
 * 2013.8.13
 *
 */
@TableBind(name="xttables")
public class XTTables extends Model<XTTables> {
	private static final long serialVersionUID = 973448093676645483L;
	public static final XTTables dao=new XTTables(); 
	
	

}
