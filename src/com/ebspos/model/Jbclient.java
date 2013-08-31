package com.ebspos.model;
import net.loyin.jFinal.anatation.TableBind;
import com.jfinal.plugin.activerecord.Model;
/**
 * 客户资料
 * @author 湛原红
 * 2013.8.27
 */
@TableBind(name="jbclient")
public class Jbclient extends Model<Jbclient>{
	private static final long serialVersionUID = -4758734961602882508L;
	public static final Jbclient dao=new Jbclient();

}
