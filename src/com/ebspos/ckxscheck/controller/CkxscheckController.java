package com.ebspos.ckxscheck.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.ckxscheck.model.Ckxscheck;
import com.ebspos.ckxscheck.model.CkxscheckDetail;
import com.ebspos.controller.BaseController;
import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.ftl.XsInOutTypeNoSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbclient;
import com.ebspos.model.Jbgoods;
import com.ebspos.model.Jbstore;
import com.ebspos.xs.model.Xsorder;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.util.BsUtil;
/**
 * 销售出库单
 * @author 熊涛
 * 2013.9.25
 *
 */
@RouteBind(path="/ckxscheck")
@Before({ManagerPowerInterceptor.class})
public class CkxscheckController extends BaseController {
	public static Logger log = Logger.getLogger(CkxscheckController.class);
	private static String navTabId = "ckxscheck";
	private static final int INDEX = 0;
	private static final int LIST = 1;
	private static final int LIST_BY_CLIENTCODE = 2;

	
	private byte[] lock = new byte[0];
	@Override
	public void index() {
		select(INDEX);
		render("index.html");
	}
	
	public void list() {
		select(LIST);
		render("list.html");
	}
	
	public void listByClientCode() {
		select(LIST_BY_CLIENTCODE);
		render("list.html");
	}
	
	private void select(int type) {
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
		String clientCode = getPara("client.ClientCode");
		if (type == LIST_BY_CLIENTCODE) {
			clientCode = getPara();
		}
		if(clientCode!=null && !"".equals(clientCode.trim())){
			whee.append(" and p.clientCode = ?");
			param.add(Long.parseLong(clientCode));
		}
		setAttr("ClientCode", clientCode);
		setAttr("ClientName", getPara("client.ClientName"));
		
		String storeCd = getPara("store.StoreCode");
		if(storeCd!=null && !"".equals(storeCd.trim())){
			whee.append(" and p.StoreCode = ?");
			param.add(Long.parseLong(storeCd));
		}
		setAttr("StoreCode", storeCd);
		setAttr("StoreName", getPara("store.StoreName"));
		String sql = " from ckxscheck p  left join  jbclient b on p.ClientCode = b.ClientCode ";
		sql += " left join  jbstore c on p.StoreCode = c.StoreCode ";
		sql += " left join  employee d on d.usr_no = p.EmpCode ";
		sql += " left join  partment e on e.deptCode = p.deptCode ";
		sql += " left join  types t on t.id=p.inoutTypeNo ";
		sql +=" where 1=1 ";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.OrderCode 订单号, p.OrderDate 出库日期,p.Memo 备注, t.name 出库类型,p.BillOrderNo 销售单号,p.CKAmount 仓库成本, p.Amount 金额,p.checkflag 审核, b.clientName 客户名称,c.StoreName 仓库名称,d.usr_name 业务员, e.`name` 部门 ",
				sql + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","出库日期","客户名称","业务员","部门","仓库名称","出库类型","销售单号","金额","审核","备注"});
	}
	
