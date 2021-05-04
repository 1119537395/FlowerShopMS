package com.fish.business.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ClassName BusinessController
 * @Description 业务管理的路由控制器
 * @Author 柚子茶
 * @Date 2021/2/25 19:06
 * @Version 1.0
 */
@Controller
@RequestMapping("business")
public class BusinessController {

	/**
	 * @return String
	 * @description 路由跳转到客户管理界面
	 * @author 柚子茶
	 * @date 2021/2/25 19:08
	 **/
	@RequestMapping("toCustomerManager")
	public String toCustomerManager() {
		return "business/customer/customerManager";
	}

	/**
	 * @return String
	 * @description 路由跳转到鲜花进货管理界面
	 * @author 柚子茶
	 * @date 2021/3/1 12:32
	 **/
	@RequestMapping("toFlowerManager")
	public String toFlowerManager() {
		return "business/flower/flowerManager";
	}


	/**
	 * @return String
	 * @description 路由跳转到鲜花销售界面
	 * @author 柚子茶
	 * @date 2021/3/2 12:47
	 **/
	@RequestMapping("toOrderManager")
	public String toOrderManager() {
		return "business/order/orderManager";
	}


	/**
	 * @return String
	 * @description 路由跳转到订单销售界面
	 * @author 柚子茶
	 * @date 2021/3/6 21:46
	 **/
	@RequestMapping("toSaleManager")
	public String toSaleManager() {
		return "business/order/saleManager";
	}


}
