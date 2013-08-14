package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;
import net.loyin.jFinal.anatation.RouteBind;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
/**
 * 系统用表记录
 * @author 湛原红 
 * 2013.8.14
 *
 */
@RouteBind(path="/xttables")
@Before({ManagerPowerInterceptor.class})
public class XTTablesController extends BaseController {

	public static Logger log = Logger.getLogger(XTTablesController.class);
	private static String navTabId = "xttables";
	@Override
	public void index() {
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String tablename=getPara("tablename");
		if(tablename!=null && !"".equals(tablename.trim())){
			whee.append(" and tablename like ?");
			param.add("%"+tablename+"%");			
		}
		setAttr("tablename",tablename);
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				"select p.id,p.tablename 表英文名,(case p.ttype when 1 then 'JB' when 2 then 'JH' end) 类别, "+
				" p.tlevel 级别,p.ctablename 表中文名,p.remark 备注 ",
				" from  xttables p  where 1=1  "+whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"表英文名","类别","级别","表中文名","备注"});
		render("index.html");

	}

}
