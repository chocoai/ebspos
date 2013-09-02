package com.ebspos.cg.controller;

import java.util.ArrayList;
import java.util.List;
import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.controller.BaseController;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
/**
 * 采购订单资料
 * @author 湛原红 
 * 2013.8.30
 *
 */
@RouteBind(path="/cgorder")
@Before({ManagerPowerInterceptor.class})
public class CgorderController extends BaseController {

	public static Logger log = Logger.getLogger(CgorderController.class);
	private static String navTabId = "cgorder";
	@Override
	public void index() {
		
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
	/*	String clientcode=getPara("clientcode");
		if(clientcode!=null && !"".equals(clientcode.trim())){
			whee.append(" and p.clientcode like ?");
			param.add("%"+clientcode+"%");			
		}
				
		setAttr("suppliercode",clientcode);*/
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.ordercode 订单号, p.orderdate 订单日期,p.stopflag 停用,p.remark 备注",
				" from  cgorder p where 1=1  "+whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","订单日期","停用","备注"});
		
		render("index.html");

	}
	public void add() {
		/*
		Jbclient xtts = new Jbclient();
		Long id = getParaToLong(0, 0L);
		if (id != 0) { // 修改
			xtts = Jbclient.dao.findById(id);
		}
        
		setAttr("xtts", xtts);		
		render("add.html");
		*/
	}
	public void save() {
		/*
		try {
			Jbclient m = getModel(Jbclient.class);
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
		*/
	}
	public void del() {
	/*
		Long id = getParaToLong(0, 0L);
		try {
			Jbclient.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
		*/
	}
  
}
