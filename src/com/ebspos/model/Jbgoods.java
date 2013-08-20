package com.ebspos.model;
import net.loyin.jFinal.anatation.TableBind;
import com.jfinal.plugin.activerecord.Model;
/**
 * 商品资料
 * @author 湛原红
 *zyh 2013.8.18
 */
@TableBind(name="jbgoods")
public class Jbgoods extends Model<Jbgoods>{
	private static final long serialVersionUID = -4978734962602882508L;
	public static final Jbgoods dao=new Jbgoods();

}
