package com.ebspos.pay.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.cg.model.Cgorder;
import com.ebspos.ckjh.model.Ckjhcheck;
import com.ebspos.ckjh.model.Ckjhcheckdetail;
import com.ebspos.controller.BaseController;
import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.InOutTypeNoSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.ftl.PayTypeNoSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbgoods;
import com.ebspos.model.Jbstore;
import com.ebspos.model.Jbsupplier;
import com.ebspos.pay.model.Jhpay;
import com.ebspos.pay.model.Jhpaydetail;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
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
			String sql = "select b.id,b.OrderCode 单据编号, a.OrderDate 单据日期,if(strcmp(left(b.OrderCode,2) =0 ,'PK'),'采购入库单','采购退库单') 单据类型,'" + ordCdNw +"' 付款单号,sum(b.amount) 单据金额,sum(a.payAmount) 已付金额,b.remark 备注 ";
			String sqlSelect = "  from ckjhcheckDetail b inner join ckjhcheck a on a.OrderCode = b.OrderCode "; 
			sqlSelect += " where 1=1 ";
			Page<Record> redLst = Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
					sql, sqlSelect + " and b.OrderCode in " + param + " group by b.OrderCode ");
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
		whee.append(" and a.PayOrderNo = ?");
		if (id != 0) { // 修改
			jhpay = Jhpay.dao.findById(id);
			jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", jhpay.getStr("supplierCode"));
			param.add(jhpay.get("OrderCode"));
			setAttr("advamount", jbsupplier.getBigDecimal("AdvanceAmount"));
			if (jhpay.getInt("PayType") == BsUtil.ADV_TO_NEED_PAY)  {
				// 预付冲应付：付款金额 = 预付款
				setAttr("paymount", jbsupplier.getBigDecimal("AdvanceAmount"));
			} else {
				// 付款金额
				setAttr("paymount",0);
			}
		} else {
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","CF","jhpay");
			}
			jhpay.set("OrderCode", ordCdNw);
			param.add(ordCdNw);
			// 默认日期
			jhpay.set("OrderDate", DateUtil.date2String(new Date(), DateUtil.FORMAT_DATE));
			//制单人
			Record m=getCurrentUser();
			jhpay.set("Operator", m.getStr("usr_name"));
		}
		String sql = "select a.id,a.OrderCode 单据编号,a.CollateType 单据类型,a.PayOrderNo 付款单号,sum(b.ckamount) 单据金额,0 本次付款金额,0 抹零金额,sum(b.payAmount) 已付金额,a.remark 备注";
		String sqlSelect = " from jhpayDetail a inner join ckjhcheck b on a.OrderCode = b.OrderCode";
		sqlSelect += " where 1=1 ";
		Page<Record> redLst = Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString() + " group by b.OrderCode ",param.toArray());
		setAttr("page", redLst);
		setAttr("collist", new String[]{"单据类型","单据编号","单据日期","单据金额","已付金额","本次付款金额","抹零金额","本次实际付款额"});
		setAttr("jhpay", jhpay);
		setAttr("supplier", jbsupplier);
		setAttr(PayTypeNoSelectTarget.targetName, new PayTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		render("add.html");
	}
	
	@Before(Tx.class)
	public void save() {
		try {
			boolean exist = false;
			Jhpay jhpay = getModel(Jhpay.class,"jhpay");
			List<Jhpay> existJhpay = Jhpay.dao.find("select * from jhpay where OrderCode = ?", jhpay.getStr("OrderCode"));
			if (existJhpay != null && existJhpay.size() > 0) {
				exist = true;
			}
			Jbsupplier jbsupplier = getModel(Jbsupplier.class,"supplier");
			Double amount = Double.parseDouble(getPara("amount"));
			if (jhpay.getInt("PayType") == BsUtil.NEED_PAY) {
				int size = 100;
				for (int i=0; i<size; i++) {
					Jhpaydetail md = getModel(Jhpaydetail.class, "jpaydetail" + i);
					Ckjhcheckdetail r = Ckjhcheckdetail.dao.findById(md.getLong("id"));
					// 超过条数退出
					if(r == null) break;
					md.set("PayOrderNo", jhpay.get("OrderCode"));
					// 单据类型
					md.set("CollateType", jhpay.getInt("PayType"));
					List<Jhpaydetail> jhpaydetail = Jhpaydetail.dao.find("select * from jhpaydetail where OrderCode = ? and PayOrderNo = ?", md.getStr("OrderCode"),md.getStr("PayOrderNo"));
					if (jhpaydetail != null && jhpaydetail.size() > 0) {
                       md.update();						
					} else {
						md.save();
					}
					r.update();
				}
			} else if (jhpay.getInt("PayType") == BsUtil.ADV_PAY) {
				
			} else if (jhpay.getInt("PayType") == BsUtil.ADV_TO_NEED_PAY) {
				// 预付冲应付
				amount = jbsupplier.getDouble("AdvanceAmount");
				int size = 100;
				for (int i=0; i<size; i++) {
					Jhpaydetail md = getModel(Jhpaydetail.class, "jpaydetail" + i);
					if(md == null) break;
					Ckjhcheck r = Ckjhcheck.dao.findById(md.getDouble("id"));
					md.set("PayOrderNo", jhpay.get("OrderCode"));
					// 单据类型
					md.set("CollateType", jhpay.getInt("PayType"));
					List<Jhpaydetail> jhpaydetail = Jhpaydetail.dao.find("select * from jhpaydetail where OrderCode = ? and PayOrderNo = ?", md.getStr("OrderCode"),md.getStr("PayOrderNo"));
					if (jhpaydetail != null && jhpaydetail.size() > 0) {
                       md.update();						
					} else {
						md.save();
					}
					r.update();
				}
			} else if (jhpay.getInt("PayType") == BsUtil.NEED_TO_ADV_PAY) {
				
			} else if (jhpay.getInt("PayType") == BsUtil.DIR_PAY) {
			
			}
			// 付款单主表jhpay金额
			jhpay.set("Amount", amount);
			// 供应商
			jhpay.set("SupplierCode", jbsupplier.getStr("supplierCode"));
			if (exist) {
                jhpay.update();				
			} else {
				jhpay.save();
			}
			toDwzJson(200, "保存成功！", navTabId,"closeCurrent");
		} catch (Exception e) {
			log.error("保存仓库分类异常", e);
			toDwzJson(300, "保存异常！");
		}
	}
	
	// 审核
	public void review() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Jhpay jhpay = Jhpay.dao.findById(id);
				if (jhpay.getInt("CheckFlag") == null || jhpay.getInt("CheckFlag") != 1) {
					// 应付款
					Jbsupplier jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", jhpay.getStr("SupplierCode"));
					if (jhpay.getInt("PayType") == BsUtil.NEED_PAY) {
						// 更新供应商的应付款：jbsupplier.needpay=jbsupplier.needpay-jhpay.amount
						jbsupplier.set("needpay", BsUtil.plus(jbsupplier.getBigDecimal("needpay"), jhpay.getBigDecimal("amount")));
						List<Jhpaydetail> mds = Jhpaydetail.dao.find("select * from jhpaydetail where PayOrderNo = ?", jhpay.getStr("OrderCode"));
						for (int i=0; i<mds.size(); i++) {
							Jhpaydetail md = mds.get(i);
							Ckjhcheckdetail r = Ckjhcheckdetail.dao.findById(md.getLong("id"));
							// 超过条数退出
							if(r == null) break;
							// 更新采购入/退库单的已付金额：ckjhcheck.payAmount=chjhcheck.payAmount+jhPayDetail. NowCollated(本次核销金额)
							r.set("payAmount", BsUtil.add(r.getBigDecimal("payAmount"),md.getBigDecimal("NowCollated"),md.getBigDecimal("Adjust")));
							r.update();
						}
					} else if (jhpay.getInt("PayType") == BsUtil.ADV_PAY) {
						// 预付款
						// 更新供应商预付款：jbsupplier. AdvanceAmount =jbsupplier. AdvanceAmount +jhpay.amount
						jbsupplier.set("AdvanceAmount", BsUtil.add(jbsupplier.getBigDecimal("AdvanceAmount"),jhpay.getBigDecimal("amount")));
					} else if (jhpay.getInt("PayType") == BsUtil.ADV_TO_NEED_PAY) {
						// 预付冲应付
						// 应付款
						jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", jbsupplier.getStr("supplierCode"));
						// 更新供应商的应付款：jbsupplier.needpay=jbsupplier.needpay-jhpay.amount
						jbsupplier.set("needpay", BsUtil.plus(jbsupplier.getBigDecimal("needpay"), jbsupplier.getBigDecimal("AdvanceAmount")));
						List<Jhpaydetail> mds = Jhpaydetail.dao.find("select * from jhpaydetail where PayOrderNo = ?", jhpay.getStr("OrderCode"));
						for (int i=0; i<mds.size(); i++) {
							Jhpaydetail md = mds.get(i);
							if(md == null) break;
							Ckjhcheck r = Ckjhcheck.dao.findById(md.getDouble("id"));
							// 更新采购入/退库单的已付金额：ckjhcheck.payAmount=chjhcheck.payAmount+jhPayDetail. NowCollated(本次核销金额)
							r.set("payAmount", BsUtil.add(r.getBigDecimal("payAmount"),md.getBigDecimal("NowCollated"),md.getBigDecimal("Adjust")));
							// 单据类型
							r.set("CollateType", jhpay.getInt("PayType"));
							r.save();
						}
					} else if (jhpay.getInt("PayType") == BsUtil.NEED_TO_ADV_PAY) {
						// 应付转预付
						// 审核过后供应商的应付款增加，同时供应商的预付账款也增加。
						jbsupplier.set("needpay", BsUtil.add(jbsupplier.getBigDecimal("needpay"),jhpay.getBigDecimal("amount")));
						jbsupplier.set("AdvanceAmount", BsUtil.add(jbsupplier.getBigDecimal("AdvanceAmount"),jhpay.getBigDecimal("amount")));
					} else if (jhpay.getInt("PayType") == BsUtil.DIR_PAY) {
						// 直接付款
						// 审核过后将冲减供应商的应付款。
						jbsupplier.set("needpay", BsUtil.plus(jbsupplier.getBigDecimal("needpay"),jhpay.getBigDecimal("amount")));
					}
					jbsupplier.update();
					jhpay.set("CheckFlag",1);
					jhpay.update();
					toDwzJson(200, "审核通过！", navTabId);
				}
			}
		} catch (Exception e) {
			toDwzJson(300, "审核失败！");
		}
	}
	
	// 未审核
	public void unreview() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Jhpay jhpay = Jhpay.dao.findById(id);
				if (jhpay.getInt("CheckFlag") == null || jhpay.getInt("CheckFlag") != 0) {
					// 应付款
					Jbsupplier jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", jhpay.getStr("SupplierCode"));
					if (jhpay.getInt("PayType") == BsUtil.NEED_PAY) {
						// 更新供应商的应付款：jbsupplier.needpay=jbsupplier.needpay-jhpay.amount
						jbsupplier.set("needpay", BsUtil.add(jbsupplier.getBigDecimal("needpay"), jhpay.getBigDecimal("amount")));
						List<Jhpaydetail> mds = Jhpaydetail.dao.find("select * from jhpaydetail where PayOrderNo = ?", jhpay.getStr("OrderCode"));
						for (int i=0; i<mds.size(); i++) {
							Jhpaydetail md = mds.get(i);
							Ckjhcheckdetail r = Ckjhcheckdetail.dao.findById(md.getLong("id"));
							// 超过条数退出
							if(r == null) break;
							// 更新采购入/退库单的已付金额：ckjhcheck.payAmount=chjhcheck.payAmount+jhPayDetail. NowCollated(本次核销金额)
							r.set("payAmount", BsUtil.plus(r.getBigDecimal("payAmount"),md.getBigDecimal("NowCollated"),md.getBigDecimal("Adjust")));
							r.update();
						}
					} else if (jhpay.getInt("PayType") == BsUtil.ADV_PAY) {
						// 预付款
						// 更新供应商预付款：jbsupplier. AdvanceAmount =jbsupplier. AdvanceAmount +jhpay.amount
						jbsupplier.set("AdvanceAmount", BsUtil.plus(jbsupplier.getBigDecimal("AdvanceAmount"),jhpay.getBigDecimal("amount")));
					} else if (jhpay.getInt("PayType") == BsUtil.ADV_TO_NEED_PAY) {
						// 预付冲应付
						// 应付款
						jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", jbsupplier.getStr("supplierCode"));
						// 更新供应商的应付款：jbsupplier.needpay=jbsupplier.needpay-jhpay.amount
						jbsupplier.set("needpay", BsUtil.add(jbsupplier.getBigDecimal("needpay"), jbsupplier.getBigDecimal("AdvanceAmount")));
						List<Jhpaydetail> mds = Jhpaydetail.dao.find("select * from jhpaydetail where PayOrderNo = ?", jhpay.getStr("OrderCode"));
						for (int i=0; i<mds.size(); i++) {
							Jhpaydetail md = mds.get(i);
							if(md == null) break;
							Ckjhcheck r = Ckjhcheck.dao.findById(md.getDouble("id"));
							// 更新采购入/退库单的已付金额：ckjhcheck.payAmount=chjhcheck.payAmount+jhPayDetail. NowCollated(本次核销金额)
							r.set("payAmount", BsUtil.plus(r.getBigDecimal("payAmount"),md.getBigDecimal("NowCollated"),md.getBigDecimal("Adjust")));
							// 单据类型
							r.set("CollateType", jhpay.getInt("PayType"));
							r.save();
						}
					} else if (jhpay.getInt("PayType") == BsUtil.NEED_TO_ADV_PAY) {
						// 应付转预付
						// 审核过后供应商的应付款增加，同时供应商的预付账款也增加。
						jbsupplier.set("needpay", BsUtil.plus(jbsupplier.getBigDecimal("needpay"),jhpay.getBigDecimal("amount")));
						jbsupplier.set("AdvanceAmount", BsUtil.plus(jbsupplier.getBigDecimal("AdvanceAmount"),jhpay.getBigDecimal("amount")));
					} else if (jhpay.getInt("PayType") == BsUtil.DIR_PAY) {
						// 直接付款
						// 审核过后将冲减供应商的应付款。
						jbsupplier.set("needpay", BsUtil.add(jbsupplier.getBigDecimal("needpay"),jhpay.getBigDecimal("amount")));
					}
					jbsupplier.update();
					if (jhpay.getInt("CheckFlag") == null || jhpay.getInt("CheckFlag") != 0) {
						jhpay.set("CheckFlag",0);
					}
					jhpay.update();
					toDwzJson(200, "反审核通过！", navTabId);
				}
			}
		} catch (Exception e) {
			toDwzJson(300, "反审核失败！");
		}
	}
	
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Jhpay r = Jhpay.dao.findById(id);
				Jhpay.dao.deleteById(id);
				Db.update("delete from jhpaydetail where PayOrderNo=?", r.getStr("OrderCode"));
			}
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