	// 销售出库
	public void xsOutStore() {
		Ckxscheck ckxscheck = new Ckxscheck();
		Jbclient jbclient = new Jbclient();
		Jbstore jbstore = new Jbstore();
		List<Object> param=new ArrayList<Object>();
		// 采购入库单号
		//String ordCdNw = null;
		String obj = getPara();
		// 由采购订单导入,入库单号不用改
		String ordCd = "XC" + obj.substring(2);
		Xsorder xsOrd = new Xsorder();
		xsOrd = Xsorder.dao.findFirst("select * from xsorder where OrderCode = ?", new Object[]{obj});
		jbclient = Jbclient.dao.findFirst("select * from jbclient where ClientCode = ?", xsOrd.getStr("ClientCode"));
		jbstore = Jbstore.dao.findFirst("select * from jbstore where StoreCode = ?", xsOrd.getStr("StoreCode"));
		ckxscheck.set("OrderCode", ordCd);
		ckxscheck.set("OrderDate", xsOrd.getDate("DeliveryDate"));
		ckxscheck.set("ClientCode", xsOrd.getStr("ClientCode"));
		ckxscheck.set("StoreCode", xsOrd.getStr("StoreCode"));
		//ckjhcheck.set("InOutTypeNo", "52");
		ckxscheck.set("BillOrderNo", xsOrd.getStr("orderCode"));
		ckxscheck.set("deptCode", xsOrd.getStr("deptcode"));
		ckxscheck.set("Empcode", xsOrd.getStr("Empcode"));
		ckxscheck.set("Operator", xsOrd.getStr("Operator"));
		ckxscheck.set("CheckFlag", 1);
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.orderCode = ?");
		param.add(obj);
		String sql = "select a.id,b.GoodsCode 商品编号,b.GoodsName 商品名称,b.Model 商品规格,b.BaseUnit 基本单位,b.BRefPrice 原价,a.Discount 折扣,a.OrigPrice 单价, a.Quantity 数量,";
		sql += " a.TaxRate 税率,a.TaxAmount 税额,a.Amount 税后金额";
		String sqlSelect = " from xsorderdetail a"; 
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
		setAttr("ckxscheck", ckxscheck);
		setAttr("store", jbstore);
		setAttr("client", jbclient);
		setAttr(XsInOutTypeNoSelectTarget.targetName, new XsInOutTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	public void add() {
		Ckxscheck ckxscheck = new Ckxscheck();
		Jbclient jbclient = new Jbclient();
		Jbstore jbstore = new Jbstore();
		// 采购入库单号
		String ordCdNw = null;
		// 不是采购订单导入
		Long id = getParaToLong(0, 0L);
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.OrderCode = ?");
		if (id != 0) { // 修改
			ckxscheck = Ckxscheck.dao.findById(id);
			jbclient = Jbclient.dao.findFirst("select * from jbclient where ClientCode = ?", ckxscheck.getStr("ClientCode"));
			jbstore = Jbstore.dao.findFirst("select * from jbstore where StoreCode = ?", ckxscheck.getStr("StoreCode"));
			param.add(ckxscheck.get("orderCode"));
		} else {
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","XC","ckxscheck");
			}
			ckxscheck.set("OrderCode", ordCdNw);
			param.add(ordCdNw);
			//赋值当前时间
			Date dt=new Date();
			SimpleDateFormat ckDate=new SimpleDateFormat("yyyy-MM-dd");
			ckxscheck.set("orderdate", ckDate.format(dt));
			//赋值制单人
			Record m=getCurrentUser();
			ckxscheck.set("operator",m.getStr("usr_name"));
		}
		String sql = "select a.id,b.GoodsCode 商品编号,b.GoodsName 商品名称,b.Model 商品规格,b.BaseUnit 基本单位,b.BRefPrice 原价,a.Discount 折扣,a.OrigPrice 单价, a.Quantity 数量,";
		sql += " a.TaxRate 税率,a.TaxAmount 税额,a.Amount 金额";
		String sqlSelect = " from ckxscheckdetail a"; 
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
		setAttr("ckxscheck", ckxscheck);
		setAttr("store", jbstore);
		setAttr("client", jbclient);
		setAttr(XsInOutTypeNoSelectTarget.targetName, new XsInOutTypeNoSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	@Before(Tx.class)
	public void save() {
		try {
			boolean settleTypeFlag = false;
			Ckxscheck m = getModel(Ckxscheck.class,"ckxscheck");
			Jbclient jbclient = getModel(Jbclient.class,"client");
			Jbstore store = getModel(Jbstore.class,"store");
			m.set("ClientCode", jbclient.getStr("ClientCode"));
			m.set("StoreCode", store.getStr("StoreCode"));
			// 当面付模式
			if (getPara("typeFlg") != null && !getPara("typeFlg").equals("")) {
				m.set("SettleTypeFlag", getParaToInt("typeFlg"));
				settleTypeFlag = true;
			}
			Double amount = Double.parseDouble(getPara("amount"));
			// 金额
			m.set("Amount", amount);
			if (m.getLong("id") != null) {
				m.update();
			} else {
				// 自动审核
				m.set("CheckMan", m.get("Operator"));
				m.set("CheckDate", new Date());
				m.set("CheckFlag", 1);
				m.save();
			}
			String orderCode = getPara("ckxscheck.ordercode");
			// 保存明细
			int size = 0;
			// 通过【新建商品明细】按钮新追加记录
			String[] index = getParaValues("lineId");
			size = Db.queryLong("select count(*)  from ckxscheckdetail where orderCode = '" +  orderCode + "'").intValue();
			if (!(index == null || index.length == 0)) {
				size = size + index.length;
			}
			// 不足10条，补足10条显示并保存
			if (size < 10) {
				size = 10;
			}
			for (int i=0; i<size; i++) {
				CkxscheckDetail md = getModel(CkxscheckDetail.class, "ckxscheckDetail" + i);
				Jbgoods goods = getModel(Jbgoods.class,"goods" + i);
				if (goods.getStr("GoodsCode") != null) {
					md.set("GoodsCode", goods.get("GoodsCode"));
					CkxscheckDetail tmp = CkxscheckDetail.dao.findById(md.getLong("id"));
					if (tmp != null ) {
						md.update();
					} else {
						md.set("ordercode", orderCode);
						md.save();
					}
					// 清款模式
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
				Ckxscheck r = Ckxscheck.dao.findById(id);
				Ckxscheck.dao.deleteById(id);
				Db.update("delete from ckxscheckdetail where OrderCode=?", r.getStr("OrderCode"));
			}
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}
	
	// 审核
		public void review() {
			Long id = getParaToLong(0, 0L);
			try {
				if (id != null) {
					Ckxscheck r = Ckxscheck.dao.findById(id);
					/*
					if (r.getInt("SettleTypeFlag") == 2) {
						toDwzJson(300, "已清货不能审核！", navTabId);
						return;
					}
					*/
					if (r.getInt("CheckFlag") != 1) {
						r.set("CheckFlag",1);
						//登录人即审核者
						Record m=getCurrentUser();					
						r.set("checkman", m.getStr("usr_name"));
						r.update();
					}
					toDwzJson(200, "审核通过！", navTabId);
				}
			} catch (Exception e) {
				toDwzJson(300, "审核失败！"+e.getMessage());
			}
		}
		
		// 未审核
		public void unreview() {
			Long id = getParaToLong(0, 0L);
			try {
				if (id != null) {
					Ckxscheck r = Ckxscheck.dao.findById(id);
					/*
					if (r.getInt("SettleTypeFlag") == 2) {
						toDwzJson(300, "已清货不能反审核！", navTabId);
						return;
					}
					*/
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

}
