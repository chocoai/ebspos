package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;
import net.loyin.jFinal.anatation.RouteBind;
import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbgoods;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
/**
 * 系统用表记录
 * @author 湛原红 
 * 2013.8.14
 *
 */
@RouteBind(path="/jbgoods")
@Before({ManagerPowerInterceptor.class})
public class JbgoodsController extends BaseController {

	public static Logger log = Logger.getLogger(JbgoodsController.class);
	private static String navTabId = "jbgoods";
	@Override
	public void index() {
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String goodscode=getPara("goodscode");
		if(goodscode!=null && !"".equals(goodscode.trim())){
			whee.append(" and p.goodscode like ?");
			param.add("%"+goodscode+"%");			
		}
		setAttr("goodscode",goodscode);
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.goodscode 商品编码, p.goodsname 商品名称,p.model 规格,p.barcode 条码, "+
				" p.baseunit 计量单位 ,p.remark 备注",
				" from  jbgoods p  where 1=1  "+whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"商品编码","商品名称","规格","条码","计量单位","备注"});
		render("index.html");

	}
	public void add() {
		Jbgoods xtts = new Jbgoods();
		Long id = getParaToLong(0, 0L);
		if (id != 0) { // 修改
			xtts = Jbgoods.dao.findById(id);
		}
        
		setAttr("xtts", xtts);
		render("add.html");
	}
	public void save() {
		try {
			Jbgoods m = getModel(Jbgoods.class);
			if (m.getLong("id") != null) {
				m.update();
			} else {
				m.save();
			}
			toDwzJson(200, "保存成功！", navTabId);
		} catch (Exception e) {
			log.error("保存系统表信息异常", e);
			toDwzJson(300, "保存异常！");
		}
	}
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			Jbgoods.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
