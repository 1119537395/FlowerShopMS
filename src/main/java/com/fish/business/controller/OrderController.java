package com.fish.business.controller;

import com.fish.business.domain.Customer;
import com.fish.business.domain.Flower;
import com.fish.business.service.CustomerService;
import com.fish.business.service.OrderService;
import com.fish.business.vo.CustomerVo;
import com.fish.business.vo.FlowerVo;
import com.fish.business.vo.OrderVo;
import com.fish.system.utils.CommonReturnType;
import com.fish.system.utils.DataGridView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @ClassName OrderController
 * @Description 订单管理的前端控制器
 * @Author 柚子茶
 * @Date 2021/3/2 15:59
 * @Version 1.0
 */
@RestController
@RequestMapping("order")
public class OrderController {

	@Autowired
	private OrderService orderService;

	@Autowired
	private CustomerService customerService;


	/**
	 * @param orderVo
	 * @return DataGridView
	 * @description 加载订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 14:21
	 **/
	@RequestMapping("loadOrderInfo")
	public DataGridView loadOrderInfo(OrderVo orderVo) {
		return this.orderService.queryOrderInfo(orderVo);
	}

	/**
	 * @param orderVo
	 * @return CommonReturnType
	 * @description 修改订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 14:22
	 **/
	@RequestMapping("updateOrderInfo")
	public CommonReturnType updateOrderInfo(OrderVo orderVo) {
		try {
			this.orderService.updateOrderInfo(orderVo);
			return CommonReturnType.MODIFY_SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return CommonReturnType.MODIFY_FAILURE;
		}
	}


	/**
	 * @param orderVo
	 * @return CommonReturnType
	 * @description 删除订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 14:25
	 **/
	@RequestMapping("deleteOrderInfo")
	public CommonReturnType deleteOrderInfo(OrderVo orderVo) {
		try {
			this.orderService.deleteOrderInfo(orderVo.getOrderId());
			return CommonReturnType.DELETE_SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return CommonReturnType.DELETE_FAILURE;
		}
	}


	/**
	 * @param orderVo 订单实体类
	 * @return CommonReturnType
	 * @description 添加订单信息
	 * @author 柚子茶
	 * @date 2021/3/2 18:31
	 **/
	@RequestMapping("addOrderData")
	public CommonReturnType addOrderData(OrderVo orderVo) {
		try {
			this.orderService.addOrderData(orderVo);
			return CommonReturnType.ADD_SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return CommonReturnType.ADD_FAILURE;
		}
	}


	/**
	 * @param flowerVo 鲜花信息实体类
	 * @return Map<String, Object>
	 * @description 获取自动生成的订单编号和当前系统登录的用户
	 * @author 柚子茶
	 * @date 2021/3/2 16:03
	 **/
	@RequestMapping("loadOrderFormData")
	public Map<String, String> loadOrderFormData(FlowerVo flowerVo) {
		return this.orderService.queryOrderFormData(flowerVo.getFlowerId());
	}

	/**
	 * @param customerVo 客户信息封装类
	 * @return CommonReturnType
	 * @description 校验该手机号是否存在
	 * @author 柚子茶
	 * @date 2021/3/2 16:50
	 **/
	@RequestMapping("checkCustPhone")
	public boolean checkCustPhone(CustomerVo customerVo) {
		Customer customer = this.customerService.checkCustPhone(customerVo.getCustPhone());
		if (null != customer) {
			return false;
		} else {
			return true;
		}
	}


}
