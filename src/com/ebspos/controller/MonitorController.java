package com.ebspos.controller;

import java.util.Set;

import com.ebspos.interceptor.ManagerPowerInterceptor;
import net.loyin.jFinal.anatation.RouteBind;
import net.loyin.memcache.MemcacheTool;
import com.jfinal.plugin.ehcache.CacheKit;

import com.jfinal.aop.Before;
/**
 * 系统监控
 * @author loyin
 *
 * 2012-10-14
 */
@RouteBind(path = "/monitor")
@Before({ ManagerPowerInterceptor.class })
public class MonitorController extends BaseController {
	@SuppressWarnings("unused")
	private static String navTabId="monitor";
	@SuppressWarnings("unchecked")
	@Override
	public void index() {
		Set<String> clientSet=(Set<String>)CacheKit.get("mcc","clientSet");
		this.setAttr("clientSet",clientSet.size());
		this.setAttr("teSet",CacheKit.get("mcc","teSet"));
		render("index.html");
	}

}
