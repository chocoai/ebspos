package com.ebspos.ck.controller;

import net.loyin.jFinal.anatation.RouteBind;

import com.ebspos.controller.BaseController;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.jfinal.aop.Before;

@RouteBind(path="/ckcurrstore")
@Before({ManagerPowerInterceptor.class})
public class CkcurrstoreController extends BaseController {

	@Override
	public void index() {
		// TODO Auto-generated method stub

	}

}
