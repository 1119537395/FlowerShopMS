package com.fish.business.service.impl;

import com.fish.business.dao.CustomerDao;
import com.fish.business.dao.FlowerDao;
import com.fish.business.dao.OrderDao;
import com.fish.business.domain.Customer;
import com.fish.business.domain.Flower;
import com.fish.business.domain.Order;
import com.fish.business.service.OrderService;
import com.fish.business.vo.FlowerVo;
import com.fish.business.vo.OrderVo;
import com.fish.system.domain.User;
import com.fish.system.utils.DataGridView;
import com.fish.system.utils.MessageConstant;
import com.fish.system.utils.RandomUtils;
import com.fish.system.utils.WebUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName OrderServiceImpl
 * @Description 订单业务层接口实现类
 * @Author 柚子茶
 * @Date 2021/3/2 15:57
 * @Version 1.0
 */
@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private FlowerDao flowerDao;

	@Autowired
	private CustomerDao customerDao;


	/**
	 * @param flowerId
	 * @return Map<String, Object>
	 * @description 获取当前登录用户和订单编号
	 * @author 柚子茶
	 * @date 2021/3/2 16:06
	 **/
	@Override
	public Map<String, String> queryOrderFormData(Integer flowerId) {
		// 自动生成鲜花的订单编号
		String flowerOrderNumber = RandomUtils.createRandomNumberByTime(MessageConstant.ORDER_HEAD);
		// 获取当前登录的用户
		User user = (User) WebUtils.getHttpSession().getAttribute("user");

		// 创建Map集合
		// 将获取到数据封装到map集合中
		Map<String, String> map = new HashMap<>(16);
		map.put("orderNumber", flowerOrderNumber);
		map.put("userName", user.getUserName());

		return map;
	}

	/**
	 * @param orderVo 订单实体类
	 * @return void
	 * @description 添加订单信息
	 * @author 柚子茶
	 * @date 2021/3/2 18:33
	 **/
	@Override
	public void addOrderData(OrderVo orderVo) {
		// 设置创建订单的时间
		orderVo.setCreateTime(new Date());
		// 查询出当前鲜花剩余的数量
		Flower flower = this.flowerDao.selectFlowerById(orderVo.getFlowerId());
		if (flower.getFlowerNumber() <= orderVo.getSalesOrderNumber()) {
			flower.setFlowerNumber(0);
		} else {
			// 得到鲜花的剩余数
			int remainingNumber = flower.getFlowerNumber() - orderVo.getSalesOrderNumber();
			flower.setFlowerNumber(remainingNumber);
		}
		// 对鲜花数量进行更新
		this.flowerDao.updateFlowerData(flower);

		// 获取到购买客户的ID
		Customer customer = this.customerDao.checkCustPhone(orderVo.getCustPhone());
		orderVo.setCustId(customer.getCustId());

		// 添加订单记录
		this.orderDao.insertSelective(orderVo);

	}

	/**
	 * @param orderVo
	 * @return DataGridView
	 * @description
	 * @author 柚子茶
	 * @date 2021/3/6 14:27
	 **/
	@Override
	public DataGridView queryOrderInfo(OrderVo orderVo) {
		// 开启分页
		Page<Object> page = PageHelper.startPage(orderVo.getPage(), orderVo.getLimit());
		List<Order> orderList = this.orderDao.selectOrderInfoByList(orderVo);
		return new DataGridView(page.getTotal(),orderList);
	}

	/**
	 * @param orderVo
	 * @return void
	 * @description 修改订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 21:42
	 **/
	@Override
	public void updateOrderInfo(OrderVo orderVo) {
		this.orderDao.updateByPrimaryKeySelective(orderVo);
	}

	/**
	 * @param orderId
	 * @return void
	 * @description 删除订单信息
	 * @author 柚子茶
	 * @date 2021/3/6 21:42
	 **/
	@Override
	public void deleteOrderInfo(String orderId) {
		this.orderDao.deleteByPrimaryKey(orderId);
	}
}
