package com.ebspos.ftl;


import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.util.Map;

import com.ebspos.model.Goodstype;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
/**
 * 组织机构选择
 * @author loyin
 * 2012-9-28
 */
public class GoodstypepSelectTarget extends BaseTarget {
	/**orgSelect*/
	public static String targetName="goodstypepSelect";
	@SuppressWarnings("rawtypes")
	@Override
	public void execute(Environment env, Map args, TemplateModel[] arg2,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		List<Goodstype> list= Goodstype.dao.find("select id,name,num from Goodstype where pid=0  order by num asc");
		Writer out= env.getOut();
		out.append("<option value='0'>一级类别</option>");
		for(Goodstype g:list){			
			out.append("<option value='"+g.getLong("id")+"'>");
			out.append(g.getStr("name")+"["+g.getStr("num")+"]");
			out.append("</option>");
		}
	}
}
