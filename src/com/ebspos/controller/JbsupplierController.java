package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;
import net.loyin.jFinal.anatation.RouteBind;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbsupplier;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
/**
 * 系统用表记录
 * @author 湛原红 
 * 2013.8.14
 *
 */
@RouteBind(path="/jbsupplier")
@Before({ManagerPowerInterceptor.class})
public class JbsupplierController extends BaseController {

	public static Logger log = Logger.getLogger(JbsupplierController.class);
	private static String navTabId = "jbsupplier";
	@Override
	public void index() {
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String suppliercode=getPara("suppliercode");
		if(suppliercode!=null && !"".equals(suppliercode.trim())){
			whee.append(" and p.goodscode like ?");
			param.add("%"+suppliercode+"%");			
		}		
		setAttr("suppliercode",suppliercode);
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.suppliercode 供应商代码, p.suppliername 供应商名称,p.suppliertypeno 供应商类别,p.stopflag 停用,p.remark 备注",
				" from  jbsupplier p where 1=1  "+whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"供应商代码","供应商名称","供应商类别","停用","备注"});
		render("index.html");

	}
	public void add() {
		Jbsupplier xtts = new Jbsupplier();
		Long id = getParaToLong(0, 0L);
		if (id != 0) { // 修改
			xtts = Jbsupplier.dao.findById(id);
		}
        
		setAttr("xtts", xtts);		
		render("add.html");
	}
	public void save() {
		try {
			Jbsupplier m = getModel(Jbsupplier.class);
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
			Jbsupplier.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
