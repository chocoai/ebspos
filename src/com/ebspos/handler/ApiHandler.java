package com.ebspos.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jfinal.handler.Handler;

public class ApiHandler extends Handler {
	
	private String viewPath;
	
	public ApiHandler(String viewPath) {
		this.viewPath = viewPath;
	}

	@Override
	public void handle(String target, HttpServletRequest request,
			HttpServletResponse response, boolean[] isHandled) {
		if (target.contains(viewPath)) {
			// 以标准问号查询的serverlet改为jfinal方式
			if (request.getQueryString() != null) {
				target += "/" + request.getQueryString();
			}
		}
		if (target.contains("unde")) target = "/jbgoods/lookuplst";
	     nextHandler.handle(target, request, response, isHandled);
	}

}
