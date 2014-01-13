package com.ebspos.ck.model;

import java.math.BigDecimal;

import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;
import com.util.BsUtil;
@TableBind(name="ckcurrstore")
public class Ckcurrstore extends Model<Ckcurrstore>  {	
		private static final long serialVersionUID = -48379031542099868L;
		public static final Ckcurrstore dao=new Ckcurrstore();
		
		public Ckcurrstore findByStoreCdAndGoodCd(String storeCd,String goodsCd) {
			Ckcurrstore ckcurrstore = (Ckcurrstore) Ckcurrstore.dao.find("select * from ckcurrstore where StoreCode=? and GoodsCode = ? ", storeCd,goodsCd);
			return ckcurrstore;
		}
		
		public boolean updateCkcurStoreQty(String storeCd,String goodsCd,BigDecimal qty,BigDecimal costPrice) {
			Ckcurrstore ckcurrstore = (Ckcurrstore) Ckcurrstore.dao.find("select * from ckcurrstore where StoreCode=? and GoodsCode = ? ", storeCd,goodsCd);
			if (ckcurrstore == null) {
				// 库存中没有记录则保存
				return (new Ckcurrstore().set("StoreCode", storeCd).set("GoodsCode", goodsCd).set("CostPrice", costPrice).set("Quantity", qty)).save();
			} else {
				// 已经有记录则加权平均
				BigDecimal last = ckcurrstore.getBigDecimal("Quantity").multiply(ckcurrstore.getBigDecimal("CostPrice"));
				BigDecimal now = qty.multiply(costPrice);
				BigDecimal cnt = ckcurrstore.getBigDecimal("Quantity").add(qty);
				ckcurrstore.set("CostPrice", last.add(now).divide(cnt)).update();
				return ckcurrstore.set("Quantity", BsUtil.plus(qty,ckcurrstore.getBigDecimal("Quantity"))).update();
			}
		}
	}


