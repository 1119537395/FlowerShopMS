package com.fish.business.service;

import com.fish.business.vo.OrderVo;
import com.fish.system.utils.DataGridView;

import java.util.Map;

/**
 * @InterfaceName OrderService
 * @Description 订单业务层接口
 * @Author 柚子茶
 * @Date 2021/3/2 15:57
 * @Version 1.0
 */
public interface OrderService {


	/**
	 * @param flowerId 鲜花ID
	 * @return Map<String, Object>
	 * @description 获取自动生成的订单编号和当前登录的用户
	 * @author 柚子茶
	 * @date 2021/3/2 16:05
	 **/
	Map<String, String> queryOrderFormData(Integer flowerId);


	/**
	 * @param orderVo 订单实体类
	 * @return void
	 * @description
	 * @author 柚子茶
	 * @date 2021/3/2 18:33
	 **/
	void addOrderData(OrderVo orderVo);

	/**
	 * @param orderVo
	 * @return DataGridView
	 * @description 加载订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 14:22
	 **/
	DataGridView queryOrderInfo(OrderVo orderVo);

	/**
	 * @param orderVo
	 * @return void
	 * @description 修改订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 14:23
	 **/
	void updateOrderInfo(OrderVo orderVo);

	/**
	 * @param orderId
	 * @return void
	 * @description 删除订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 14:26
	 **/
	void deleteOrderInfo(String orderId);
}
