package com.ebspos.ftl;

import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.util.Map;

import com.ebspos.model.Employee;
import com.ebspos.model.Jbstore;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
/**
 * 仓库选择
 * @author 湛原红
 * 2013-08-30
 */
public class StoreSelectTarget extends BaseTarget {
	/**storeSelect*/
	public static String targetName="storeSelect";
	@SuppressWarnings("rawtypes")
	@Override
	public void execute(Environment env, Map args, TemplateModel[] arg2,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		List<Jbstore> list= Jbstore.dao.find("select StoreNo,StoreCode,StoreName from jbstore ");
		Writer out= env.getOut();
		for(Jbstore o:list){
			out.append("<option value='"+o.getStr("StoreCode")+"'>");
			out.append(o.getStr("StoreName")+"["+o.getStr("StoreCode")+"]");
			out.append("</option>");
		}
	}
}
