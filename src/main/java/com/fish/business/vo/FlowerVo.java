package com.fish.business.vo;

import com.fish.business.domain.Flower;

/**
 * @ClassName Flower
 * @Description 鲜花实体类属性扩展
 * @Author 柚子茶
 * @Date 2021/3/1 10:59
 * @Version 1.0
 */
public class FlowerVo extends Flower {

	/**
	 * 分页参数
	 */
	private Integer page;

	/**
	 * 分页参数
	 */
	private Integer limit;

	/**
	 * 用于接收多个id
	 */
	private Integer[] ids;

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public Integer[] getIds() {
		return ids;
	}

	public void setIds(Integer[] ids) {
		this.ids = ids;
	}


}
