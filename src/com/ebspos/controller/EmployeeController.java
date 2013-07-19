package com.ebspos.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.loyin.jFinal.anatation.PowerBind;
import net.loyin.jFinal.anatation.RouteBind;
import net.loyin.util.safe.MD5;

import com.ebspos.ftl.OrgSelectTarget;
import com.ebspos.ftl.PartmentSelectTarget;
import com.ebspos.interceptor.ManagerPowerInterceptor;
import com.ebspos.model.Employee;
//import com.ebspos.model.Organization;
import com.ebspos.model.Partment;
import com.ebspos.model.Role;
import com.jfinal.aop.Before;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 网站管理用户
 * 
 * @author 刘声凤 2012-9-6 下午9:06:42
 */
@RouteBind(path = "/employee")
@Before({ ManagerPowerInterceptor.class })
public class EmployeeController extends BaseController {
	public static Logger log = Logger.getLogger(EmployeeController.class);
	private static String navTabId = "employee";
	private boolean f;

	public void index() {
		f = true;
		list();
//		setAttr("org",Organization.dao.find("select id, name,num from Organization order by id"));
		setAttr("part",Partment.dao.find("select id, dep_name from Partment order by id"));
		render("index.html");
	}

	public void list() {
		Long pid = getParaToLong(0, 0L);
//		Long orgid = getParaToLong(0, 0L);
		StringBuffer whee = new StringBuffer();
		List<Object> param = new ArrayList<Object>();
		String usr_name = getPara("usr_name");
		if (usr_name != null && !"".equals(usr_name.trim())) {
			whee.append(" and usr_name like ?");
			param.add("%" + usr_name + "%");
		}
		String usr_no = getPara("usr_no");
		if (usr_no != null && !"".equals(usr_no.trim())) {
			whee.append(" and usr_no like ?");
			param.add("%" + usr_no + "%");
		}
		if (pid != 0) {
			whee.append(" and p.id = ?");
			param.add(pid);
		}
		setAttr("usr_name", usr_name);
		setAttr("usr_no", usr_no);
		setAttr("partid", pid);
//		if (orgid != 0) {
//			whee.append(" and p.orgid = ?");
//			param.add(orgid);
//		}
//		setAttr("orgid", orgid);
		setAttr("pid", pid);
		setAttr("page",
				Db.paginate(
						getParaToInt("pageNum", 1),
						getParaToInt("numPerPage", 20),
						"select e.id,usr_no 编号,usr_name 姓名, e.gender 性别,phone_no 手机电话,usr_type 状态 ",
						" from  Employee e join partment p on p.id=e.dep_no "
								+ whee.toString() + " order by e.id ",
						param.toArray()));
		setAttr("collist", new String[] { "编号", "姓名", "性别", "手机电话", "状态" });
		if (f == false)
			render("list.html");
	}

	private static final String chars = "23456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz";

	/**
	 * 产生随机数
	 * @return
	 */
	private char[] getCode(int length) {
		char[] rands = new char[length];
		for (int i = 0; i < length; i++) {
			int rand = (int) (Math.random() * chars.length());
			rands[i] = chars.charAt(rand);
		}
		return rands;
	}

	public void add() {
		Employee pojo = new Employee();
		Long id = getParaToLong(1, 0L);
		Long pid = getParaToLong(0, 0L);
//		Long orgid = getParaToLong(0, 0L);
		pojo.set("dep_no", pid);
//		pojo.set("orgid", orgid);
		if (id != 0) {
			pojo = Employee.dao.findById(id);
		}
//		setAttr(OrgSelectTarget.targetName, new OrgSelectTarget());
		setAttr(PartmentSelectTarget.targetName, new PartmentSelectTarget());
		setAttr("pojo", pojo);
		render("add.html");
	}
	public void show() {
		Employee pojo = new Employee();
		Long id = getParaToLong(0, 0L);
		pojo = Employee.dao.findById(id);
		setAttr("part",Partment.dao.findById(pojo.get("dep_no")));
//		setAttr("org",Organization.dao.findById(pojo.get("orgid")));
		setAttr("pojo", pojo);
		render("show.html");
	}
	public void save() {
		try {
			Employee m = getModel(Employee.class);
			if (m.getLong("id") != null) {
				m.set("upd_time",new Timestamp((new Date()).getTime()));
				m.update();
			} else {
				m.set("pwd",MD5.getMD5ofStr("123456"));
				m.set("upd_time",new Timestamp((new Date()).getTime()));
				m.save();
			}
//			 Db.update("update employee e set e.orgid=(select p.orgid from partment p where p.id=e.partmentid)");
			toDwzJson(200, "保存成功！", navTabId);
		} catch (Exception e) {
			log.error("保存员工异常", e);
			toDwzJson(300, "保存异常！");
		}
	}

	public void del() {
		Long id = getParaToLong(0, 0L);
		Record po = getCurrentUser();
		if (id != po.getLong("id")) {
			Employee.dao.deleteById(id);
			toDwzJson(200, "删除成功！", navTabId);
		} else {
			toDwzJson(300, "不能删除自己的账号！");
		}
	}

	public void resetPwd() {
		String pwd = new String(getCode(6));// 随机密码
		Long id = getParaToLong(0, 0L);
		if (id != 0L) {
			Employee.dao.set("id", id).set("pwd", MD5.getMD5ofStr(pwd))
					.update();
		}
		toDwzJson(200, "重置密码成功！密码为<br><h3><b style='color:red;'>" + pwd
				+ "</b></h3><br>请牢记！", navTabId);
	}
	@PowerBind
	public void pwd() {
		render("pwd.html");
	}
	@PowerBind
	public void savepwd() {
		String oldpwd = getPara("oldpwd");
		String pwd = getPara("pwd");
		Record po = getCurrentUser();
		Employee e = Employee.dao.findById(po.get("id"));
		String pwd1 = e.getStr("pwd");
		if (MD5.getMD5ofStr(oldpwd).equals(pwd1)) {
			e.set("pwd", MD5.getMD5ofStr(pwd));
			e.update();
			toDwzJson(200, "重置密码成功！密码为<br><h3><b style='color:red;'>" + pwd
					+ "</b></h3><br>请牢记！");
		} else {
			toDwzJson(300, "旧密码输入错误！");
		}
	}

	public void role() {
		Long id = getParaToLong(0, 0L);
		setAttr("id", id);
		setAttr("pojo", Employee.dao.findById(id));
		setAttr("urolelist",
				Db.find("select roleid from userrole where userid=?", id));
		setAttr("rolelist", Role.dao.find("select * from role"));
		render("role.html");
	}

	public void saveRole() {
		try {
			Long id = getParaToLong(0, 0L);
			Integer[] roles=this.getParaValuesToInt("roles");
			if(roles!=null&&roles.length>0){
				Db.update("delete from userrole where userid=?",id);
				Integer[][] objs=new Integer[roles.length][1];
				int i=0;
				for(Integer m:roles){
					objs[i++][0]=m;
				}
				Db.batch("insert into userrole (userid,roleid) values("+id+",?)", objs,20);
			}
			toDwzJson(200, "保存成功！");
		} catch (Exception e) {
			toDwzJson(300, "保存异常！");
		}
	}
	
}
