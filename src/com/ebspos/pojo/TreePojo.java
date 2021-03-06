package com.ebspos.pojo;

import java.io.Serializable;
/**
 * 树形对象
 * @author loyin
 *2012-11-25 下午8:33:40
 */
public class TreePojo implements Serializable {
	private static final long serialVersionUID = 8116289975648353764L;
	/**显示名称*/
	public String showName;
	/**值*/
	public Object val;
	/**自身id*/
	public Long id;
	/**父id*/
	public Long pid;
	/**参数1*/
	public Object attr1;
	/**参数2*/
	public Object attr2;
	/**显示名称*/
	public String getShowName() {
		return showName;
	}
	/**显示名称*/
	public void setShowName(String showName) {
		this.showName = showName;
	}
	/**值*/
	public Object getVal() {
		return val;
	}
	/**值*/
	public void setVal(Object val) {
		this.val = val;
	}
	/**自身id*/
	public Long getId() {
		return id;
	}
	/**自身id*/
	public void setId(Long id) {
		this.id = id;
	}
	/**父id*/
	public Long getPid() {
		return pid;
	}
	/**父id*/
	public void setPid(Long pid) {
		this.pid = pid;
	}
	/**参数1*/
	public Object getAttr1() {
		return attr1;
	}
	/**参数1*/
	public void setAttr1(Object attr1) {
		this.attr1 = attr1;
	}
	/**参数2*/
	public Object getAttr2() {
		return attr2;
	}
	/**参数2*/
	public void setAttr2(Object attr2) {
		this.attr2 = attr2;
	}
}
