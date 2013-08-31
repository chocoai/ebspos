package com.ebspos.controller;

import java.util.ArrayList;
import java.util.List;
import net.loyin.jFinal.anatation.RouteBind;
import com.ebspos.ftl.YearbySelectTarget;
import com.ebspos.ftl.BrandSelectTarget;
import com.ebspos.ftl.BaseunitSelectTarget;
import com.ebspos.ftl.GoodsBigSelectTarget;
import com.ebspos.ftl.GoodsSubSelectTarget;
import com.ebspos.ftl.GoodsSmallSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Jbgoods;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
/**
 * 系统用表记录
 * @author 湛原红 
 * 2013.8.14
 *
 */
@RouteBind(path="/jbgoods")
@Before({ManagerPowerInterceptor.class})
public class JbgoodsController extends BaseController {

	public static Logger log = Logger.getLogger(JbgoodsController.class);
	private static String navTabId = "jbgoods";
	@Override
	public void index() {
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String goodscode=getPara("goodscode");
		if(goodscode!=null && !"".equals(goodscode.trim())){
			whee.append(" and p.goodscode like ?");
			param.add("%"+goodscode+"%");
		}
		setAttr("goodscode",goodscode);
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.goodscode 商品编码, p.goodsname 商品名称,p.goodstypeno 大类,p.subgoodstypeno 中类,p.smallgoodstypeno 小类, "+
		        " p2.name 品牌,p.ProduceArea 产地,p.model 规格,p.barcode 条码, "+
				" p3.name 计量单位 ,p.stopflag 停用,p.remark 备注",
				" from  jbgoods p left join types p2 on p.brandno=p2.id left join types p3 on p.baseunit=p3.id  where 1=1  "+whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"商品编码","商品名称","大类","中类","小类","品牌","产地","规格","条码","计量单位","停用","备注"});
		render("index.html");
	}
	
	public void lookuplst() {
		StringBuffer whee=new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String goodscode=getPara("goodscode");
		String goodname=getPara("goodname");
		if(goodscode!=null && !"".equals(goodscode.trim())){
			whee.append(" and p.goodscode like ?");
			param.add("%"+goodscode+"%");			
		}
		if(goodscode!=null && !"".equals(goodscode.trim())){
			whee.append(" and p.goodsname like ?");
			param.add("%"+goodname+"%");			
		}
		setAttr("goodscode",goodscode);
		setAttr("goodname",goodname);
		setAttr("page", Db.paginate(getParaToInt("pageNum", 1),getParaToInt("numPerPage", 10),
				"select p.id,p.goodscode 商品编码, p.goodsname 商品名称, p.BaseUnit 基本单位," +
				" p2.name 品牌,p.ProduceArea 产地,p.model 规格,p.barcode 条码 ",
				" from  jbgoods p left join types p2 on p.brandno=p2.id left join types p3 on p.baseunit=p3.id  where 1=1  "+whee.toString(),param.toArray()));
		setAttr("collist", new String[]{"商品编码","商品名称","基本单位","品牌","产地","规格","条码"});
		render("lookup.html");
	}
	
	public void add() {
		Jbgoods xtts = new Jbgoods();
		Long id = getParaToLong(0, 0L);
		if (id != 0) { // 修改
			xtts = Jbgoods.dao.findById(id);
		}
        
		setAttr("xtts", xtts);
		setAttr(YearbySelectTarget.targetName, new YearbySelectTarget());
		setAttr(BrandSelectTarget.targetName, new BrandSelectTarget());
		setAttr(BaseunitSelectTarget.targetName, new BaseunitSelectTarget());
		setAttr(GoodsBigSelectTarget.targetName, new GoodsBigSelectTarget());	
		setAttr(GoodsSubSelectTarget.targetName, new GoodsSubSelectTarget());
		setAttr(GoodsSmallSelectTarget.targetName, new GoodsSmallSelectTarget());
		render("add.html");
	}
	public void save() {
		try {
			Jbgoods m = getModel(Jbgoods.class);
			if (m.getLong("id") != null) {
				m.update();
			} else {
				m.save();
			}
			toDwzJson(200, "保存成功！", navTabId);
		} catch (Exception e) {
			log.error("保存系统表信息异常", e);
			toDwzJson(300, "保存异常！");
		}
	}
	public void del() {
		Long id = getParaToLong(0, 0L);
		try {
			Jbgoods.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} catch (Exception e) {
			toDwzJson(300, "删除失败！");
		}
	}

}
