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
public class tableTypeSelectTarget extends BaseTarget {
	/**tableTypeSelect*/
	public static String targetName="tableTypeSelect";
	@SuppressWarnings("rawtypes")
	@Override
	public void execute(Environment env, Map args, TemplateModel[] arg2,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		List<Types> list= Types.dao.find("SELECT t1.id,t1.name,t1.num FROM types t1 where t1.pid<>0 AND t1.`function`='表类别'");
		Writer out= env.getOut();		
		for(Types g:list){			
			out.append("<option value='"+g.getLong("id")+"'>");
			out.append(g.getStr("name")+"["+g.getStr("num")+"]");
			out.append("</option>");
		}
	}
}
