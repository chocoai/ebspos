package com.ebspos.model;
import net.loyin.jFinal.anatation.TableBind;
import com.jfinal.plugin.activerecord.Model;
/**
 * 供应商资料
 * @author 湛原红
 *zyh 2013.8.27
 */
@TableBind(name="jbsupplier")
public class Jbsupplier extends Model<Jbsupplier>{
	private static final long serialVersionUID = -4758734962602882508L;
	public static final Jbsupplier dao=new Jbsupplier();

}
