package com.ebspos.ckjh.controller;

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
import com.ebspos.ftl.InOutTypeNoSelectTarget;
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
	private byte[] lock = new byte[0];
	@Override
	public void index() {
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
		if(supplierCode!=null && !"".equals(supplierCode.trim())){
			whee.append(" and p.SupplierNo = ?");
			param.add(Long.parseLong(supplierCode));
		}
		setAttr("supplierCode", supplierCode);
		setAttr("supplierName", getPara("supplier.supplierName"));
		
		String storeCd = getPara("store.StoreCode");
		if(storeCd!=null && !"".equals(storeCd.trim())){
			whee.append(" and p.StoreNo = ?");
			param.add(Long.parseLong(storeCd));
		}
		setAttr("StoreCode", storeCd);
		setAttr("StoreName", getPara("store.StoreName"));
		String sql = " from ckjhcheck p  left join  jbsupplier b on p.SupplierNo = b.supplierCode ";
		sql += " left join  jbstore c on p.StoreNo = c.StoreCode ";
		sql += " left join  employee d on d.usr_no = p.EmployeeNo ";
		sql += " left join  partment e on e.id = p.DepartmentNo ";
		sql +=" where 1=1 ";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.OrderNo 订单号, p.OrderDate 进货日期,p.remark 备注, p.InOutTypeNo 入库类型,p.BillOrderNo 采购单号,p.CKAmount 入库金额, p.Amount 购货金额, b.supplierName 供应商,c.StoreName 订货仓库,d.usr_name 业务员, e.`name` 部门 ",
				sql + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","进货日期","供应商","业务员","部门","收货日期","订货仓库","入库类型","采购单号","入库金额","购货金额","备注"});
		render("index.html");
	}
	
	public void add() {
		Ckjhcheck ckjhcheck = new Ckjhcheck();
		Jbsupplier jbsupplier = new Jbsupplier();
		Jbstore jbstore = new Jbstore();
		Long id = getParaToLong(0, 0L);
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.OrderNo = ?");
		if (id != 0) { // 修改
			ckjhcheck = Ckjhcheck.dao.findById(id);
			jbsupplier = Jbsupplier.dao.findFirst("select * from jbsupplier where supplierCode = ?", ckjhcheck.getStr("SupplierNo"));
			jbstore = Jbstore.dao.findFirst("select * from jbstore where StoreCode = ?", ckjhcheck.getInt("StoreNo"));
			param.add(ckjhcheck.get("OrderNo"));
		} else {
			String ordCdNw;
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderNo","PK","ckjhcheck");
			}
			ckjhcheck.set("OrderNo", ordCdNw);
			param.add(ordCdNw);
		}
		String sql = "select a.id,b.GoodsCode 商品编号,b.GoodsName 商品名称,b.Model 商品规格,b.BaseUnit 基本单位,b.BRefPrice 原价,a.Discount 折扣,a.OrigPrice 单价, a.Quantity 数量,";
		sql += " a.TaxRate 税率,a.TaxAmount 税额,a.Amount 金额";
		String sqlSelect = " from ckjhcheckdetail a"; 
		sqlSelect += " left join jbgoods b on a.GoodsNo = b.GoodsCode where 1=1 ";
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
			Ckjhcheck m = getModel(Ckjhcheck.class,"ckjhcheck");
			Jbsupplier supplier = getModel(Jbsupplier.class,"supplier");
			Jbstore store = getModel(Jbstore.class,"store");
			m.set("SupplierNo", supplier.getStr("supplierCode"));
			m.set("StoreNo", store.getStr("StoreCode"));
			if (getPara("typeFlg") != null && !getPara("typeFlg").equals("")) {
				m.set("SettleTypeFlag", getParaToInt("typeFlg"));
				settleTypeFlag = true;
			}
			if (m.getLong("id") != null) {
				m.update();
			} else {
				// 自动审核
				m.set("CheckMan", m.get("Operator"));
				m.set("CheckDate", new Date());
				m.set("CheckFlag", 1);
				m.save();
			}
			// 单面付模式
			if(settleTypeFlag) {
				Double amount = Double.parseDouble(getPara("amount"));
			}
			String orderNo = getPara("ckjhcheck.OrderNo");
			// 保存明细
			int size = 0;
			// 通过【新建商品明细】按钮新追加记录
			String[] index = getParaValues("lineId");
			size = Db.queryLong("select count(*)  from ckjhcheckdetail where orderNo = '" +  orderNo + "'").intValue();
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
					md.set("GoodsNo", goods.get("GoodsCode"));
					if (md.getLong("id") != null) {
						md.update();
					} else {
						md.set("orderNo", orderNo);
						md.save();
					}
					// 当面付模式
					if(settleTypeFlag) {
						
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
				Db.update("delete from ckjhcheckdetail where OrderNo=?", r.getStr("OrderNo"));
			}
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
