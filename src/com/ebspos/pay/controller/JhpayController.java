package com.ebspos.pay.controller;

import java.util.ArrayList;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.controller.BaseController;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;

/**
 * 付款单资料
 * @author 熊涛
 * 2013.11.21
 *
 */
@RouteBind(path="/jhpay")
@Before({ManagerPowerInterceptor.class})
public class JhpayController extends BaseController {
	
	public static Logger log = Logger.getLogger(JhpayController.class);
	private static String navTabId = "jhpay";
	private byte[] lock = new byte[0];
	
	@Override
	public void index() {
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String startTime = getPara("startTime");
		if(startTime!=null&&!"".equals(startTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(p.orderdate) >= UNIX_TIMESTAMP(?)");
			param.add(startTime);
		}
		setAttr("startTime", startTime);
		String endTime = getPara("endTime");
		if(endTime!=null&&!"".equals(endTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(p.orderdate) <= UNIX_TIMESTAMP(?)");
			param.add(endTime);
		}
		setAttr("endTime", endTime);
		String supplierCode = getPara("supplier.supplierCode");
		if(supplierCode!=null && !"".equals(supplierCode.trim())){
			whee.append(" and p.supplierCode = ?");
			param.add(Long.parseLong(supplierCode));
		}
		setAttr("supplierCode", supplierCode);
		setAttr("supplierName", getPara("supplier.supplierName"));
		
		String sql = " from jhpay p  left join  jbsupplier b on p.SupplierNo = b.supplierCode ";
		sql += " left join  employee d on d.usr_no = p.EmployeeNo ";
		sql += " left join  partment e on e.id = p.DepartmentNo ";
		sql +=" where 1=1 ";
		setAttr("collist", new String[]{"付款单号","付款日期","供应商","业务员","部门","审核","备注"});
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.OrderNo 付款单号, p.OrderDate 付款日期, p.CheckFlag 审核, p.PayType,p.remark 备注, b.supplierName 供应商,d.usr_name 业务员, e.`name` 部门 ",
				sql + whee.toString(),param.toArray()));
		render("index.html");
	}
	
	public void select() {
		
		
	}
	
	public void add() {
		
		
	}

}
