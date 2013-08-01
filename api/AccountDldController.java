package com.ebspos.api;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import net.loyin.jFinal.anatation.RouteBind;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Zip;
import org.apache.tools.ant.types.FileSet;

import com.ebspos.controller.BaseController;
import com.ebspos.model.Employee;
import com.ebspos.util.FileUtil;
import com.jfinal.util.JsonBuilder;


@RouteBind(path = "/api/accounts")
public class AccountDldController extends BaseController {
	
	private static final String VERSION = "1.0";
	
	private static final String ROOT_PATH = "D:\\ebspos\\ebspos\\webroot\\tmp\\";

	public void feed() throws UnsupportedEncodingException {
		try {
			renderJson(query());
		} catch (Exception e) {
			renderJson(e.toString());
		}
	}
	
	public void feedzip() throws UnsupportedEncodingException {
		try {
			boolean flg = FileUtil.writeFile(query(), ROOT_PATH + "accouts");
			if (flg) {
				File srcdir = new File(ROOT_PATH + "accouts");
				File zipFile = new File(ROOT_PATH + "accounts.zip");
				Project prj = new Project();
				Zip zip = new Zip();
				zip.setProject(prj);  
				zip.setDestFile(zipFile);
				FileSet fileSet = new FileSet();
				fileSet.setProject(prj);  
//				fileSet.setDir(srcdir);  
				fileSet.setFile(srcdir);
				zip.addFileset(fileSet);  
				zip.execute();
				renderFile(zipFile);
				return;
			} else {
				renderJson("文件不存在");
			}
		} catch (Exception e) {
			renderJson(e.toString());
		}
	}

	private String query() throws Exception {
		String sql = "select * from employee where 1=1 ";
		String s = getPara();
		String[] paras = new String[]{};
		if (s != null) {
			paras = URLDecoder.decode(s, "utf-8").split("&");
		}
		Enumeration headInfo = getRequest().getHeaders("fields");
		while (headInfo.hasMoreElements()) {
			String fieldStr = (String) headInfo.nextElement();
			String[] fields = fieldStr.split(",");
		}
		String count = null;
		List<Object> objArray = new ArrayList<Object>();
		for (int i = 0; i < paras.length; i++) {
			if (paras[i].contains("max_update")) {
				sql += " and UNIX_TIMESTAMP(upd_time) >= UNIX_TIMESTAMP('" +   paras[i].replace("max_update", "").replace("=", "") +"') ";
			} else if (paras[i].contains("count")) {
				count = paras[i].replace("count", "").replace("=", "");
			} else {
				int index = paras[i].indexOf("=");
				sql += " and " + paras[i].substring(0,index + 1) + " ? " ;
				objArray.add(paras[i].substring(index + 1));
			}
		}
		sql += " order by upd_time desc ";
		if (count != null) {
			sql += " limit " + count;
		}
		List<Employee> list = Employee.dao.find(sql,objArray.toArray(new Object[]{}));
		HashMap<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("version", VERSION);
		jsonMap.put("list", list);
		return JsonBuilder.mapToJson(jsonMap, 8);
	}
	
	@Override
	public void index() {
		renderError500();
	}
}
