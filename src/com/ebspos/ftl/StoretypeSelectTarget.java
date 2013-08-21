package com.ebspos.ftl;


import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.util.Map;

import com.ebspos.model.Storetype;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
/**
 * 组织机构选择
 * @author loyin
 * 2013-8-13
 */
public class StoretypeSelectTarget extends BaseTarget {
	/**orgSelect*/
	public static String targetName="storetypepSelect";
	@SuppressWarnings("rawtypes")
	@Override
	public void execute(Environment env, Map args, TemplateModel[] arg2,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		List<Storetype> list= Storetype.dao.find("select id as id,type_name,type_code as num from storetype order by id asc");
		Writer out= env.getOut();
		out.append("<option value='0'>一级类别</option>");
		for(Storetype g:list){
			out.append("<option value='"+g.getLong("id")+"'>");
			out.append(g.getStr("name")+"["+g.getStr("num")+"]");
			out.append("</option>");
		}
	}
}
