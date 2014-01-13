package com.ebspos.ck.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.ck.model.Ckmove;
import com.ebspos.ck.model.CkmoveDetail;
import com.ebspos.controller.BaseController;
import com.ebspos.ftl.EmployeeSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.ftl.StoreSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbgoods;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.util.BsUtil;


@RouteBind(path="/ckmove")
@Before({ManagerPowerInterceptor.class})
public class CkMoveController extends BaseController {

	public static Logger log = Logger.getLogger(CkMoveController.class);
	private static String navTabId = "ckmove";
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
		String deptcode=getPara("deptcode");
		if(deptcode!=null&&!"".equals(deptcode.trim())){
			whee.append(" and p.deptcode like ?");
			param.add("%"+deptcode+"%");
		}
		setAttr("deptcode", deptcode);
		String empcode=getPara("empcode");
		if(empcode!=null&&!"".equals(empcode.trim())){
			whee.append(" and p.empcode = ?");
			param.add(empcode);
		}
		setAttr("empcode", empcode);
		String sql = " from ckmove p ";
		sql += " left join  jbstore a on p.instoreCode = a.StoreCode ";
		sql += " left join  jbstore b on p.outstoreCode = b.StoreCode ";
		sql += " left join  employee d on d.usr_no = p.EmpCode ";
		sql += " left join  partment e on e.deptCode = p.deptCode ";
		sql +=" where 1=1 ";
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.OrderCode 订单号, p.OrderDate 订单日期,a.StoreName 入库仓库,b.StoreName 出库仓库, p.checkflag 审核 ,p.remark 备注, d.usr_name 业务员, e.`name` 部门,p.checkFlag 审核",
				sql + whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"订单号","订单日期","业务员","部门","入库仓库","出库仓库","业务员","部门","备注","审核"});
		setAttr(PartmentSelectTarget.targetName,new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName,new EmployeeSelectTarget());
		render("index.html");
	}
	
	public void add() {
		Ckmove ckmove = new Ckmove();
		// 采购入库单号
		String ordCdNw = null;
		// 不是采购订单导入
		Long id = getParaToLong(0, 0L);
		List<Object> param=new ArrayList<Object>();
		StringBuffer whee=new StringBuffer();
		whee.append(" and a.OrderCode = ?");
		if (id != 0) { // 修改
			ckmove = Ckmove.dao.findById(id);
			param.add(ckmove.get("orderCode"));
		} else {
			synchronized(lock) {
				ordCdNw = BsUtil.getMaxOrdNo("OrderCode","DB","ckmove");
			}
			ckmove.set("OrderCode", ordCdNw);
			param.add(ordCdNw);
			//赋值当前时间
			Date dt=new Date();
			SimpleDateFormat ckDate=new SimpleDateFormat("yyyy-MM-dd");
			ckmove.set("orderdate", ckDate.format(dt));
			//赋值制单人
			Record m=getCurrentUser();
			ckmove.set("operator",m.getStr("usr_name"));
		}
		String sql = "select a.id,b.GoodsCode 商品编号,b.GoodsName 商品名称,b.Model 商品规格,b.BaseUnit 单位,b.BRefPrice 原价,a.ckAmount 成本金额,a.ckPrice 成本价, a.Quantity 数量,a.remark 备注 ";
		String sqlSelect = " from ckmovedetail a ";
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
		setAttr("collist", new String[]{"商品编号","商品名称","商品规格","单位","原价","数量","成本价","成本金额","备注"});
		setAttr("ckmove", ckmove);
		setAttr(StoreSelectTarget.targetName, new StoreSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr(EmployeeSelectTarget.targetName, new EmployeeSelectTarget());
		render("add.html");
	}
	
	@Before(Tx.class)
	public void save() throws Exception {
		try {
			Ckmove m = getModel(Ckmove.class,"ckmove");
			if (m.getLong("id") != null) {
				m.update();
			} else {
				// 自动审核
				m.set("CheckMan", m.get("Operator"));
				m.set("CheckDate", new Date());
				m.set("CheckFlag", 0);
				m.save();
			}
			String orderCode = getPara("ckmove.ordercode");
			// 保存明细
			int size = 0;
			// 通过【新建商品明细】按钮新追加记录
			String[] index = getParaValues("lineId");
			size = Db.queryLong("select count(*)  from ckmovedetail where orderCode = '" +  orderCode + "'").intValue();
			if (!(index == null || index.length == 0)) {
				size = size + index.length;
			}
			// 不足10条，补足10条显示并保存
			if (size < 10) {
				size = 10;
			}
			for (int i=0; i<size; i++) {
				CkmoveDetail md = getModel(CkmoveDetail.class, "ckmoveDetail" + i);
				Jbgoods goods = getModel(Jbgoods.class,"goods" + i);
				if (goods.getStr("GoodsCode") != null) {
					md.set("GoodsCode", goods.get("GoodsCode"));
					CkmoveDetail tmp = CkmoveDetail.dao.findById(md.getLong("id"));
					if (tmp != null ) {
						md.update();
					} else {
						md.set("ordercode", orderCode);
						md.save();
					}
				}
			}
			toDwzJson(200, "保存成功！", navTabId,"closeCurrent");
		} catch (Exception e) { 
			log.error("保存仓库分类异常", e);
			toDwzJson(300, "保存异常！");
			throw e;
		}
	}
	
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			if (id != null) {
				Ckmove r = Ckmove.dao.findById(id);
				Ckmove.dao.deleteById(id);
				Db.update("delete from ckmovedetail where OrderCode=?", r.getStr("OrderCode"));
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
					// 审核后仓库货品之间的调拨会影响到调入仓与调出仓的库存数量，使调入仓对应的货品数量增加而调出仓对应的货
					Ckmove r = Ckmove.dao.findById(id);
					List<CkmoveDetail> ckmoveDetailLst = CkmoveDetail.dao.find("select * from ckmoveDetail where orderCode = ?", r.get("Ordercode"));
					for (int i = 0; i < ckmoveDetailLst.size(); i++) {
						CkmoveDetail ckmoveDetail = ckmoveDetailLst.get(i);
						BigDecimal dbCnt = ckmoveDetail.get("Quantity");
						Db.update("update ckcurrstore set Quantity = Quantity - " + dbCnt.intValue() + " where StoreCode=? and GoodsCode = ? ", r.getStr("outStoreCode"),ckmoveDetail.getStr("GoodsCode"));
						Db.update("update ckcurrstore set Quantity = Quantity + " + dbCnt.intValue() + " where StoreCode=? and GoodsCode = ? ", r.getStr("instoreCode"),ckmoveDetail.getStr("GoodsCode"));
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
				toDwzJson(300, "审核失败！"+e.getMessage());
				throw e;
			}
		}
		
		// 未审核
	@Before(Tx.class)
		public void unreview() throws Exception {
			Long id = getParaToLong(0, 0L);
			try {
				if (id != null) {
					// 审核后仓库货品之间的调拨会影响到调入仓与调出仓的库存数量，使调入仓对应的货品数量增加而调出仓对应的货
					Ckmove r = Ckmove.dao.findById(id);
					List<CkmoveDetail> ckmoveDetailLst = CkmoveDetail.dao.find("select * from ckmoveDetail where orderCode = ?", r.get("Ordercode"));
					for (int i = 0; i < ckmoveDetailLst.size(); i++) {
						CkmoveDetail ckmoveDetail = ckmoveDetailLst.get(i);
						BigDecimal dbCnt = ckmoveDetail.get("Quantity");
						Db.update("update ckcurrstore set Quantity = Quantity + " + dbCnt.intValue() + " where StoreCode=? and GoodsCode = ? ", r.getStr("outStoreCode"),ckmoveDetail.getStr("GoodsCode"));
						Db.update("update ckcurrstore set Quantity = Quantity - " + dbCnt.intValue() + " where StoreCode=? and GoodsCode = ? ", r.getStr("instoreCode"),ckmoveDetail.getStr("GoodsCode"));
					}
					if (r.getInt("CheckFlag") != 0) {
						r.set("CheckFlag",0);
						r.update();
					}
					toDwzJson(200, "反审核通过！", navTabId);
				}
			} catch (Exception e) {
				toDwzJson(300, "删除失败！");
				throw e;
			}
		}

}