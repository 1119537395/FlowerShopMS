package com.fish.business.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;


/**
 * @ClassName Flower
 * @Description 订单实体类
 * @Author 柚子茶
 * @Date 2021/3/2 15:29
 * @Version 1.0
 */
public class Order implements Serializable {

    private static final long serialVersionUID = 837653046126047609L;

    /** 订单编号 */
    private String orderId;

    /** 客户ID */
    private Integer custId;

    /** 客户手机号 */
    private String custPhone;

    /** 鲜花ID */
    private Integer flowerId;

    /** 销售的总金额 */
    private BigDecimal salesOrderAmount;

    /** 备注信息 */
    private String salesOrderInfo;

    /** 操作员 */
    private String operName;

    /** 保存客户购买的鲜花数量 */
    private Integer salesOrderNumber;

    /** 客户名称 */
    private String customerName;

    /** 鲜花名称 */
    private String flowerName;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId == null ? null : orderId.trim();
    }

    public Integer getCustId() {
        return custId;
    }

    public void setCustId(Integer custId) {
        this.custId = custId;
    }

    public String getCustPhone() {
        return custPhone;
    }

    public void setCustPhone(String custPhone) {
        this.custPhone = custPhone == null ? null : custPhone.trim();
    }

    public Integer getFlowerId() {
        return flowerId;
    }

    public void setFlowerId(Integer flowerId) {
        this.flowerId = flowerId;
    }

    public BigDecimal getSalesOrderAmount() {
        return salesOrderAmount;
    }

    public void setSalesOrderAmount(BigDecimal salesOrderAmount) {
        this.salesOrderAmount = salesOrderAmount;
    }

    public String getSalesOrderInfo() {
        return salesOrderInfo;
    }

    public void setSalesOrderInfo(String salesOrderInfo) {
        this.salesOrderInfo = salesOrderInfo == null ? null : salesOrderInfo.trim();
    }

    public String getOperName() {
        return operName;
    }

    public void setOperName(String operName) {
        this.operName = operName == null ? null : operName.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getSalesOrderNumber() {
        return salesOrderNumber;
    }

    public void setSalesOrderNumber(Integer salesOrderNumber) {
        this.salesOrderNumber = salesOrderNumber;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getFlowerName() {
        return flowerName;
    }

    public void setFlowerName(String flowerName) {
        this.flowerName = flowerName;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId='" + orderId + '\'' +
                ", custId=" + custId +
                ", custPhone='" + custPhone + '\'' +
                ", flowerId=" + flowerId +
                ", salesOrderAmount=" + salesOrderAmount +
                ", salesOrderInfo='" + salesOrderInfo + '\'' +
                ", operName='" + operName + '\'' +
                ", salesOrderNumber=" + salesOrderNumber +
                ", customerName='" + customerName + '\'' +
                ", flowerName='" + flowerName + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}