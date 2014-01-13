package com.ebspos.ckjh.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.Proc.CkjhDbProc;
import com.ebspos.cg.model.Cgorder;
import com.ebspos.ckjh.model.Ckjhcheck;
import com.ebspos.ckjh.model.Ckjhcheckdetail;
import com.ebspos.controller.BaseController;
import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.InOutTypeNoSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.jhpay.model.Jhpay;
import com.ebspos.jhpay.model.Jhpaydetail;
import com.ebspos.model.Jbgoods;
import com.ebspos.model.Jbstore;
import com.ebspos.model.Jbsupplier;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.util.BsUtil;
import com.util.DateUtil;
/**
 * 采购入库单
 * @author 熊涛
 * 2013.9.25
 *
 */
@RouteBind(path="/ckjhcheck")
@Before({ManagerPowerInterceptor.class})
public class CkjhcheckController extends BaseController {
	public static Logger log = Logger.getLogger(CkjhcheckController.class);
	private static String navTabId = "ckjhcheck";
	private String supplierCodePara = null;
	private byte[] lock = new byte[0];
	@Override
	public void index() {
		select();
		render("index.html");
	}
	
	public void list() {
		supplierCodePara = getPara();
		select();
		render("list.html");
	}
	
	private void select() {
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String startTime = getPara("startTime");
		if(startTime!=null&&!"".equals(startTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(p.OrderDate) >= UNIX_TIMESTAMP(?)");
			param.add(startTime);
		}
		setAttr("startTime", startTime);
		String endTime = getPara("endTime");
		if(endTime!=null&&!"".equals(endTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(p.OrderDate) <= UNIX_TIMESTAMP(?)");
			param.add(endTime);
		}
		setAttr("endTime", endTime);
		String supplierCode = getPara("supplier.supplierCode");
		if (supplierCodePara != null)  supplierCode = supplierCodePara;
		if(supplierCode!=null && !"".equals(supplierCode.trim())){
			whee.append(" and p.SupplierCode = ?");
			param.add(Long.parseLong(supplierCode));
		}
		setAttr("supplierCode", supplierCode);
		setAttr("supplierName", getPara("supplier.supplierName"));
		
		String storeCd = getPara("store.StoreCode");
		if(storeCd!=null && !"".equals(storeCd.trim())){
			whee.append(" and p.StoreCode = ?");
			param.add(Long.parseLong(storeCd));
		}
		setAttr("StoreCode", storeCd);
		setAttr("StoreName", getPara("store.StoreName"));
		String sql = " from ckjhcheck p  left join  jbsupplier b on p.SupplierCode = b.supplierCode ";
		sql += " left join  jbstore c on p.StoreCode = c.StoreCode ";
		sql += " left join  employee d on d.usr_no = p.EmpCode ";
		sql += " left join  partment e on e.deptCode = p.deptCode ";
		sql += " left join  types t on t.id=p.inoutTypeNo and t.function='入库类型'";
		sql +=" where 1=1 ";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.OrderCode 订单号, p.OrderDate 进货日期,p.remark 备注, t.name 入库类型,p.BillOrderNo 采购单号,p.CKAmount 入库金额, p.payAmount 已付金额,p.checkflag 审核, b.supplierName 供应商,c.StoreName 订货仓库,d.usr_name 业务员, e.`name` 部门 ",
				sql + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","进货日期","供应商","业务员","部门","收货日期","订货仓库","入库类型","采购单号","入库金额","已付金额","审核","备注"});
	}
	
	// 采购入库
	public void cgInStore() {
		Ckjhcheck ckjhcheck = new Ckjhcheck();
		Jbsupplier jbsupplier = new Jbsupplier();
		Jbstore jbstore = new Jbstore();
		List<Object> param=new ArrayList<Object>();
		// 采购入库单号
		String ordCdNw = null;
		synchronized(lock) {
			ordCdNw = BsUtil.getMaxOrdNo("OrderCode","PK","ckjhcheck");
		}
		ckjhcheck.set("OrderCode", ordCdNw);
		String obj = getPara();
		Cgorder cgOrd = new Cgorder();
		cgOrd = Cgorder.dao.findFirst("select * from cgorder where orderCode = ?", new Object[]{obj});
		jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", cgOrd.getStr("supplierCode"));
		jbstore = Jbstore.dao.findFirst("select * from jbstore where StoreCode = ?", cgOrd.getStr("StoreCode"));
		//ckjhcheck.set("OrderCode", ordCdNw);
		ckjhcheck.set("OrderDate", cgOrd.getDate("DeliveryDate"));
		ckjhcheck.set("supplierCode", cgOrd.getStr("supplierCode"));
		ckjhcheck.set("StoreCode", cgOrd.getStr("StoreCode"));
		//ckjhcheck.set("InOutTypeNo", "52");
		ckjhcheck.set("BillOrderNo", cgOrd.getStr("orderCode"));
		ckjhcheck.set("deptCode", cgOrd.getStr("deptcode"));
		ckjhcheck.set("Empcode", cgOrd.getStr("Empcode"));
		ckjhcheck.set("Operator", cgOrd.getStr("Operator"));
		ckjhcheck.set("CheckFlag", 0);
		ckjhcheck.set("SettleTypeFlag", 0);
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.orderCode = ?");
		param.add(obj);
		String sql = "select a.id,b.GoodsCode 商品编号,b.GoodsName 商品名称,b.Model 商品规格,b.BaseUnit 基本单位,b.BRefPrice 原价,a.Discount 折扣, a.Quantity 数量,";
		sql += " a.TaxRate 税率,a.TaxAmount 税额,a.Amount 税后金额";
		String sqlSelect = " from cgorderdetail a"; 
		sqlSelect += " left join jbgoods b on a.GoodsCode = b.GoodsCode where 1=1 ";
		Page<Record> redLst = Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString(),param.toArray());
		int size = redLst.getList().size();
		// 不足10条，补足10条显示
		if ( size < 10) {
			for (int i = 0; i < 10 - size; i++) {
				redLst.getList().add(new Record());
			}
		}
		setAttr("page", redLst);
		setAttr("collist", new String[]{"商品编号","商品名称","商品规格","基本单位","原价","折扣%","单价","数量","税率%","折后金额","税后金额"});
		setAttr("ckjhcheck", ckjhcheck);
		setAttr("store", jbstore);
		setAttr("supplier", jbsupplier);
		setAttr(InOutTypeNoSelectTarget.targetName, new InOutTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	public void add() {
		Ckjhcheck ckjhcheck = new Ckjhcheck();
		Jbsupplier jbsupplier = new Jbsupplier();
		Jbstore jbstore = new Jbstore();
		// 采购入库单号
		String ordCdNw = null;
		// 不是采购订单导入
		Long id = getParaToLong(0, 0L);
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.OrderCode = ?");
		if (id != 0) { // 修改
			ckjhcheck = Ckjhcheck.dao.findById(id);
			jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", ckjhcheck.getStr("SupplierCode"));
			jbstore = Jbstore.dao.findFirst("select * from jbstore where StoreCode = ?", ckjhcheck.getStr("StoreCode"));
			param.add(ckjhcheck.get("orderCode"));
		} else {
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","PK","ckjhcheck");
			}
			ckjhcheck.set("OrderCode", ordCdNw);
			param.add(ordCdNw);
			//赋值当前时间
			Date dt=new Date();
			SimpleDateFormat ckDate=new SimpleDateFormat("yyyy-MM-dd");
			ckjhcheck.set("orderdate", ckDate.format(dt));
			//赋值制单人
			Record m=getCurrentUser();
			ckjhcheck.set("operator",m.getStr("usr_name"));
		}
		String sql = "select a.id,b.GoodsCode 商品编号,b.GoodsName 商品名称,b.Model 商品规格,b.BaseUnit 基本单位,b.BRefPrice 原价,a.Discount 折扣, a.Quantity 数量,";
		sql += " a.TaxRate 税率,a.TaxAmount 税额,a.Amount 金额";
		String sqlSelect = " from ckjhcheckdetail a"; 
		sqlSelect += " left join jbgoods b on a.GoodsCode = b.GoodsCode where 1=1 ";
		Page<Record> redLst = Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString(),param.toArray());
		int size = redLst.getList().size();
		// 不足10条，补足10条显示
		if ( size < 10) {
			for (int i = 0; i < 10 - size; i++) {
				redLst.getList().add(new Record());
			}
		}
		setAttr("page", redLst);
		setAttr("collist", new String[]{"商品编号","商品名称","商品规格","单位","原价","折扣%","数量","订单金额","税率%","税额","金额"});
		setAttr("ckjhcheck", ckjhcheck);
		setAttr("store", jbstore);
		setAttr("supplier", jbsupplier);
		setAttr(InOutTypeNoSelectTarget.targetName, new InOutTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	public void save() {
		try {
			boolean settleTypeFlag = false;
			Jhpay jhpay = null;
			Ckjhcheck m = getModel(Ckjhcheck.class,"ckjhcheck");
			Jbsupplier supplier = getModel(Jbsupplier.class,"supplier");
			Jbstore store = getModel(Jbstore.class,"store");
			m.set("SupplierCode", supplier.getStr("supplierCode"));
			m.set("StoreCode", store.getStr("StoreCode"));
			Double amount = Double.parseDouble(getPara("amount"));
			m.set("CKAmount", amount);
			if (getPara("typeFlg") != null && getParaToInt("typeFlg")==1) {
				m.set("SettleTypeFlag", getParaToInt("typeFlg"));
				settleTypeFlag = true;
			}
			if (m.getLong("id") != null) {
				m.update();
			} else {
				m.save();
			}
			// 当面付模式
			if(settleTypeFlag) {
				jhpay = Jhpay.dao.findFirst("select * from jhpay where BillOrderNo = ?", m.getStr("OrderDate"));
				if (jhpay == null) {
					// 生成付款单信息
					jhpay = new Jhpay();
					synchronized(lock) {
						String ordCdNw = BsUtil.getMaxOrdNo("OrderCode","CF","jhpay");
						jhpay.set("OrderCode",ordCdNw);
					}
					jhpay.set("OrderDate",DateUtil.string2Date(DateUtil.date2String(new Date(), DateUtil.FORMAT_DATE), DateUtil.FORMAT_DATE));
					jhpay.set("SupplierCode",m.get("SupplierCode"));
					jhpay.set("DeptCode",m.get("DeptCode"));
					jhpay.set("EmpCode",m.get("EmpCode"));
					jhpay.set("PayType",BsUtil.DIR_PAY);
					jhpay.set("BankNo",supplier.get("BankNo"));
					jhpay.set("Amount",amount);
					jhpay.set("BillOrderNo",m.get("OrderCode"));
					Record man = getCurrentUser();
					jhpay.set("checkman", man.getStr("usr_name"));
					jhpay.set("CheckDate", new Date());
					jhpay.set("CheckFlag", 1);
					jhpay.save();
					Jhpaydetail jhpaydetail = new Jhpaydetail();
					jhpaydetail.set("OrderCode", m.get("OrderCode"));
					jhpaydetail.set("PayOrderNo", jhpay.get("OrderCode"));
					jhpaydetail.set("CollateType", "采购入库单");
					jhpaydetail.set("NowCollated", amount);
					jhpaydetail.set("Adjust", 0);
					jhpaydetail.set("Amount", amount);
				}
			}
			String orderCode = m.get("OrderCode");
			// 保存明细
			int size = 0;
			// 通过【新建商品明细】按钮新追加记录
			String[] index = getParaValues("lineId");
			size = Db.queryLong("select count(*)  from ckjhcheckdetail where orderCode = '" +  orderCode + "'").intValue();
			if (!(index == null || index.length == 0)) {
				size = size + index.length;
			}
			// 不足10条，补足10条显示并保存
			if (size < 10) {
				size = 10;
			}
			for (int i=0; i<size; i++) {
				Ckjhcheckdetail md = getModel(Ckjhcheckdetail.class, "ckjhcheckDetail" + i);
				Jbgoods goods = getModel(Jbgoods.class,"goods" + i);
				if (goods.getStr("GoodsCode") != null) {
					md.set("GoodsCode", goods.get("GoodsCode"));
					Ckjhcheckdetail tmp = Ckjhcheckdetail.dao.findById(md.getLong("id"));
					if (tmp != null ) {
						md.set("price", goods.get("BRefPrice"));
						md.update();
					} else {
						md.set("ordercode", orderCode);
						md.set("price", goods.get("BRefPrice"));
						md.save();
					}
				}
			}
			toDwzJson(200, "保存成功！", navTabId,"closeCurrent");
		} catch (Exception e) {
			log.error("保存仓库分类异常", e);
			toDwzJson(300, "保存异常！");
		}
	}
	
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Ckjhcheck r = Ckjhcheck.dao.findById(id);
				Ckjhcheck.dao.deleteById(id);
				Db.update("delete from ckjhcheckdetail where OrderCode=?", r.getStr("OrderCode"));
			}
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}
	
	// 审核
	@Before(Tx.class)
	public void review() throws Exception {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Ckjhcheck r = Ckjhcheck.dao.findById(id);
				/*
				 * if (r.getInt("SettleTypeFlag") == 2) { toDwzJson(300,
				 * "已清货不能审核！", navTabId); return; }
				 */
				if (r.getInt("CheckFlag") == null || r.getInt("CheckFlag") != 1) {
					// 登录人即审核者
					Record m = getCurrentUser();
					r.set("checkman", m.getStr("usr_name"));
					r.set("CheckDate", new Date());
					r.set("CheckFlag", 1);
					r.update();
					// 审核后更新库存表及供应商表应付款
					CkjhDbProc oracleDbK = new CkjhDbProc(r.getStr("StoreCode"),r.getStr("orderCode"),r.getStr("SupplierCode"),1);
			        Db.execute(oracleDbK);
				}
				toDwzJson(200, "审核通过！", navTabId);
			}
		} catch (Exception e) {
			toDwzJson(300, "审核失败！" + e.getMessage());
			throw e;
		}
	}
		
	// 未审核
	@Before(Tx.class)
	public void unreview() throws Exception {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Ckjhcheck r = Ckjhcheck.dao.findById(id);
				/*
				 * if (r.getInt("SettleTypeFlag") == 2) { toDwzJson(300,
				 * "已清货不能反审核！", navTabId); return; }
				 */
				if (r.getInt("CheckFlag") != null && r.getInt("CheckFlag") != 0) {
					// 登录人即审核者
					Record m = getCurrentUser();
					r.set("CheckFlag", 0);
					r.set("checkman", m.getStr("usr_name"));
					r.set("CheckDate", new Date());
					r.update();
					// 审核后更新库存表及供应商表应付款
					CkjhDbProc oracleDbK = new CkjhDbProc(r.getStr("StoreCode"),r.getStr("orderCode"),r.getStr("SupplierCode"),2);
			        Db.execute(oracleDbK);
				}
				toDwzJson(200, "反审核通过！", navTabId);
			}
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
			throw e;
		}
	}

}
