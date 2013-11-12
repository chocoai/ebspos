package com.ebspos.cg.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.cg.model.Cgorder;
import com.ebspos.cg.model.Cgorderdetail;
import com.ebspos.ckjh.model.Ckjhcheck;
import com.ebspos.ckjh.model.Ckjhcheckdetail;
import com.ebspos.controller.BaseController;
import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbgoods;
import com.ebspos.model.Jbstore;
import com.ebspos.model.Jbsupplier;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.util.BsUtil;
/**
 * 采购订单资料
 * @author 湛原红 
 * 2013.8.30
 *
 */
@RouteBind(path="/cgorder")
@Before({ManagerPowerInterceptor.class})
public class CgorderController extends BaseController {

	public static Logger log = Logger.getLogger(CgorderController.class);
	private static String navTabId = "cgorder";
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
		
		String storeCd = getPara("store.StoreCode");
		if(storeCd!=null && !"".equals(storeCd.trim())){
			whee.append(" and p.StoreCode = ?");
			param.add(Long.parseLong(storeCd));
		}
		setAttr("StoreCode", storeCd);
		setAttr("StoreName", getPara("store.StoreName"));
		String sql = " from cgorder p  left join  jbsupplier b on p.supplierCode = b.supplierCode ";
		sql += " left join  jbstore c on p.StoreCode = c.StoreCode ";
		sql += " left join  employee d on d.usr_no = p.EmployeeNo ";
		sql += " left join  partment e on e.id = p.partmentNo ";
		sql +=" where 1=1 ";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.ordercode 订单号, p.orderdate 订单日期,p.stopflag 停用, p.CheckFlag 审核, p.DeliveryDate 收货日期,p.remark 备注, b.supplierName 供应商,c.StoreName 订货仓库,d.usr_name 业务员, e.`name` 部门 ",
				sql + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","订单日期","供应商","业务员","部门","收货日期","订货仓库","折前金额","折后金额","税后金额","审核","停用","备注"});
		render("index.html");
	}
	
	public void add() {
		Cgorder cgOrd = new Cgorder();
		Jbsupplier jbsupplier = new Jbsupplier();
		Jbstore jbstore = new Jbstore();
		Long id = getParaToLong(0, 0L);
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.orderCode = ?");
		if (id != 0) { // 修改
			cgOrd = Cgorder.dao.findById(id);
			jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", cgOrd.getStr("supplierCode"));
			jbstore = Jbstore.dao.findFirst("select * from jbstore where StoreCode = ?", cgOrd.getInt("StoreCode"));
			param.add(cgOrd.get("orderCode"));
		} else {
			String ordCdNw;
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("ordercode","CGDD","cgorder");
			}
			cgOrd.set("orderCode", ordCdNw);
			param.add(ordCdNw);
		}
		String sql = "select a.id,b.GoodsCode 商品编号,b.GoodsName 商品名称,b.Model 商品规格,b.BaseUnit 基本单位,b.BRefPrice 原价,a.Discount 折扣,a.OrigPrice 单价, a.Quantity 数量,";
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
		setAttr("cgOrd", cgOrd);
		setAttr("store", jbstore);
		setAttr("supplier", jbsupplier);
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	// 采购入库信息
	private Ckjhcheck initCkjhcheck(Cgorder m,Double amount) {
		Ckjhcheck ckjhcheck = new Ckjhcheck();
		String ordCdNw;
		synchronized(lock) {
			ordCdNw = BsUtil.getMaxOrdNo("OrderNo","PK","ckjhcheck");
			ckjhcheck.set("OrderNo", ordCdNw);
		}
		ckjhcheck.set("OrderDate", m.getDate("DeliveryDate"));
		ckjhcheck.set("SupplierNo", m.getStr("supplierCode"));
		ckjhcheck.set("StoreNo", Integer.parseInt(m.getStr("StoreCode")));
		ckjhcheck.set("InOutTypeNo", "1");
		ckjhcheck.set("BillOrderNo", m.getStr("orderCode"));
		ckjhcheck.set("DepartmentNo", m.getInt("partmentNo"));
		ckjhcheck.set("EmployeeNo", m.getStr("EmployeeNo"));
		ckjhcheck.set("Operator", m.getStr("Operator"));
		// 入库金额
		ckjhcheck.set("CKAmount", amount);
		// 购货金额
		ckjhcheck.set("Amount", amount);
		ckjhcheck.save();
		return ckjhcheck;
	}
	
	// 采购入库明细信息
	private void initCkjhcheckDetail(Cgorderdetail md,String ordNo) {
		Ckjhcheckdetail ckjhcheckDetail = new Ckjhcheckdetail();
		ckjhcheckDetail.set("OrderNo", ordNo);
		ckjhcheckDetail.set("SerialNo", md.getInt("SerialNo"));
		ckjhcheckDetail.set("GoodsNo", md.getStr("GoodsCode"));
		ckjhcheckDetail.set("Quantity", md.getBigDecimal("Quantity"));
		ckjhcheckDetail.set("OrigPrice", md.getBigDecimal("OrigPrice"));
		ckjhcheckDetail.set("Price", md.getBigDecimal("Price"));
		ckjhcheckDetail.set("BuyAmount", md.getBigDecimal("BuyAmount"));
		ckjhcheckDetail.set("TaxRate", md.getBigDecimal("TaxRate"));
		ckjhcheckDetail.set("TaxAmount", md.getBigDecimal("TaxAmount"));
		ckjhcheckDetail.set("CKAmount", md.getBigDecimal(""));
		ckjhcheckDetail.set("CKPrice", md.getBigDecimal("Price"));
		ckjhcheckDetail.set("CKAmount", md.getBigDecimal("BuyAmount"));
//		ckjhcheckDetail.set("Unit", md.getStr("Unit"));
		ckjhcheckDetail.save();
	}
	
	public void save() {
		try {
			boolean settleTypeFlag = false;
			Ckjhcheck initCkjhcheck = new Ckjhcheck();
			Cgorder m = getModel(Cgorder.class,"cgOrd");
			Jbsupplier supplier = getModel(Jbsupplier.class,"supplier");
			Jbstore store = getModel(Jbstore.class,"store");
			m.set("supplierCode", supplier.getStr("supplierCode"));
			m.set("StoreCode", store.getStr("StoreCode"));
			if (getPara("typeFlg") != null && !getPara("typeFlg").equals("")) {
				m.set("SettleTypeFlag", getParaToInt("typeFlg"));
				settleTypeFlag = true;
				// 清货状态自动审核
				m.set("CheckMan", m.get("Operator"));
				m.set("CheckDate", new Date());
				m.set("CheckFlag", 1);
			}
			if (m.getLong("id") != null) {
				m.update();
			} else {
				m.save();
			}
			// 清货模式
			if(settleTypeFlag) {
				Double amount = Double.parseDouble(getPara("amount"));
				// 生成采购入库单
				initCkjhcheck = initCkjhcheck(m,amount);
			}
			String orderNo = getPara("cgOrd.ordercode");
			// 保存明细
			int size = 0;
			// 通过【新建商品明细】按钮新追加记录
			String[] index = getParaValues("lineId");
			size = Db.queryLong("select count(*)  from cgorderdetail where orderCode = '" +  orderNo + "'").intValue();
			if (!(index == null || index.length == 0)) {
				size = size + index.length;
			}
			// 不足10条，补足10条显示并保存
			if (size < 10) {
				size = 10;
			}
			for (int i=0; i<size; i++) {
				Cgorderdetail md = getModel(Cgorderdetail.class, "cgOrdDetail" + i);
				Jbgoods goods = getModel(Jbgoods.class,"goods" + i);
				if (goods.getStr("GoodsCode") != null) {
					md.set("GoodsCode", goods.get("GoodsCode"));
					if (md.getLong("id") != null) {
						md.update();
						md = Cgorderdetail.dao.findById(md.getLong("id"));
					} else {
						md.set("ordercode", orderNo);
						md.save();
					}
					// 清货模式
					if(settleTypeFlag) {
						initCkjhcheckDetail(md,initCkjhcheck.getStr("OrderNo"));
					}
				}
			}
			toDwzJson(200, "保存成功！", navTabId,"closeCurrent");
		} catch (Exception e) {
			log.error("保存异常", e);
			toDwzJson(300, "保存异常！");
		}
	}
	
	// 审核
	public void review() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Cgorder r = Cgorder.dao.findById(id);
				if (r.getInt("SettleTypeFlag") == 2) {
					toDwzJson(300, "已清货不能审核！", navTabId);
					return;
				}
				if (r.getInt("CheckFlag") != 1) {
					r.set("CheckFlag",1);
					r.update();
				}
				toDwzJson(200, "审核通过！", navTabId);
			}
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}
	
	// 未审核
	public void unreview() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Cgorder r = Cgorder.dao.findById(id);
				if (r.getInt("SettleTypeFlag") == 2) {
					toDwzJson(300, "已清货不能反审核！", navTabId);
					return;
				}
				if (r.getInt("CheckFlag") != 0) {
					r.set("CheckFlag",0);
					r.update();
				}
				toDwzJson(200, "反审核通过！", navTabId);
			}
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}
	
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Cgorder r = Cgorder.dao.findById(id);
				if (r.getInt("CheckFlag") == 1) {
					toDwzJson(300, "审核通过的信息不能删除！", navTabId);
				} else {
					Cgorder.dao.deleteById(id);
					// 同时删除采购明细
					Db.update("delete from cgorderdetail where orderCode=?", r.getStr("orderCode"));
					toDwzJson(200, "删除成功！", navTabId);
				}
			}
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}
  
}
