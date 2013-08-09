package com.ebspos.controller;


import java.util.HashMap;
import java.util.Map;

import net.loyin.memcache.MemcacheTool;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;

/**
 * 基础Controller
 * @author 刘声凤
 *  2012-9-3 下午10:37:28
 */
public abstract class BaseController extends Controller {
	protected int pageSize=20;
	public abstract void index();
	@Override
	public void render(String view) {
		super.render(view);
	}
	/**获取当前系统操作人*/
	public Record getCurrentUser(){
		String user_token=getCookie("user_token");
//		return (Record)MemcacheTool.mcc.get(user_token);
		return (Record)CacheKit.get("mcc", user_token);
	}
	/**
	 * 转换dwz json格式输出
	 * @param statusCode
	 * @param message
	 * @param navTabId
	 * @return
	 */
	public void toDwzJson(Integer statusCode,String message,String... navTabId){
		Map<String,Object> jsonMap=new HashMap<String,Object>();
		jsonMap.put("statusCode", statusCode);
		if(message!=null)
		jsonMap.put("message",message);
		if(navTabId!=null)
		jsonMap.put("navTabId", navTabId);
		this.renderJson(jsonMap);
	}
	public void toDwzJson(Integer statusCode,String message,Long id){
		Map<String,Object> jsonMap=new HashMap<String,Object>();
		jsonMap.put("statusCode", statusCode);
		if(message!=null)
		jsonMap.put("message",message);
		if(id!=null)
		jsonMap.put("idVal",id);
		this.renderJson(jsonMap);
	}
}
