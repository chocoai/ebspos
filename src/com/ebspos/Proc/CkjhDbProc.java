package com.ebspos.Proc;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.ICallback;

public class CkjhDbProc implements ICallback {
	// 仓库号
	public String storeCd;
	// 订单号
	public String ordCd;
	// 供应商号
	public String supCd;
	// 审核还是反审核(1,2)
	public int typeCd;
	
	public CkjhDbProc(String storeCd,String ordCd,String supCd,int typeCd) {
		this.storeCd = storeCd;
		this.ordCd = ordCd;
		this.supCd = supCd;
		this.typeCd = typeCd;
	}

	@Override
	public void run(Connection conn) throws SQLException {
		CallableStatement proc = null;
        try {
         proc = conn.prepareCall("{call CkjhProc(?,?,?,?)}");
         proc.setString(1, storeCd);
         proc.setString(2, ordCd);
         proc.setInt(3, typeCd);
         proc.setString(4, supCd);
         proc.execute();
       } finally {
         DbKit.close(proc, conn);
       }
   }

}
