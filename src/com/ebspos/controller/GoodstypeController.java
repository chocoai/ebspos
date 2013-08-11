package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;
//import com.ebspos.ftl.OrgSelectTarget;
//import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.ftl.OrgSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Employee;
import com.ebspos.model.Goodstype;
import net.loyin.jFinal.anatation.RouteBind;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;

/**
 * 商品类别
 * @author 湛原红
 *2013-8-10
 */
@RouteBind(path = "/goodstype")
@Before({ManagerPowerInterceptor.class})
public class GoodstypeController extends BaseController {
	public static Logger log = Logger.getLogger(GoodstypeController.class);
	private static String navTabId = "goodstype";
	private boolean f;
	@Override
	public void index(){
		f = true;
		list();		
		setAttr("goodstype",Goodstype.dao.find("select id, name,num ,pid from goodstype order by id"));
		render("index.html");
	}
	public void list() {		
		Long goodstypeid = getParaToLong(0, 0L);
		StringBuffer whee=new StringBuffer();
		List<Object> param=new ArrayList<Object>();
		String name=getPara("name");
		if(name!=null&&!"".equals(name.trim())){
			whee.append(" and gt.name like ?");
			param.add("%"+name+"%");
		}
		setAttr("name", name);	
		
		String num=getPara("num");
		if(num!=null&&!"".equals(num.trim())){
			whee.append(" and gt.num = ?");
			param.add(num);
		}
		setAttr("num", num);
		if (goodstypeid !=0)
		{
			whee.append(" and gt.pid= ? or gt.id= ?");
			param.add(goodstypeid);
			param.add(goodstypeid);
		}
		setAttr("pid",goodstypeid);
	//	setAttr(OrgSelectTarget.targetName,new OrgSelectTarget());
	//	setAttr(PartmentSelectTarget.targetName,new PartmentSelectTarget());
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				"select gt.id,gt.pid 父类别,concat(gt.name,'[',gt.num,']') 商品类别,gt.remark 备注 ",
				" from  goodstype gt where 1=1 "+whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"父类别","商品类别","备注"});
		if (f == false)
			render("list.html");		
	}
	public void add() {
		Goodstype gt = new Goodstype();		
		Long pid = getParaToLong(0, 0L);		
		gt.set("pid", pid);		
		//if (id != 0) {
		//	pojo = Employee.dao.findById(id);
		//}
		//setAttr(OrgSelectTarget.targetName, new OrgSelectTarget());
		//setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr("gt", gt);
		render("add.html");
	}
	
	

}
