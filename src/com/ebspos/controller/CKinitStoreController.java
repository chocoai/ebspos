package com.ebspos.controller;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;

/**
 * 起初库存
 * 
 * @author 熊涛
 */
@RouteBind(path = "/ckinitstore")
@Before({ ManagerPowerInterceptor.class })
public class CKinitStoreController extends BaseController {
	public static Logger log = Logger.getLogger(CKinitStoreController.class);
	private static String navTabId = "ckinitstore";
	private boolean f;
	
	@Override
	public void index() {
		
	}

}
