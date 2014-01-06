package com.ebspos.xsReceive.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.ckxscheck.model.Ckxscheck;
import com.ebspos.ckxscheck.model.CkxscheckDetail;
import com.ebspos.controller.BaseController;
import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.ftl.ReceiveTypeNoSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbclient;
import com.ebspos.xsReceive.model.XsReceive;
import com.ebspos.xsReceive.model.XsReceiveDetail;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.util.BsUtil;
import com.util.DateUtil;

/**
 * 销售付款单资料
 * @author 熊涛
 * 2013.11.21
 *
 */
@RouteBind(path="/xsReceive")
@Before({ManagerPowerInterceptor.class})
public class XsReceiveController extends BaseController {
	
	public static Logger log = Logger.getLogger(XsReceiveController.class);
	private static String navTabId = "xsReceive";
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
		String clientCode = getPara("client.ClientCode");
		if(clientCode!=null && !"".equals(clientCode.trim())){
			whee.append(" and p.clientCode = ?");
			param.add(clientCode);
		}
		setAttr("ClientCode", clientCode);
		setAttr("ClientName", getPara("client.ClientName"));
		
		String sql = " from xsReceive p  left join  jbclient b on p.clientCode = b.clientCode ";
		sql += " left join  employee d on d.usr_no = p.EmpCode ";
		sql += " left join  partment e on e.id = p.DeptCode ";
		sql +=" where 1=1 ";
		setAttr("collist", new String[]{"付款单号","付款日期","供应商","业务员","部门","审核","备注"});
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.OrderCode 付款单号, p.OrderDate 付款日期, p.CheckFlag 审核, p.repaytype,p.remark 备注, b.clientName 供应商,d.usr_name 业务员, e.`name` 部门 ",
				sql + whee.toString(),param.toArray()));
		render("index.html");
	}
	
	public void selected() {
		// 付款单号
		String ordCdNw = null;
		String orderNos = getPara();
		XsReceive xsReceive = getModel(XsReceive.class,"xsReceive");
		Jbclient jbclient = new Jbclient();
		if (getRequest().getParameter("clientCode") != null) {
			jbclient = Jbclient.dao.findFirst("select * from jbclient where clientCode = ?", getRequest().getParameter("clientCode"));
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
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","XF","xsReceive");
			}
			xsReceive.set("OrderCode", ordCdNw);
			xsReceive.set("OrderDate", DateUtil.date2String(new Date(), DateUtil.FORMAT_DATE));
			param = param.substring(0,param.length() - 1) + ")";
			String sql = "select b.id,b.OrderCode 单据编号, a.OrderDate 单据日期,if(strcmp(left(b.OrderCode,2) =0 ,'XC'),'销售出库单','销售退库单') 单据类型,'" + ordCdNw +"' 付款单号,sum(b.amount) 单据金额,sum(b.payAmount) 已付金额,b.Memo 备注 ";
			String sqlSelect = "  from ckxscheckdetail b inner join ckxscheck a on a.OrderCode = b.OrderCode "; 
			sqlSelect += " where 1=1 ";
			Page<Record> redLst = Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
					sql, sqlSelect + " and b.OrderCode in " + param + " group by b.OrderCode ");
			setAttr("page", redLst);
		}
		setAttr("collist", new String[]{"单据类型","单据编号","单据日期","单据金额","已付金额","本次付款金额","抹零金额","本次实际付款额"});
		setAttr("xsReceive", xsReceive);
		if (jbclient == null) jbclient = new Jbclient();
		setAttr("client", jbclient);
		setAttr(ReceiveTypeNoSelectTarget.targetName, new ReceiveTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	public void add() {
		XsReceive xsReceive = new XsReceive();
		Jbclient jbclient = new Jbclient();
		// 付款单号
		String ordCdNw = null;
		// 不是采购订单导入
		Long id = getParaToLong(0, 0L);
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.PayOrderNo = ?");
		if (id != 0) { // 修改
			xsReceive = XsReceive.dao.findById(id);
			jbclient = Jbclient.dao.findFirst("select * from jbclient where clientCode = ?", xsReceive.getStr("clientCode"));
			param.add(xsReceive.get("OrderCode"));
			setAttr("advamount", jbclient.getBigDecimal("AdvanceAmount"));
			if (xsReceive.getInt("repaytype") == BsUtil.ADV_TO_NEED_PAY)  {
				// 预付冲应付：付款金额 = 预付款
				setAttr("paymount", jbclient.getBigDecimal("AdvanceAmount"));
			} else {
				// 付款金额
				setAttr("paymount",0);
			}
		} else {
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","XF","xsReceive");
			}
			xsReceive.set("OrderCode", ordCdNw);
			param.add(ordCdNw);
			// 默认日期
			xsReceive.set("OrderDate", DateUtil.date2String(new Date(), DateUtil.FORMAT_DATE));
		}
		String sql = "select a.id,a.OrderCode 单据编号,a.CollateType 单据类型,a.PayOrderNo 付款单号,sum(b.amount) 单据金额,0 本次付款金额,0 抹零金额,sum(b.payAmount) 已付金额,a.remark 备注";
		String sqlSelect = " from xsreceivedetail a inner join ckxscheckdetail b on a.OrderCode = b.OrderCode";
		sqlSelect += " where 1=1 ";
		Page<Record> redLst = Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString() + " group by b.OrderCode ",param.toArray());
		setAttr("page", redLst);
		setAttr("collist", new String[]{"单据类型","单据编号","单据日期","单据金额","已付金额","本次付款金额","抹零金额","本次实际付款额"});
		setAttr("xsReceive", xsReceive);
		setAttr("client", jbclient);
		setAttr(ReceiveTypeNoSelectTarget.targetName, new ReceiveTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	@Before(Tx.class)
	public void save() throws Exception {
		try {
			boolean exist = false;
			XsReceive xsReceive = getModel(XsReceive.class,"xsReceive");
			List<XsReceive> existXsReceive = XsReceive.dao.find("select * from xsReceive where OrderCode = ?", xsReceive.getStr("OrderCode"));
			if (existXsReceive != null && existXsReceive.size() > 0) {
				exist = true;
			}
			Jbclient jbclient = getModel(Jbclient.class,"client");
			Double amount = Double.parseDouble(getPara("amount"));
			if (xsReceive.getInt("repaytype") == BsUtil.NEED_RECEIVE) {
				int size = 100;
				for (int i=0; i<size; i++) {
					XsReceiveDetail md = getModel(XsReceiveDetail.class, "xsReceivedetail" + i);
					CkxscheckDetail r = CkxscheckDetail.dao.findById(md.getLong("id"));
					// 超过条数退出
					if(r == null) break;
					md.set("PayOrderNo", xsReceive.get("OrderCode"));
					List<XsReceiveDetail> xsReceiveDetail = XsReceiveDetail.dao.find("select * from xsreceivedetail where OrderCode = ? and PayOrderNo = ?", md.getStr("OrderCode"),md.getStr("PayOrderNo"));
					if (xsReceiveDetail != null && xsReceiveDetail.size() > 0) {
                       md.update();						
					} else {
						md.save();
					}
					r.update();
				}
			} else if (xsReceive.getInt("repaytype") == BsUtil.ADV_RECEIVE) {
				
			} else if (xsReceive.getInt("repaytype") == BsUtil.ADV_TO_NEED_RECEIVE) {
				// 预付冲应付
				amount = jbclient.getDouble("AdvanceAmount");
				int size = 100;
				for (int i=0; i<size; i++) {
					XsReceiveDetail md = getModel(XsReceiveDetail.class, "xsReceivedetail" + i);
					if(md == null) break;
					Ckxscheck r = Ckxscheck.dao.findById(md.getDouble("id"));
					md.set("PayOrderNo", xsReceive.get("OrderCode"));
					List<XsReceiveDetail> xsReceiveDetail = XsReceiveDetail.dao.find("select * from xsReceiveDetail where OrderCode = ? and PayOrderNo = ?", md.getStr("OrderCode"),md.getStr("PayOrderNo"));
					if (xsReceiveDetail != null && xsReceiveDetail.size() > 0) {
                       md.update();						
					} else {
						md.save();
					}
					r.update();
				}
			} else if (xsReceive.getInt("repaytype") == BsUtil.NEED_TO_ADV_RECEIVE) {
				
			} else if (xsReceive.getInt("repaytype") == BsUtil.DIR_RECEIVE) {
			
			}
			// 付款单主表jhpay金额
			xsReceive.set("Amount", amount);
			// 供应商
			xsReceive.set("clientCode", jbclient.getStr("clientCode"));
			if (exist) {
                xsReceive.update();				
			} else {
				xsReceive.save();
			}
			toDwzJson(200, "保存成功！", navTabId,"closeCurrent");
		} catch (Exception e) {
			log.error("保存仓库分类异常", e);
			toDwzJson(300, "保存异常！");
			// 事务处理
			throw e;
		}
	}
	
	// 审核
	@Before(Tx.class)
	public void review() throws Exception {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				XsReceive xsReceive = XsReceive.dao.findById(id);
				if (xsReceive.getInt("CheckFlag") == null || xsReceive.getInt("CheckFlag") != 1) {
					// 应付款
					Jbclient jbclient = Jbclient.dao.findFirst("select * from jbclient where clientCode = ?", xsReceive.getStr("clientCode"));
					if (xsReceive.getInt("repaytype") == BsUtil.NEED_RECEIVE) {
						// 审核过后将冲减客户的应收款和单据的已收金额：jbclient.NeedRecive=jbclient.NeedRecive-xsReceive.amount
						jbclient.set("NeedRecive", BsUtil.plus(jbclient.getBigDecimal("NeedRecive"), xsReceive.getBigDecimal("amount")));
						List<XsReceiveDetail> mds = XsReceiveDetail.dao.find("select * from xsReceiveDetail where PayOrderNo = ?", xsReceive.getStr("OrderCode"));
						for (int i=0; i<mds.size(); i++) {
							XsReceiveDetail md = mds.get(i);
							CkxscheckDetail r = CkxscheckDetail.dao.findById(md.getLong("id"));
							// 超过条数退出
							if(r == null) break;
							// 更新销售入/退库单的已付金额：CkxscheckDetail.payAmount=CkxscheckDetail.payAmount+XsReceiveDetail.NowCollated(本次核销金额)
							r.set("payAmount", BsUtil.add(r.getBigDecimal("payAmount"),md.getBigDecimal("NowCollated"),md.getBigDecimal("Adjust")));
							r.update();
						}
					} else if (xsReceive.getInt("repaytype") == BsUtil.ADV_RECEIVE) {
						// 预付款
						// 更新供应商预付款：jbclient. AdvanceAmount =jbclient. AdvanceAmount +xsReceive.amount
						jbclient.set("AdvanceAmount", BsUtil.add(jbclient.getBigDecimal("AdvanceAmount"),xsReceive.getBigDecimal("amount")));
					} else if (xsReceive.getInt("repaytype") == BsUtil.ADV_TO_NEED_RECEIVE) {
						// 预收冲应收
						// 应付款
						jbclient = Jbclient.dao.findFirst("select * from jbclient where clientCode = ?", jbclient.getStr("clientCode"));
						// 更新供应商的应付款：jbclient.needpay=jbclient.needpay-xsReceive.amount
						jbclient.set("NeedRecive", BsUtil.plus(jbclient.getBigDecimal("needpay"), jbclient.getBigDecimal("AdvanceAmount")));
						List<XsReceiveDetail> mds = XsReceiveDetail.dao.find("select * from xsReceiveDetail where PayOrderNo = ?", xsReceive.getStr("OrderCode"));
						for (int i=0; i<mds.size(); i++) {
							XsReceiveDetail md = mds.get(i);
							if(md == null) break;
							Ckxscheck r = Ckxscheck.dao.findById(md.getDouble("id"));
							// 更新销售出库单的已付金额：ckxscheck.payAmount=chxscheck.payAmount+xsReceiveDetail.NowCollated(本次核销金额)
							r.set("payAmount", BsUtil.add(r.getBigDecimal("payAmount"),md.getBigDecimal("NowCollated"),md.getBigDecimal("Adjust")));
							// 单据类型
							r.set("CollateType", xsReceive.getInt("repaytype"));
							r.save();
						}
					} else if (xsReceive.getInt("repaytype") == BsUtil.NEED_TO_ADV_RECEIVE) {
						// 应收转预收
						// 审核过后客户的应付款减少，预付款增加。
						jbclient.set("NeedRecive", BsUtil.plus(jbclient.getBigDecimal("needpay"),xsReceive.getBigDecimal("amount")));
						jbclient.set("AdvanceAmount", BsUtil.add(jbclient.getBigDecimal("AdvanceAmount"),xsReceive.getBigDecimal("amount")));
					} else if (xsReceive.getInt("repaytype") == BsUtil.DIR_RECEIVE) {
						// 直接付款
						// 审核过后将冲减供应商的应付款。
						jbclient.set("NeedRecive", BsUtil.plus(jbclient.getBigDecimal("needpay"),xsReceive.getBigDecimal("amount")));
					}
					jbclient.update();
					xsReceive.set("CheckFlag",1);
					xsReceive.update();
				}
				toDwzJson(200, "审核通过！", navTabId);
			}
		} catch (Exception e) {
			toDwzJson(300, "审核失败！");
			// 事务处理
			throw e;
		}
	}
	
	// 未审核
	@Before(Tx.class)
	public void unreview() throws Exception {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				XsReceive xsReceive = XsReceive.dao.findById(id);
				if (xsReceive.getInt("CheckFlag") == null || xsReceive.getInt("CheckFlag") != 0) {
					// 应付款
					Jbclient jbclient = Jbclient.dao.findFirst("select * from jbclient where clientCode = ?", xsReceive.getStr("clientCode"));
					if (xsReceive.getInt("repaytype") == BsUtil.NEED_RECEIVE) {
						// 更新客户的应付款：jbclient.needpay=jbclient.needpay-xsReceive.amount
						jbclient.set("NeedRecive", BsUtil.add(jbclient.getBigDecimal("needpay"), xsReceive.getBigDecimal("amount")));
						List<XsReceiveDetail> mds = XsReceiveDetail.dao.find("select * from xsReceiveDetail where PayOrderNo = ?", xsReceive.getStr("OrderCode"));
						for (int i=0; i<mds.size(); i++) {
							XsReceiveDetail md = mds.get(i);
							CkxscheckDetail r = CkxscheckDetail.dao.findById(md.getLong("id"));
							// 超过条数退出
							if(r == null) break;
							// 更新采购入/退库单的已付金额：ckxscheck.payAmount=chxscheck.payAmount+xsReceiveDetail.NowCollated(本次核销金额)
							r.set("payAmount", BsUtil.plus(r.getBigDecimal("payAmount"),md.getBigDecimal("NowCollated"),md.getBigDecimal("Adjust")));
							r.update();
						}
					} else if (xsReceive.getInt("repaytype") == BsUtil.ADV_RECEIVE) {
						// 预付款
						// 更新供应商预付款：jbclient.AdvanceAmount=jbclient.AdvanceAmount+xsReceive.amount
						jbclient.set("AdvanceAmount", BsUtil.plus(jbclient.getBigDecimal("AdvanceAmount"),xsReceive.getBigDecimal("amount")));
					} else if (xsReceive.getInt("repaytype") == BsUtil.ADV_TO_NEED_RECEIVE) {
						// 预付冲应付
						// 应付款
						jbclient = Jbclient.dao.findFirst("select * from jbclient where clientCode = ?", jbclient.getStr("clientCode"));
						// 更新供应商的应付款：jbclient.needpay=jbclient.needpay-xsReceive.amount
						jbclient.set("NeedRecive", BsUtil.add(jbclient.getBigDecimal("needpay"), jbclient.getBigDecimal("AdvanceAmount")));
						List<XsReceiveDetail> mds = XsReceiveDetail.dao.find("select * from xsReceiveDetail where PayOrderNo = ?", xsReceive.getStr("OrderCode"));
						for (int i=0; i<mds.size(); i++) {
							XsReceiveDetail md = mds.get(i);
							if(md == null) break;
							Ckxscheck r = Ckxscheck.dao.findById(md.getDouble("id"));
							// 更新销售入/退库单的已付金额：ckxscheck.payAmount=chxscheck.payAmount+xsReceiveDetail.NowCollated(本次核销金额)
							r.set("payAmount", BsUtil.plus(r.getBigDecimal("payAmount"),md.getBigDecimal("NowCollated"),md.getBigDecimal("Adjust")));
							// 单据类型
							r.set("CollateType", xsReceive.getInt("repaytype"));
							r.save();
						}
					} else if (xsReceive.getInt("repaytype") == BsUtil.NEED_TO_ADV_RECEIVE) {
						// 应付转预付
						// 审核过后客户的应付款减少，预付款增加。
						jbclient.set("NeedRecive", BsUtil.add(jbclient.getBigDecimal("needpay"),xsReceive.getBigDecimal("amount")));
						jbclient.set("AdvanceAmount", BsUtil.plus(jbclient.getBigDecimal("AdvanceAmount"),xsReceive.getBigDecimal("amount")));
					} else if (xsReceive.getInt("repaytype") == BsUtil.DIR_RECEIVE) {
						// 直接付款
						// 审核过后将冲减供应商的应付款。
						jbclient.set("NeedRecive", BsUtil.add(jbclient.getBigDecimal("needpay"),xsReceive.getBigDecimal("amount")));
					}
					jbclient.update();
					if (xsReceive.getInt("CheckFlag") == null || xsReceive.getInt("CheckFlag") != 0) {
						xsReceive.set("CheckFlag",0);
					}
					xsReceive.update();
				}
				toDwzJson(200, "反审核通过！", navTabId);
			}
		} catch (Exception e) {
			toDwzJson(300, "反审核失败！");
			// 事务处理
			throw e;
		}
	}
	
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				XsReceive r = XsReceive.dao.findById(id);
				XsReceive.dao.deleteById(id);
				Db.update("delete from xsReceiveDetail where PayOrderNo=?", r.getStr("OrderCode"));
			}
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
