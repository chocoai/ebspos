package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.ftl.StoretypeSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.CKinitStore;
import com.ebspos.model.Jbstore;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;

/**
 * 起初库存
 * 
 * @author 熊涛
 */
@RouteBind(path = "/ckinitstore")
@Before({ ManagerPowerInterceptor.class })
public class CKinitStoreController extends BaseController {
	public static Logger log = Logger.getLogger(CKinitStoreController.class);
	private static String navTabId = "ckinitstore";
	private boolean f;
	
	@Override
	public void index() {
		f = true;
		list();
		render("index.html");
	}
	
	public void list() {
		String startTime = getPara("startTime");
		StringBuffer whee=new StringBuffer();
		List<Object> param=new ArrayList<Object>();
		if(startTime!=null&&!"".equals(startTime.trim())){
			whee.append(" and a.orderdate >= str_to_date(?,'%Y%m%d')");
			param.add(startTime);
		}
		setAttr("startTime", startTime);
		String endTime = getPara("endTime");
		if(endTime!=null&&!"".equals(endTime.trim())){
			whee.append(" and a.orderdate <= str_to_date(?,'%Y%m%d')");
			param.add(endTime);
		}
		setAttr("endTime", endTime);
	//	setAttr(OrgSelectTarget.targetName,new OrgSelectTarget());
	//	setAttr(PartmentSelectTarget.targetName,new PartmentSelectTarget());
		String sql = "select a.id,a.orderno 订单号,a.orderdate 订单日期,a.storeno 仓库,a.billorderno 票据号,a.relatedbillno 票据日期,"
				+ "a.DepartmentNo 部门,a.EmployeeNo 员工,a.operator 操作人,a.ckamount 库存数量,a.checkflag 审核,a.checkdate 审核日期,a.checkman 审核人,a.recordcount 记录数,a.Memo 备注";
		String sqlSelect = "from ckinitstore a where 1=1 ";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","订单日期","仓库","票据号","票据日期","部门","员工","库存数量","审核","审核日期","审核人","备注","审核"});
		if (f == false)
			render("list.html");
	}
	
	public void add() {
		CKinitStore ckt = new CKinitStore();
		Long id = getParaToLong(0, 0L);
		if (id != 0) { // 修改
			ckt = CKinitStore.dao.findById(id);
		}
        setAttr(StoretypeSelectTarget.targetName, new StoretypeSelectTarget());
		 setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		 setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		setAttr("ckt", ckt);
		render("add.html");
	}
	
	public void save() {
		try {
			CKinitStore m = getModel(CKinitStore.class);
			if (m.getLong("id") != null) {
				m.update();
			} else {
				m.save();
			}
			toDwzJson(200, "保存成功！", navTabId);
		} catch (Exception e) {
			log.error("保存仓库分类异常", e);
			toDwzJson(300, "保存异常！");
		}
	}
	
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			Jbstore.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
