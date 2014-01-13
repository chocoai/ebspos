package com.ebspos.model;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

/**
 * 个人日程
 * @author loyin
 * 2012-10-21
 */
@TableBind(name="calendar")
public class Calendar extends Model<Calendar> {
	private static final long serialVersionUID = -1239688315036891521L;
	public static final Calendar dao=new Calendar();
}
