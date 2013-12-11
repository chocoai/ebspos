package com.ebspos.ck.controller;

import java.util.ArrayList;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.controller.BaseController;
import com.ebspos.controller.JbsupplierController;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;

@RouteBind(path="/ckcurrstore")
@Before({ManagerPowerInterceptor.class})
public class CkcurrstoreController extends BaseController {
	public static Logger log = Logger.getLogger(CkcurrstoreController.class);
	private static String navTabId = "ckcurrstore";
	@Override
	public void index() {
		getPageInfo();
		setAttr("collist", new String[]{"商品编号","商品名称","规格","单位","库存数量","成本单价","金额","仓库","备注"});
		render("index.html");

	}
	private void getPageInfo() {
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String storecode=getPara("storecode");
		if(storecode!=null && !"".equals(storecode.trim())){
			whee.append(" and ck.storecode like ?");
			param.add("%"+storecode+"%");			
		}
		String goodscode=getPara("goodscode");
		if(goodscode!=null && !"".equals(goodscode.trim())){
			whee.append(" and ck.goodscode like ?");
			param.add("%"+goodscode+"%");			
		}
		setAttr("storecode",storecode);
		setAttr("goodscode",goodscode);
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select ck.id, g.goodscode 商品编号,g.goodsname 商品名称,g.model 规格,g.baseunit 单位,ck.quantity 库存数量,ck.costprice 成本单价, " +
				"ck.amount 金额,s.storename 仓库,ck.remark 备注  ",
				"  from ckcurrstore ck left join jbgoods g on ck.goodscode = g.goodscode  " +
				" left join jbstore s on ck.storecode = s.storecode  where 1=1  "+whee.toString(),param.toArray()));
	}

}
