package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.CKinitStoreDetail;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;

/**
 * 起初库存商品明细
 * 
 * @author 熊涛
 */
@RouteBind(path = "/ckinitdetail")
@Before({ ManagerPowerInterceptor.class })
public class CKinitStoreDetailController extends BaseController {
	public static Logger log = Logger.getLogger(CKinitStoreController.class);
	private static String navTabId = "ckinitdetailDlg";
	
	@Override
	public void index() {
		list();
	}

    public void list() {
		String OrderCode = getPara(0);
		StringBuffer whee=new StringBuffer();
		List<Object> param=new ArrayList<Object>();
		if (OrderCode != null) {
			whee.append(" and a.OrderCode = ?");
			param.add(OrderCode);
			String sql = "select a.id,a.goodsCode,b.GoodsName,a.Unit,a.Quantity, a.CKPrice";
			String sqlSelect = " from ckinitstoredetail a inner join jbgoods b on a.goodsCode=b.GoodsCode where 1=1 ";
			setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 20),
					sql, sqlSelect + whee.toString(),param.toArray()));
		}
		setAttr("OrderCode", OrderCode);
		render("list.html");
    }
    
    public void save() {
		try {
			int size = 0;
			String[] index = getParaValues("lineId");
			String OrderCode = getPara("OrderCode");
			size = Db.queryLong("select count(*)  from ckinitstoredetail where OrderCode = '" +  OrderCode + "'").intValue();
			if (!(index == null || index.length == 0)) {
				size = size + index.length;
			}
			for (int i=0; i<size; i++) {
				CKinitStoreDetail m = getModel(CKinitStoreDetail.class, "CKinitStoreDetail" + i);
				if (m.getStr("goodsCode") != null) {
					if (m.getLong("id") != null) {
						m.update();
					} else {
						m.set("OrderCode", OrderCode);
						m.save();
					}
				}
			}
			toDwzJson(200, "保存成功！", navTabId, "closeCurrent");
		} catch (Exception e) {
			log.error("保存仓库分类异常", e);
			toDwzJson(300, "保存异常！");
		}
    }
    
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			CKinitStoreDetail.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}
}
