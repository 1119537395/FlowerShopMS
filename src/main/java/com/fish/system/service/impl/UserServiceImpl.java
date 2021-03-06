package com.fish.system.service.impl;

import com.fish.system.dao.RoleDao;
import com.fish.system.dao.UserDao;
import com.fish.system.domain.Role;
import com.fish.system.domain.User;
import com.fish.system.service.UserService;
import com.fish.system.utils.DataGridView;
import com.fish.system.utils.MessageConstant;
import com.fish.system.utils.WebUtils;
import com.fish.system.vo.RoleVo;
import com.fish.system.vo.UserVo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName UserServiceImpl
 * @Description (user)业务层接口实现类
 * @Author 柚子茶
 * @Date 2020/11/26 18:03
 * @Version 1.0
 */
@Service
public class UserServiceImpl implements UserService {


	@Autowired
	private UserDao userDao;

	@Autowired
	private RoleDao roleDao;

	/**
	 * @param userVo 封装user数据的实例化对象
	 * @return com.foot.system.domain.User
	 * @Description 登录验证
	 * @author 柚子茶
	 * @date 2020/11/26 18:06
	 **/
	@Override
	public User userLogin(UserVo userVo) {
		// MD5加密
		userVo.setUserPassword(DigestUtils.md5DigestAsHex(userVo.getUserPassword().getBytes()));
		return userDao.userLogin(userVo);
	}

	/**
	 * @param userVo 封装user数据的实例化对象
	 * @return DataGridView
	 * @description 查询用户信息
	 * @author 柚子茶
	 * @date 2021/1/10 13:42
	 **/
	@Override
	public DataGridView queryUserInfo(UserVo userVo) {
		User user = (User) WebUtils.getHttpSession().getAttribute("user");
		// 如果当前登录的用户角色为店长
		if (user.getUserType() == 1) {
			// 那么查询的是所有店员的账户信息
			// 而不是管理员和店长本身的信息
			userVo.setUserType(2);
		}
		// 开启分页
		Page<Object> page = PageHelper.startPage(userVo.getPage(), userVo.getLimit());
		List<User> userList = this.userDao.queryUserInfo(userVo);
		return new DataGridView(page.getTotal(), userList);
	}

	/**
	 * @param userId 用户ID
	 * @return void
	 * @description 删除用户信息
	 * @author 柚子茶
	 * @date 2021/1/11 20:46
	 **/
	@Override
	public void deleteUserInfo(Integer userId) {
		this.userDao.deleteUserInfo(userId);
	}

	/**
	 * @param userVo 封装user数据的实例化对象
	 * @return void
	 * @description 修改用户信息
	 * @author 柚子茶
	 * @date 2021/1/11 20:54
	 **/
	@Override
	public void updateUserInfo(UserVo userVo) {
		this.userDao.updateUserInfo(userVo);
	}

	/**
	 * @param userVo 封装user数据的实例化对象
	 * @return void
	 * @description 添加管理员
	 * @author 柚子茶
	 * @date 2021/1/11 22:00
	 **/
	@Override
	public void addUserInfo(UserVo userVo) {
		// 设置添加用户的登录密码
		userVo.setUserPassword(DigestUtils.md5DigestAsHex(userVo.getUserPassword().getBytes()));
		// 获取到当前登录的用户
		User user = (User) WebUtils.getHttpSession().getAttribute("user");
		// 判断当前登录的用户是否为店长
		if (user.getUserType() == 1) {
			// 是店长登录则店长添加的用户全部为员工
			userVo.setUserType(2);
		}
		this.userDao.addUserInfo(userVo);
	}

	/**
	 * @param userVo
	 * @return void
	 * @description 保存给用户分配的权限
	 * @author 柚子茶
	 * @date 2021/2/25 12:36
	 **/
	@Override
	public void insertUserHasRole(UserVo userVo) {
		Integer userId = userVo.getUserId();
		Integer[] ids = userVo.getUserIds();
		// 先删除已经保存的数据
		this.userDao.deleteUserAndRoleByUserId(userId);
		//循环遍历进行保存
		for (Integer roleId : ids) {
			// 先根据角色ID查询出该角色信息
			/*Role role = this.roleDao.queryRoleByRoleId(roleId);
			if ("系统管理员".equals(role.getRoleName())){
				userVo.setUserType(0);
				this.updateUserInfo(userVo);
			}
			if ("店长".equals(role.getRoleName())){
				userVo.setUserType(1);
				this.updateUserInfo(userVo);
			}
			if ("店员".equals(role.getRoleName())){
				userVo.setUserType(2);
				this.updateUserInfo(userVo);
			}*/
			this.userDao.insertUserHasRole(userId, roleId);
		}
	}

	/**
	 * @param userVo
	 * @return DataGridView
	 * @description 加载角色信息
	 * @author 柚子茶
	 * @date 2021/2/25 13:13
	 **/
	@Override
	public DataGridView queryAssignRoleData(UserVo userVo) {
		//查询出所有的角色数据
		RoleVo roleVo = new RoleVo();
		//设置查询的角色为可用角色
		roleVo.setAvailable(MessageConstant.AVAILABLE_TRUE);
		List<Role> allRoleList = roleDao.queryRoleInfo(roleVo);

		//根据用户Id查询出该用户拥有的角色权限
		List<Role> userHasRoleList = this.roleDao.queryUserHasRoleByUserId(userVo.getUserId());

		//遍历判断
		List<Map<String, Object>> dataList = new ArrayList<>();
		for (Role allRole : allRoleList) {
			Boolean LAY_CHECKED = false;
			for (Role userHasRole : userHasRoleList) {
				if (allRole.getRoleId().equals(userHasRole.getRoleId())) {
					LAY_CHECKED = true;
					break;
				}
			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("roleId", allRole.getRoleId());
			map.put("roleName", allRole.getRoleName());
			map.put("roleDesc", allRole.getRoleDesc());
			map.put("available", allRole.getAvailable());
			map.put("LAY_CHECKED", LAY_CHECKED);
			dataList.add(map);
		}
		return new DataGridView(dataList);
	}

	/**
	 * @param userVo
	 * @return void
	 * @description 重置用户密码
	 * @author 柚子茶
	 * @date 2021/3/6 11:42
	 **/
	@Override
	public void resetUserPassword(UserVo userVo) {
		userVo.setUserPassword(DigestUtils.md5DigestAsHex(userVo.getUserPassword().getBytes()));
		this.userDao.updateUserInfoByUserId(userVo);
	}

	/**
	 * @param userVo
	 * @return User
	 * @description 校验用户手机号是否存在
	 * @author 柚子茶
	 * @date 2021/3/8 17:28
	 **/
	@Override
	public boolean checkUserPhone(UserVo userVo) {
		if (null != userVo.getUserId()) {
			User user = this.userDao.queryUserInfoById(userVo.getUserId());
			if (user.getUserPhone().equals(userVo.getUserPhone())) {
				return false;
			} else {
				User user1 = this.userDao.queryUserInfoByPhone(userVo.getUserPhone());
				if (null != user1) {
					return true;
				} else {
					return false;
				}
			}
		} else {
			User user2 = this.userDao.queryUserInfoByPhone(userVo.getUserPhone());
			if (null != user2) {
				return true;
			} else {
				return false;
			}
		}
	}

}
