package com.ebspos.pay.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.ckjh.model.Ckjhcheck;
import com.ebspos.controller.BaseController;
import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.InOutTypeNoSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.ftl.PayTypeNoSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbstore;
import com.ebspos.model.Jbsupplier;
import com.ebspos.pay.model.Jhpay;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.util.BsUtil;
import com.util.DateUtil;

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
		
		String sql = " from jhpay p  left join  jbsupplier b on p.SupplierCode = b.supplierCode ";
		sql += " left join  employee d on d.usr_no = p.EmpCode ";
		sql += " left join  partment e on e.id = p.DeptCode ";
		sql +=" where 1=1 ";
		setAttr("collist", new String[]{"付款单号","付款日期","供应商","业务员","部门","审核","备注"});
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.OrderCode 付款单号, p.OrderDate 付款日期, p.CheckFlag 审核, p.PayType,p.remark 备注, b.supplierName 供应商,d.usr_name 业务员, e.`name` 部门 ",
				sql + whee.toString(),param.toArray()));
		render("index.html");
	}
	
	public void selected() {
		// 付款单号
		String ordCdNw = null;
		String orderNos = getPara();
		Jhpay jhpay = getModel(Jhpay.class,"jhpay");
		Jbsupplier jbsupplier = new Jbsupplier();
		if (getRequest().getParameter("supplierCode") != null) {
			jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", getRequest().getParameter("supplierCode"));
		}
		if (orderNos != null) {
			String[] orderLst = orderNos.split(",");
			String param = "(";
			for (int i = 0; i < orderLst.length; i++) {
				if (orderLst[i].equals("on")) {
					continue;
				}
				param += orderLst[i].replace("{OrderNo:", "").replace("}", "") + ",";
			}
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","CF","jhpay");
			}
			jhpay.set("OrderCode", ordCdNw);
			jhpay.set("OrderDate", DateUtil.date2String(new Date(), DateUtil.FORMAT_DATE));
			param = param.substring(0,param.length() - 1) + ")";
			String sql = "select b.id,b.OrderNo 单据编号, a.OrderDate 单据日期,if(strcmp(left(b.OrderNo,2) =0 ,'PK'),'采购入库单','采购退库单') 单据类型,'" + ordCdNw +"' 付款单号,b.amount 单据金额,b.payAmount 已付金额,b.remark 备注 ";
			String sqlSelect = "  from ckjhcheckDetail b inner join ckjhcheck a on a.OrderNo = b.OrderNo "; 
			sqlSelect += " where 1=1 ";
			Page<Record> redLst = Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
					sql, sqlSelect + " and b.OrderNo in " + param + " group by b.OrderNo ");
			setAttr("page", redLst);
		}
		setAttr("collist", new String[]{"单据类型","单据编号","单据日期","单据金额","已付金额","本次付款金额","抹零金额","本次实际付款额"});
		setAttr("jhpay", jhpay);
		if (jbsupplier == null) jbsupplier = new Jbsupplier();
		setAttr("supplier", jbsupplier);
		setAttr(PayTypeNoSelectTarget.targetName, new PayTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		render("add.html");
	}
	
	public void add() {
		Jhpay jhpay = new Jhpay();
		Jbsupplier jbsupplier = new Jbsupplier();
		// 付款单号
		String ordCdNw = null;
		// 不是采购订单导入
		Long id = getParaToLong(0, 0L);
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.OrderCode = ?");
		if (id != 0) { // 修改
			jhpay = Jhpay.dao.findById(id);
			jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", jhpay.getStr("supplierCode"));
			param.add(jhpay.get("OrderCode"));
		} else {
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","CF","jhpay");
			}
			jhpay.set("OrderCode", ordCdNw);
			param.add(ordCdNw);
			// 默认日期
			jhpay.set("OrderDate", DateUtil.date2String(new Date(), DateUtil.FORMAT_DATE));
		}
		String sql = "select a.id,a.OrderCode 单据编号,a.CollateType 单据类型,a.PayOrderNo 付款单号,b.amount 单据金额,a.NowCollated 本次付款金额,a.Adjust 抹零金额,a.Amount 已付金额,a.remark 备注";
		String sqlSelect = " from jhpayDetail a inner join ckjhcheckDetail b on a.OrderCode = b.OrderNo"; 
		sqlSelect += " where 1=1 ";
		Page<Record> redLst = Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString(),param.toArray());
		setAttr("page", redLst);
		setAttr("collist", new String[]{"单据类型","单据编号","单据日期","单据金额","已付金额","本次付款金额","抹零金额","本次实际付款额"});
		setAttr("jhpay", jhpay);
		setAttr("supplier", jbsupplier);
		setAttr(PayTypeNoSelectTarget.targetName, new PayTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		render("add.html");
	}
	
	public void save() {
		Jhpay jhpay = getModel(Jhpay.class,"jhpay");
		
		
		
	}

}
