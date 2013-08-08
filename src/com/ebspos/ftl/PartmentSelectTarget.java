package com.ebspos.ftl;


import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.util.Map;

import com.ebspos.model.Organization;
import com.ebspos.model.Partment;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
/**
 * 组织机构选择
 * @author loyin
 * 2012-9-28
 */
public class PartmentSelectTarget extends BaseTarget {
	/**partSelect*/
	public static String targetName="partSelect";
	@SuppressWarnings("rawtypes")
	@Override
	public void execute(Environment env, Map args, TemplateModel[] arg2,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		List<Organization> orglist=Organization.dao.find("select id,name,num from Organization");
		List<Partment> list= Partment.dao.find("select id,name,orgid from Partment");
		Writer out= env.getOut();
		for(Organization org:orglist){
			out.append("<optgroup label='"+org.getStr("name")+"["+org.getStr("num")+"]'>");
			for(Partment o:list){
				if(org.getLong("id")==o.getLong("orgid")){
					out.append("<option value='"+o.getLong("id")+"'>");
					out.append(o.getStr("name"));
					out.append("</option>");
				}
			}
			out.append("</optgroup>");
	}
	}
}
