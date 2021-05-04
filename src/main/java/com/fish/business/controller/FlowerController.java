package com.fish.business.controller;

import com.fish.business.domain.Flower;
import com.fish.business.service.FlowerService;
import com.fish.business.vo.FlowerVo;
import com.fish.system.utils.CommonReturnType;
import com.fish.system.utils.DataGridView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName FlowerController
 * @Description 鲜花进货管理的前端控制器
 * @Author 柚子茶
 * @Date 2021/3/1 13:33
 * @Version 1.0
 */
@RestController
@RequestMapping("flower")
public class FlowerController {

	@Autowired
	private FlowerService flowerService;


	/**
	 * @param flowerVo 鲜花信息实体类
	 * @return DataGridView
	 * @description 查询鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:37
	 **/
	@RequestMapping("loadFlowerDataByAll")
	public DataGridView loadFlowerDataByAll(FlowerVo flowerVo) {
		return this.flowerService.queryFlowerDataByAll(flowerVo);
	}


	/**
	 * @param flowerVo
	 * @return CommonReturnType
	 * @description 添加鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:39
	 **/
	@RequestMapping("addFlowerData")
	public CommonReturnType addFlowerData(FlowerVo flowerVo) {
		try {
			this.flowerService.addFlowerData(flowerVo);
			return CommonReturnType.ADD_SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return CommonReturnType.ADD_FAILURE;
		}
	}

	/**
	 * @param flowerVo
	 * @return CommonReturnType
	 * @description 修改鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:42
	 **/
	@RequestMapping("updateFlowerData")
	public CommonReturnType updateFlowerData(FlowerVo flowerVo) {
		try {
			this.flowerService.updateFlowerData(flowerVo);
			return CommonReturnType.MODIFY_SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return CommonReturnType.MODIFY_FAILURE;
		}
	}

	/**
	 * @param flowerVo
	 * @return CommonReturnType
	 * @description 删除鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:44
	 **/
	@RequestMapping("deleteFlowerData")
	public CommonReturnType deleteFlowerData(FlowerVo flowerVo) {
		try {
			this.flowerService.deleteFlowerData(flowerVo);
			return CommonReturnType.DELETE_SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return CommonReturnType.DELETE_FAILURE;
		}
	}


}
