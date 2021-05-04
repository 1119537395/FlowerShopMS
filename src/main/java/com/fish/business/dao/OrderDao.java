package com.fish.business.dao;

import com.fish.business.domain.Order;
import com.fish.business.vo.OrderVo;

import java.util.List;

public interface OrderDao {

	/**
	 * @param orderId 订单编号
	 * @return int
	 * @description 根据ID删除订单信息
	 * @author 柚子茶
	 * @date 2021/3/3 17:04
	 **/
	int deleteByPrimaryKey(String orderId);

	/**
	 * @param record 订单实体类
	 * @return int
	 * @description 添加订单信息
	 * @author 柚子茶
	 * @date 2021/3/3 17:04
	 **/
	int insert(Order record);

	/**
	 * @param record 订单实体类
	 * @return int
	 * @description 选择性添加订单信息
	 * @author 柚子茶
	 * @date 2021/3/3 17:04
	 **/
	int insertSelective(Order record);

	/**
	 * @param orderId 订单编号
	 * @return Order
	 * @description 根据订单编号查询订单信息
	 * @author 柚子茶
	 * @date 2021/3/3 17:05
	 **/
	Order selectByPrimaryKey(String orderId);

	/**
	 * @param record 订单实体类
	 * @return int
	 * @description 修改订单信息
	 * @author 柚子茶
	 * @date 2021/3/3 17:05
	 **/
	int updateByPrimaryKeySelective(Order record);

	/**
	 * @param record 订单实体类
	 * @return int
	 * @description 更新订单信息
	 * @author 柚子茶
	 * @date 2021/3/3 17:05
	 **/
	int updateByPrimaryKey(Order record);

	/**
	 * @param orderVo
	 * @return List<Order>
	 * @description 根据条件查询订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 14:28
	 **/
	List<Order> selectOrderInfoByList(OrderVo orderVo);
}