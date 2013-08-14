package com.ebspos.listener;


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSessionActivationListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;

import net.loyin.memcache.MemcacheTool;

/**
 * sessin监听器，统计在线客户端数及ip数量，以及处理失效后的memcache内容管理
 * @author 龙影 loyin
 * 2012-10-28
 */
public class SessionListener implements HttpSessionListener,
		ServletRequestListener, HttpSessionActivationListener {
	/** 客户端sessionid集合,多个浏览器也是可以同一终端上运行 */
	public static final String clientSetkey = "clientSet";
	/** 终端ip集合 */
	public static final String teSetkey = "teSet";
	public static final Long timelong=43200000L;
	HttpServletRequest request;

	@SuppressWarnings("unchecked")
	@Override
	public void sessionCreated(HttpSessionEvent ev) {
		String sessionid = ev.getSession().getId();
		String ip = request.getRemoteAddr();
//		Set<String> clientSet = (Set<String>) MemcacheTool.mcc.get(clientSetkey);
		Set<String> clientSet =(Set<String>) CacheKit.get("mcc", clientSetkey);
		if (clientSet == null) {
			clientSet = new HashSet<String>();
//			MemcacheTool.mcc.set(clientSetkey, clientSet,new Date(new Date().getTime()+timelong));
			CacheKit.put("mcc", clientSetkey, clientSet);
		}
		clientSet.add(sessionid);
//		MemcacheTool.mcc.set(clientSetkey, clientSet,new Date(new Date().getTime()+timelong));
		CacheKit.put("mcc", clientSetkey, clientSet);
//		Set<String> teSet = (Set<String>) MemcacheTool.mcc.get(teSetkey);
		Set<String> teSet = (Set<String>) CacheKit.get("mcc", teSetkey);
		if (teSet == null) {
			teSet = new HashSet<String>();
//			MemcacheTool.mcc.set(teSetkey, teSet,new Date(new Date().getTime()+timelong));
			CacheKit.put("mcc", teSetkey, teSet);
		}
		teSet.add(ip);
//		MemcacheTool.mcc.set(teSetkey, teSet,new Date(new Date().getTime()+timelong));
		CacheKit.put("mcc", teSetkey, teSet);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void sessionDestroyed(HttpSessionEvent ev) {
		String sessionid = ev.getSession().getId();
//		Set<String> clientSet = (Set<String>) MemcacheTool.mcc.get(clientSetkey);
		Set<String> clientSet = (Set<String>) CacheKit.get("mcc", clientSetkey);
		if (clientSet != null && clientSet.isEmpty() == false) {
			clientSet.remove(sessionid);
//			MemcacheTool.mcc.set(clientSetkey, clientSet,new Date(new Date().getTime()+timelong));
			CacheKit.put("mcc", clientSetkey, clientSet);
		}
//		Set<String> teSet = (Set<String>) MemcacheTool.mcc.get(teSetkey);
		Set<String> teSet = (Set<String>) CacheKit.get("mcc", teSetkey);
		if (teSet != null && teSet.isEmpty() == false) {
			String ip = request.getRemoteAddr();
			teSet.remove(ip);
//			MemcacheTool.mcc.set(teSetkey, teSet,new Date(new Date().getTime()+timelong));
			CacheKit.put("mcc", teSetkey, teSet);
		}
//		MemcacheTool.mcc.delete(sessionid);
//		MemcacheTool.mcc.delete("menu"+sessionid);
//		MemcacheTool.mcc.delete("powersafecodelist"+sessionid);
		CacheKit.remove("mcc", sessionid);
		CacheKit.remove("mcc", "menu"+sessionid);
		CacheKit.remove("mcc", "powersafecodelist"+sessionid);
	}

	@Override
	public void sessionDidActivate(HttpSessionEvent ev) {

	}

	@Override
	public void sessionWillPassivate(HttpSessionEvent ev) {

	}

	@Override
	public void requestDestroyed(ServletRequestEvent ev) {
   
	}

	@Override
	public void requestInitialized(ServletRequestEvent ev) {
		request = (HttpServletRequest) ev.getServletRequest();
	}

}
