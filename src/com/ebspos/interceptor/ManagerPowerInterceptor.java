package com.ebspos.interceptor;


import java.util.List;
import com.ebspos.StaticCfg;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;
/**
 * 管理用户后台登录状态及权限验证拦截器
 * @author 刘声凤
 *  2012-9-6 下午8:32:53
 */
public class ManagerPowerInterceptor implements Interceptor {

	public void intercept(ActionInvocation ai) {
		Controller ctrl=ai.getController();
		ctrl.setAttr("root",ctrl.getRequest().getContextPath());
		ctrl.setAttr("StaticCfg", new StaticCfg());
		String user_token=ctrl.getCookie("user_token");
//		Record po=(Record)MemcacheTool.mcc.get(user_token);
		Record po =(Record) CacheKit.get("mcc", user_token);
		if(po==null){
			/*String ckey=ai.getControllerKey();
			if(ckey.contains("webadmin")){
				ctrl.redirect(ctrl.getRequest().getContextPath()+"/webadmin");
			}else*/
			ctrl.renderJson("{\"statusCode\":301,\"message\":\"登录超时，请重新登录！\"}");
		}else{
			/*boolean v=true;
			String code=null;
			PowerBind p=ai.getController().getClass().getAnnotation(PowerBind.class);
			if(p!=null){
				v=p.v();
				code=p.code();
			}
			p=ai.getMethod().getAnnotation(PowerBind.class);
			if(p!=null){
				v=p.v();
				code=p.code();
			}
			boolean f=false;
			if(v==true){
				//菜单权限判断
				List<Record> menus=(List<Record>)MemcacheTool.mcc.get("menu"+sid);
				if(menus!=null&&menus.isEmpty()==false){
					if(checkPower(menus,ai.getActionKey(),code)){//链接或安全码匹配
						ctrl.setAttr("powersafecodelist",MemcacheTool.mcc.get("powersafecodelist"+sid));
						ai.invoke();//注意 一定要执行此方法
					}else{
						f=true;
					}
				}else{
					f=true;
				}
			}
			if(f)
			ctrl.renderText("{\"statusCode\":300,\"message\":\"<font color='red'><B>您未有此操作权限！请勿越权操作！<br>请重新登录获得最新权限设置！</B></font>\"}");
			*/
			ai.invoke();//注意 一定要执行此方法
		}
	}
	private boolean checkPower(List<Record> menus,String url,String safecode){
		for(Record m:menus){
			String u=m.getStr("url");
			String mcode=m.getStr("safecode");
			if((u!=null&&url.contains(u))||(mcode!=null&&mcode.equals(safecode))){
				return true;
			}
		}
		return false;
	}
}