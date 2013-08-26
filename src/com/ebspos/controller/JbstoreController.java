package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;

import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.GoodsBigSelectTarget;
import com.ebspos.ftl.StoretypeSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Employee;
import com.ebspos.model.Jbstore;
import com.ebspos.model.Storetype;

import net.loyin.jFinal.anatation.RouteBind;
import net.loyin.util.safe.MD5;

import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 仓库资料
 * @author 熊涛
 *2013-8-13
 */
@RouteBind(path = "/jbstore")
@Before({ManagerPowerInterceptor.class})
public class JbstoreController extends BaseController {
	public static Logger log = Logger.getLogger(JbstoreController.class);
	private static String navTabId = "jbstore";
	private boolean f;
	
	@Override
	public void index() {
		f = true;
		list();
		render("index.html");
	}
	
	public void list() {
		Long typeNo = getParaToLong(0, 0L);
		StringBuffer whee=new StringBuffer();
		List<Object> param=new ArrayList<Object>();
		String name=getPara("StoreName");
		if(name!=null&&!"".equals(name.trim())){
			whee.append(" and st.StoreName like ?");
			param.add("%"+name+"%");
		}
		setAttr("StoreName", name);
		
		String num=getPara("StoreCode");
		if(num!=null&&!"".equals(num.trim())){
			whee.append(" and st.StoreCode = ?");
			param.add(num);
		}
		setAttr("StoreCode", num);
		if (typeNo !=0)
		{
			whee.append(" and st.typeNo= ?");
			param.add(typeNo);
		}
	//	setAttr(OrgSelectTarget.targetName,new OrgSelectTarget());
	//	setAttr(PartmentSelectTarget.targetName,new PartmentSelectTarget());
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				"select id,StoreNo 仓库序号,StoreCode 仓库编号,StoreName 仓库名称,LAndHeight 面积,Place 位置,EmployeeNo 管理员,CountQuantity 合计商品数量,PriceType 计价方式,Memo 备注,StopFlag 停用",
				" from  jbstore st where 1=1 "+whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"仓库序号","仓库编号","仓库名称","面积","位置","管理员","合计商品数量","计价方式","备注","停用"});
		if (f == false)
			render("list.html");		
	}
	
	public void add() {
		Jbstore stt = new Jbstore();
		Long id = getParaToLong(0, 0L);
		if (id != 0) { // 修改
			stt = Jbstore.dao.findById(id);
		}
        //	setAttr(StoretypeSelectTarget.targetName, new StoretypeSelectTarget());
		// setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		 setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		setAttr("stt", stt);
		render("add.html");
	}
	
	public void save() {
		try {
			Jbstore m = getModel(Jbstore.class);
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
