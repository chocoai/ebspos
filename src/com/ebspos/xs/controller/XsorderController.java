package com.ebspos.xs.controller;

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
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbclient;
import com.ebspos.model.Jbgoods;
import com.ebspos.model.Jbstore;
import com.ebspos.xs.model.Xsorder;
import com.ebspos.xs.model.Xsorderdetail;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.util.BsUtil;

@RouteBind(path="/xsorder")
@Before({ManagerPowerInterceptor.class})
public class XsorderController extends BaseController {

	public static Logger log = Logger.getLogger(XsorderController.class);
	private static String navTabId = "xsorder";
	private byte[] lock = new byte[0];
	@Override
	public void index() {
		list("index");
		render("index.html");
	}
	
	public void select() {
		list("lookup");
		render("list.html");
	}
	
	private void list(String type) {
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
		String clientCode = getPara("client.clientCode");
		if(clientCode!=null && !"".equals(clientCode.trim())){
			whee.append(" and p.ClientCode = ?");
			param.add(clientCode);
		}
		setAttr("clientCode", clientCode);
		setAttr("clientName", getPara("client.clientName"));
		
		String storeCd = getPara("store.StoreCode");
		if(storeCd!=null && !"".equals(storeCd.trim())){
			whee.append(" and p.StoreCode = ?");
			param.add(Long.parseLong(storeCd));
		}
		setAttr("StoreCode", storeCd);
		setAttr("StoreName", getPara("store.StoreName"));
		String sql = " from xsorder p  left join  jbclient b on p.ClientCode = b.ClientCode ";
		sql += " left join  jbstore c on p.StoreCode = c.StoreCode ";
		sql += " left join  employee d on d.usr_no = p.EmpCode ";
		sql += " left join  partment e on e.deptCode = p.deptCode ";
		sql +=" where 1=1 ";
		if (type.equals("lookup")) {
			whee.append(" and p.CheckFlag = 1");
			setAttr("collist", new String[]{"订单号","订单日期","客户名称","业务员","部门","发货日期","订货仓库","订单金额"});
		} else {
			setAttr("collist", new String[]{"订单号","订单日期","客户名称","业务员","部门","发货日期","订货仓库","订单金额","审核","备注"});
		}
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.ordercode 订单号, p.orderdate 订单日期, p.CheckFlag 审核, p.DeliveryDate 发货日期,p.amount 订单金额,p.Memo 备注, b.clientName 客户名称,c.StoreName 订货仓库,d.usr_name 业务员, e.`name` 部门 ",
				sql + whee.toString(),param.toArray()));
	}
	
	public void add() {
		String whichCostPrice;
		Xsorder xsOrd = new Xsorder();
		Jbclient jbclient = new Jbclient();
		Jbstore jbstore = new Jbstore();
		Long id = getParaToLong(0, 0L);
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.OrderCode = ?");
		if (id != 0) { // 修改
			xsOrd = Xsorder.dao.findById(id);
			jbclient = Jbclient.dao.findFirst("select * from jbclient where ClientCode = ?", xsOrd.getStr("ClientCode"));
			jbstore = Jbstore.dao.findFirst("select * from jbstore where StoreCode = ?", xsOrd.getStr("StoreCode"));
			param.add(xsOrd.get("orderCode"));
			// 成本价 = 商品成本价
			whichCostPrice = ",b.CostPrice 成本";
		} else {
			String ordCdNw;
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","XD","xsorder");
			}
			xsOrd.set("orderCode", ordCdNw);
			param.add(ordCdNw);
			//赋值当前时间
			Date dt=new Date();
			SimpleDateFormat cgDate=new SimpleDateFormat("yyyy-MM-dd");
			xsOrd.set("OrderDate", cgDate.format(dt));
			//赋值制单人
			Record m=getCurrentUser();
			xsOrd.set("operator",m.getStr("usr_name"));
			// 成本价 = 销售明细中成本价
			whichCostPrice = ",a.CKPrice 成本";
		}
		String sql = "select a.id,b.GoodsCode 商品编号,b.GoodsName 商品名称,b.Model 商品规格,b.BaseUnit 基本单位,a.OrigPrice 原价,a.Discount 折扣,a.Price 单价, a.Quantity 数量,";
		sql += " a.TaxRate 税率,a.TaxAmount 税额,a.Amount 税后金额" + whichCostPrice;
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
		setAttr("xsOrd", xsOrd);
		setAttr("store", jbstore);
		setAttr("client", jbclient);
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	// 销售出库信息
	private Ckxscheck initCkxsjhcheck(Xsorder m,Double amount) {
		Ckxscheck ckxscheck = new Ckxscheck();
		String ordCdNw;
		synchronized(lock) {
			ordCdNw = BsUtil.getMaxOrdNo("Ordercode","XSCK","ckxscheck");
			ckxscheck.set("Ordercode", ordCdNw);
		}
		ckxscheck.set("OrderDate", m.getDate("DeliveryDate"));
		ckxscheck.set("ClientCode", m.getStr("ClientCode"));
		ckxscheck.set("Storecode", m.getStr("StoreCode"));
		ckxscheck.set("InOutTypeNo", "1");
		ckxscheck.set("BillOrderNo", m.getStr("orderCode"));
		ckxscheck.set("deptcode", m.getStr("deptcode"));
		ckxscheck.set("Empcode", m.getStr("Empcode"));
		ckxscheck.set("Operator", m.getStr("Operator"));
		// 订单金额
		ckxscheck.set("Amount", amount);
		ckxscheck.save();
		return ckxscheck;
	}
	
	// 销售出库明细信息
	private void initCkxscheckDetail(Xsorderdetail md,String ordNo) {
		CkxscheckDetail ckxscheckDetail = new CkxscheckDetail();
		ckxscheckDetail.set("Ordercode", ordNo);
		ckxscheckDetail.set("SerialNo", md.getInt("SerialNo"));
		ckxscheckDetail.set("Goodscode", md.getStr("GoodsCode"));
		ckxscheckDetail.set("Quantity", md.getBigDecimal("Quantity"));
		ckxscheckDetail.set("OrigPrice", md.getBigDecimal("OrigPrice"));
		ckxscheckDetail.set("Price", md.getBigDecimal("Price"));
		ckxscheckDetail.set("TaxRate", md.getBigDecimal("TaxRate"));
		ckxscheckDetail.set("TaxAmount", md.getBigDecimal("TaxAmount"));
		ckxscheckDetail.set("Amount", md.getBigDecimal("Amount"));
		ckxscheckDetail.set("CKPrice", md.getBigDecimal("CostPrice"));
		ckxscheckDetail.set("Unit", md.getStr("Unit"));
		ckxscheckDetail.save();
	}
	
	@Before(Tx.class)
	public void save() {
		try {
			boolean settleTypeFlag = false;
			Ckxscheck initCkxsjhcheck = new Ckxscheck();
			Xsorder m = getModel(Xsorder.class,"xsOrd");
			Jbclient client = getModel(Jbclient.class,"client");
			Jbstore store = getModel(Jbstore.class,"store");
			m.set("clientCode", client.getStr("clientCode"));
			m.set("StoreCode", store.getStr("StoreCode"));
			if (getPara("typeFlg").equals("2")){ //= null && !getPara("typeFlg").equals("")) {
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
				// 生成销售出库单
				initCkxsjhcheck = initCkxsjhcheck(m,amount);
			}
			String orderCode = getPara("xsOrd.ordercode");
			// 保存明细
			int size = 0;
			// 通过【新建商品明细】按钮新追加记录
			String[] index = getParaValues("lineId");
			size = Db.queryLong("select count(*)  from ckxscheckDetail where orderCode = '" +  orderCode + "'").intValue();
			if (!(index == null || index.length == 0)) {
				size = size + index.length;
			}
			// 不足10条，补足10条显示并保存
			if (size < 10) {
				size = 10;
			}
			for (int i=0; i<size; i++) {
				Xsorderdetail md = getModel(Xsorderdetail.class, "xsOrdDetail" + i);
				Jbgoods goods = getModel(Jbgoods.class,"goods" + i);
				if (goods.getStr("GoodsCode") != null) {
					md.set("GoodsCode", goods.get("GoodsCode"));
					// 原价 = 参考销售价
					md.set("OrigPrice",goods.get("SRefPrice"));
					md.set("StoreCode",store.get("StoreCode"));
					// 成本价 = 商品成本价
					md.set("CKPrice",goods.get("CostPrice"));
					if (md.getLong("id") != null) {
						md.update();
						md = Xsorderdetail.dao.findById(md.getLong("id"));
					} else {
						md.set("ordercode", orderCode);
						md.save();
					}
					Db.update("update jbgoods set SRefPrice=? where goodsCode=?",goods.get("Price"),goods.getStr("GoodsCode"));
					// 清货模式
					if(settleTypeFlag) {
						initCkxscheckDetail(md,initCkxsjhcheck.getStr("OrderCode"));
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
				Xsorder r = Xsorder.dao.findById(id);
				if (r.getInt("SettleTypeFlag") == 2) {
					toDwzJson(300, "已清货不能审核！", navTabId);
					return;
				}
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
			toDwzJson(300, "审核失败！");
		}
	}
	
	// 未审核
	public void unreview() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Xsorder r = Xsorder.dao.findById(id);
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
				Xsorder r = Xsorder.dao.findById(id);
				if (r.getInt("CheckFlag") != null && r.getInt("CheckFlag") == 1) {
					toDwzJson(300, "审核通过的信息不能删除！", navTabId);
				} else {
					Xsorder.dao.deleteById(id);
					// 同时删除采购明细
					Db.update("delete from xsorderdetail where orderCode=?", r.getStr("orderCode"));
					toDwzJson(200, "删除成功！", navTabId);
				}
			}
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}
  

}
