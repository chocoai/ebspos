package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;
import net.loyin.jFinal.anatation.RouteBind;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbclient;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
/**
 * 客户资料
 * @author 湛原红 
 * 2013.8.14
 *
 */
@RouteBind(path="/jbclient")
@Before({ManagerPowerInterceptor.class})
public class JbclientController extends BaseController {

	public static Logger log = Logger.getLogger(JbclientController.class);
	private static String navTabId = "jbclient";
	@Override
	public void index() {
		getPageInfo();
		setAttr("collist", new String[]{"客户代码","客户名称","客户类别","停用","备注"});
		render("index.html");
	}
	
	public void lookuplst() {
		getPageInfo();
		setAttr("collist", new String[]{"客户代码","客户名称","客户类别","客户级别"});
		render("lookup.html");
	}
	
	private void getPageInfo() {
		StringBuffer whee=new StringBuffer();
		List<Object> param=new ArrayList<Object>();
		String name=getPara("clientname");
		if(name!=null&&!"".equals(name.trim())){
			whee.append(" and p.clientname like ?");
			param.add("%"+name+"%");
		}
		setAttr("clientname", name);
		
		String num=getPara("clientcode");
		if(num!=null&&!"".equals(num.trim())){
			whee.append(" and p.clientcode = ?");
			param.add(num);
		}
		setAttr("clientcode", num);
	//	setAttr(OrgSelectTarget.targetName,new OrgSelectTarget());
	//	setAttr(PartmentSelectTarget.targetName,new PartmentSelectTarget());
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.clientcode 客户代码, p.clientname 客户名称,p.typeno 客户类别,p.ClientLevelNo 客户级别,p.stopflag 停用,p.remark 备注",
				" from  jbclient p where 1=1  "+whee.toString(),param.toArray()));
	}
	
	public void add() {
		Jbclient xtts = new Jbclient();
		Long id = getParaToLong(0, 0L);
		if (id != 0) { // 修改
			xtts = Jbclient.dao.findById(id);
		}
        
		setAttr("xtts", xtts);		
		render("add.html");
	}
	public void save() {
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
	}
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			Jbclient.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
