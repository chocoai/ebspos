package com.ebspos.ftl;

import java.io.IOException;
import java.io.Writer;
import java.util.Calendar;
import java.util.Map;
import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
/**
 * 选择年
 * @author loyin
 * 2012-9-28
 */
public class YearbySelectTarget extends BaseTarget {
	/**yearSelect*/
	public static String targetName="yearSelect";
	@SuppressWarnings("rawtypes")
	@Override
	public void execute(Environment env, Map args, TemplateModel[] arg2,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		Calendar cal= Calendar.getInstance();
		int Intyear=cal.get(Calendar.YEAR)-3;		
		Writer out= env.getOut();
		for(int i=1;i<6;i++){
			out.append("<option value='"+String.valueOf(Intyear+i)+"'>");
			out.append(String.valueOf(Intyear+i));
			out.append("</option>");
		}
	}
}
