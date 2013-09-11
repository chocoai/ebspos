package com.ebspos.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.ftl.StoreSelectTarget;
import com.ebspos.ftl.StoretypeSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.CKinitStore;
import com.ebspos.model.CKinitStoreDetail;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 起初库存
 * 
 * @author 熊涛
 */
@RouteBind(path = "/ckinitstore")
@Before({ ManagerPowerInterceptor.class })
public class CKinitStoreController extends BaseController {
	public static Logger log = Logger.getLogger(CKinitStoreController.class);
	private static String navTabId = "ckinitstore";
	private boolean f;
	
	@Override
	public void index() {
		f = true;
		list();
		render("index.html");
	}
	
	public void list() {
		String startTime = getPara("startTime");
		StringBuffer whee=new StringBuffer();
		List<Object> param=new ArrayList<Object>();
		if(startTime!=null&&!"".equals(startTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(a.orderdate) >= UNIX_TIMESTAMP(?)");
			param.add(startTime);
		}
		setAttr("startTime", startTime);
		String endTime = getPara("endTime");
		if(endTime!=null&&!"".equals(endTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(a.orderdate) <= UNIX_TIMESTAMP(?)");
			param.add(endTime);
		}
		setAttr("endTime", endTime);
	//	setAttr(OrgSelectTarget.targetName,new OrgSelectTarget());
	//	setAttr(PartmentSelectTarget.targetName,new PartmentSelectTarget());
		String sql = "select a.id,a.orderno 订单号,a.orderdate 订单日期,b.StoreName 仓库,a.billorderno 票据号,a.relatedbillno 票据日期,"
				+ "c.name 部门,d.usr_name 员工,a.operator 操作人,a.ckamount 库存数量,a.checkdate 审核日期,a.checkman 审核人,a.recordcount 记录数,a.Memo 备注,a.checkflag 审核";
		String sqlSelect = "from ckinitstore a ";
		sqlSelect += " inner join jbstore b on a.storeno = b.storeno ";
		sqlSelect += " inner join partment c on a.DepartmentNo = c.id ";
		sqlSelect += " inner join employee d on a.EmployeeNo = d.usr_no where 1=1 ";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","订单日期","仓库","票据号","票据日期","部门","员工","库存数量","审核日期","审核人","备注","审核"});
		if (f == false)
			render("list.html");
	}
	
	// 期初库存录入单汇总
	public void gatherlist() {
		String startTime = getPara("startTime");
		StringBuffer whee=new StringBuffer();
		List<Object> param=new ArrayList<Object>();
		if(startTime!=null&&!"".equals(startTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(a.orderdate) >= UNIX_TIMESTAMP(?)");
			param.add(startTime);
		}
		setAttr("startTime", startTime);
		String endTime = getPara("endTime");
		if(endTime!=null&&!"".equals(endTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(a.orderdate) <= UNIX_TIMESTAMP(?)");
			param.add(endTime);
		}
		setAttr("endTime", endTime);
		String orderNo = getPara("orderNo");
		if(orderNo!=null&&!"".equals(orderNo.trim())){
			whee.append(" and a.orderNo = ?");
			param.add(orderNo);
		}
		setAttr("orderNo", orderNo);
		String storeNo = getPara("storeNo");
		if(storeNo!=null&&!"".equals(storeNo.trim())){
			whee.append(" and a.storeNo = ?");
			param.add(storeNo);
		}
		setAttr("storeNo", storeNo);
        setAttr(StoreSelectTarget.targetName, new StoreSelectTarget());
		String sql = "select a.id,a.orderno 订单号,a.orderdate 订单日期,b.StoreName 仓库,a.billorderno 票据号,a.relatedbillno 票据日期,"
				+ "c.name 部门,d.usr_name 员工,a.operator 操作人,a.ckamount 库存数量,a.checkdate 审核日期,a.checkman 审核人,a.recordcount 记录数,a.Memo 备注";
		String sqlSelect = "from ckinitstore a ";
		sqlSelect += " inner join jbstore b on a.storeno = b.storeno ";
		sqlSelect += " inner join partment c on a.DepartmentNo = c.id ";
		sqlSelect += " inner join employee d on a.EmployeeNo = d.usr_no where 1=1 ";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","订单日期","仓库","票据号","票据日期","员工","库存数量","成本金额","备注"});
		if (f == false)
			render("gather_list.html");
	}
	
	// 期初库存录入单明细
	public void detaillist() {
		String startTime = getPara("startTime");
		StringBuffer whee=new StringBuffer();
		List<Object> param=new ArrayList<Object>();
		if(startTime!=null&&!"".equals(startTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(a.orderdate) >= UNIX_TIMESTAMP(?)");
			param.add(startTime);
		}
		setAttr("startTime", startTime);
		String endTime = getPara("endTime");
		if(endTime!=null&&!"".equals(endTime.trim())){
			whee.append(" and UNIX_TIMESTAMP(a.orderdate) <= UNIX_TIMESTAMP(?)");
			param.add(endTime);
		}
		setAttr("endTime", endTime);
		String orderNo = getPara("orderNo");
		if(orderNo!=null&&!"".equals(orderNo.trim())){
			whee.append(" and a.orderNo = ?");
			param.add(orderNo);
		}
		setAttr("orderNo", orderNo);
		String storeNo = getPara("storeNo");
		if(storeNo!=null&&!"".equals(storeNo.trim())){
			whee.append(" and a.storeNo = ?");
			param.add(storeNo);
		}
		setAttr("storeNo", storeNo);
		String goodsNo = getPara("goodsNo");
		if(goodsNo!=null&&!"".equals(goodsNo.trim())){
			whee.append(" and c.GoodsNo = ?");
			param.add(goodsNo);
		}
		setAttr("goodsNo", goodsNo);
		String goodsName = getPara("goodsName");
		if(goodsName!=null&&!"".equals(goodsName.trim())){
			whee.append(" and c.goodsName = ?");
			param.add(goodsName);
		}
		setAttr("goodsName", goodsName);
        setAttr(StoreSelectTarget.targetName, new StoreSelectTarget());
		String sql = "select a.id,a.orderno 订单号,a.orderdate 订单日期,b.StoreName 仓库,a.billorderno 票据号,a.relatedbillno 票据日期,"
				+ "c.GoodsNo 商品编号,c.GoodsName 商品名称,c.Unit 单位,c.Quantity 数量, c.CKPrice 成本价,c.memo 备注,a.operator 操作人,a.ckamount 库存数量,a.checkdate 审核日期,a.checkman 审核人,a.recordcount 记录数";
		String sqlSelect = "from ckinitstore a ";
		sqlSelect += " inner join jbstore b on a.storeno = b.storeno ";
		sqlSelect += " inner join ckinitstoredetail c on a.orderno = c.OrderNo where 1=1";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
				sql, sqlSelect + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","订单日期","仓库","商品编号","商品名称","单位","数量","成本价","成本金额","备注"});
		if (f == false)
			render("detail_list.html");
	}
	
	public void add() {
		CKinitStore ckt = new CKinitStore();
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		Long id = getParaToLong(0, 0L);
		if (id != 0) { // 修改
			ckt = CKinitStore.dao.findById(id);
			whee.append(" and a.id = ?");
			param.add(id);
		} else {
			Date cur = new Date();
			String orderNo = "CK" + cur.getTime();
			ckt.set("OrderNo", orderNo);
		}
        setAttr(StoretypeSelectTarget.targetName, new StoretypeSelectTarget());
        setAttr(StoreSelectTarget.targetName, new StoreSelectTarget());
		 setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		 setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		setAttr("ckt", ckt);
		String sql = "select c.id,a.orderno 订单号,a.orderdate 订单日期,b.StoreName 仓库,a.billorderno 票据号,a.relatedbillno 票据日期,"
				+ "c.GoodsNo 商品编号,c.GoodsName 商品名称,c.Unit 单位,c.Quantity 数量, c.CKPrice 成本价,c.memo 备注,a.operator 操作人,a.ckamount 库存数量,a.checkdate 审核日期,a.checkman 审核人,a.recordcount 记录数";
		String sqlSelect = "from ckinitstore a ";
		sqlSelect += " inner join jbstore b on a.storeno = b.storeno ";
		sqlSelect += " inner join ckinitstoredetail c on a.orderno = c.OrderNo where 1=1";
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
		setAttr("collist", new String[]{"订单号","订单日期","仓库","商品编号","商品名称","单位","数量","成本价","成本金额","备注"});
		render("add.html");
	}
	
	public void save() {
		try {
			CKinitStore m = getModel(CKinitStore.class);
			if (m.getLong("id") != null) {
				m.update();
			} else {
				m.save();
			}
			String orderNo = getPara("cKinitStore.OrderNo");
			// 保存明细
			int size = 0;
			// 通过按钮新追加记录
			String[] index = getParaValues("lineId");
			size = Db.queryLong("select count(*)  from ckinitstoredetail where orderNo = '" +  orderNo + "'").intValue();
			if (!(index == null || index.length == 0)) {
				size = size + index.length;
			}
			// 不足10条，补足10条显示并保存
			if (size < 10) {
				size = 10;
			}
			for (int i=0; i<size; i++) {
				CKinitStoreDetail md = getModel(CKinitStoreDetail.class, "CKinitStoreDetail" + i);
				if (md.getStr("goodsno") != null) {
					if (md.getLong("id") != null) {
						md.update();
					} else {
						md.set("orderNo", orderNo);
						md.save();
					}
				}
			}
			toDwzJson(200, "保存成功！", navTabId);
		} catch (Exception e) {
			log.error("保存仓库分类异常", e);
			toDwzJson(300, "保存异常！");
		}
	}
	
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			CKinitStore.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
