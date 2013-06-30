package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;
/***
 * 雇员
 * @author 刘声凤
 *  2012-9-4 上午10:39:04
 */
@TableBind(name="employee")
public class Employee extends Model<Employee> {
	private static final long serialVersionUID = 963448093676645483L;
	public static final Employee dao=new Employee();
}
