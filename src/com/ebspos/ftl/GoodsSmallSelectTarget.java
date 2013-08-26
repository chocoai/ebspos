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
public class GoodsSmallSelectTarget extends BaseTarget {
	/**goodsSmallSelect*/
	public static String targetName="goodsSmallSelect";
	@SuppressWarnings("rawtypes")
	@Override
	public void execute(Environment env, Map args, TemplateModel[] arg2,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		List<Types> list= Types.dao.find("select t4.id,t4.name,t4.num from types t2 inner join types t1 "+
                                         " inner join types t3 inner join types t4 on t1.id=t2.pid  and t1.pid=0 and t1.function='商品类别' and t2.id=t3.pid and t3.id=t4.pid ");
		Writer out= env.getOut();		
		for(Types g:list){			
			out.append("<option value='"+g.getLong("id")+"'>");
			out.append(g.getStr("name")+"["+g.getStr("num")+"]");
			out.append("</option>");
		}
	}
}
