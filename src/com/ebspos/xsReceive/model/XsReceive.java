package com.ebspos.xsReceive.model;




import net.loyin.jFinal.anatation.TableBind;

import com.jfinal.plugin.activerecord.Model;

@TableBind(name="xsReceive")
public class XsReceive extends Model<XsReceive> {
	private static final long serialVersionUID = -9161551438192184714L;
	public static final XsReceive dao=new XsReceive();
}
