package com.fish.business.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName Flower
 * @Description 鲜花实体类
 * @Author 柚子茶
 * @Date 2021/3/1 10:29
 * @Version 1.0
 */
public class Flower implements Serializable {
	private static final long serialVersionUID = -1921607633528920485L;

	/** 鲜花ID */
	private Integer flowerId;

	/** 鲜花名称 */
	private String flowerName;

	/** 鲜花种类 */
	private String flowerType;

	/** 进货数量 */
	private Integer flowerNumber;

	/** 进货价格 元/每支 */
	private Double flowerPurchasePrice;

	/** 出售价格 元/每支 */
	private Double flowerSellPrice;

	/** 鲜花上架状态 1：已上架 0：未上架 */
	private Integer flowerState;

	/** 鲜花图片上传保存地址 */
	private String flowerImageAddress;

	/** 创建时间 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date createTime;

	public Integer getFlowerId() {
		return flowerId;
	}

	public void setFlowerId(Integer flowerId) {
		this.flowerId = flowerId;
	}

	public String getFlowerName() {
		return flowerName;
	}

	public void setFlowerName(String flowerName) {
		this.flowerName = flowerName;
	}

	public String getFlowerType() {
		return flowerType;
	}

	public void setFlowerType(String flowerType) {
		this.flowerType = flowerType;
	}

	public Integer getFlowerNumber() {
		return flowerNumber;
	}

	public void setFlowerNumber(Integer flowerNumber) {
		this.flowerNumber = flowerNumber;
	}

	public Double getFlowerPurchasePrice() {
		return flowerPurchasePrice;
	}

	public void setFlowerPurchasePrice(Double flowerPurchasePrice) {
		this.flowerPurchasePrice = flowerPurchasePrice;
	}

	public Double getFlowerSellPrice() {
		return flowerSellPrice;
	}

	public void setFlowerSellPrice(Double flowerSellPrice) {
		this.flowerSellPrice = flowerSellPrice;
	}

	public Integer getFlowerState() {
		return flowerState;
	}

	public void setFlowerState(Integer flowerState) {
		this.flowerState = flowerState;
	}

	public String getFlowerImageAddress() {
		return flowerImageAddress;
	}

	public void setFlowerImageAddress(String flowerImageAddress) {
		this.flowerImageAddress = flowerImageAddress;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "Flower{" +
				"flowerId=" + flowerId +
				", flowerName='" + flowerName + '\'' +
				", flowerType='" + flowerType + '\'' +
				", flowerNumber=" + flowerNumber +
				", flowerPurchasePrice=" + flowerPurchasePrice +
				", flowerSellPrice=" + flowerSellPrice +
				", flowerState=" + flowerState +
				", flowerImageAddress='" + flowerImageAddress + '\'' +
				", createTime=" + createTime +
				'}';
	}
}
