package com.fish.system.utils;

/**
 * @InterfaceName MessageConstant
 * @Description 通用常量的定义
 * @Author 柚子茶
 * @Date 2020/12/11 23:26
 * @Version 1.0
 */
public interface MessageConstant {


	/** 可用状态 */
	Integer AVAILABLE_TRUE = 1;
	Integer AVAILABLE_FALSE = 0;

	/**
	 * 用户类型
	 */
	Integer USER_TYPE_SUPER = 1;
	Integer USER_TYPE_NORMAL = 2;
	Integer USER_TYPE_NO = 3;


	/**
	 * 操作状态
	 */
	String DATA_ADD_SUCCESS = "数据添加成功~";
	String DATA_ADD_FAILURE = "数据添加失败~";

	String UPDATE_DATA_SUCCESS = "数据更新成功~";
	String UPDATE_DATA_FAILURE = "数据更新失败~";

	String DELETE_DATA_SUCCESS = "数据删除成功~";
	String DELETE_DATA_FAILURE = "数据删除失败~";

	String ASSIGN_DATA_SUCCESS = "分配权限成功~";
	String ASSIGN_DATA_FAILURE = "分类权限失败~";

	Integer CODE_SUCCESS = 200;
	Integer CODE_ERROR = 404;


	/**
	 * 常用String类型的数字常量
	 */
	String CODE_NUMBER_STRING_ONE = "1";
	String CODE_NUMBER_STRING_ZERO = "0";

	/**
	 * 常用Integer类型的数字常量
	 */
	Integer CODE_NUMBER_INTEGER_ONE = 1;
	Integer CODE_NUMBER_INTEGER_ZERO = 0;

	/**
	 * 用户默认密码
	 */
	String USER_DEFAULT_PASSWORD = "123456";

	/**
	 * 临时文件后缀
	 */
	String FILE_UPLOAD_TEMP = "_temp";

	/**
	 * 默认图片地址
	 */
	String IMG_DEFAULT_ADDRESS = "images/defaultPicture.jpg";
	String PICTURE__DEFAULT_ADDRESS = "images/default.png";

	/**
	 * 鲜花订单号的开头
	 */
	String ORDER_HEAD = "XH";


}
