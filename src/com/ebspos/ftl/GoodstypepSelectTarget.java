package com.ebspos.ftl;


import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.util.Map;

import com.ebspos.model.Types;

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
		List<Types> list= Types.dao.find("select id,name,num from types where pid=0  order by num asc");
		Writer out= env.getOut();
		out.append("<option value='0'>一级类别</option>");
		for(Types g:list){			
			out.append("<option value='"+g.getLong("id")+"'>");
			out.append(g.getStr("name")+"["+g.getStr("num")+"]");
			out.append("</option>");
		}
	}
}
