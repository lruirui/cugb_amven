package com.lsy.utils;

public class PageFilter implements java.io.Serializable {

	/**
	 * 当前页
	 * */
	private int page;
	/**
	 * 每页显示记录数
	 */
	private int rows;
	/**
	 * 排序字段
	 * */
	private String sort;
	/**
	 * 升序(asc)，降序(desc)
	 * */
	private String order;

	/**
	 * 开始查询
	 * */
	private int begin;

	public int getBegin() {
		return (page-1)*rows;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

}
