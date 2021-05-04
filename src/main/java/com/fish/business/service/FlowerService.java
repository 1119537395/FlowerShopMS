package com.fish.business.service;

import com.fish.business.vo.FlowerVo;
import com.fish.system.utils.DataGridView;

/**
 * @InterfaceName FlowerService
 * @Description 鲜花的业务层接口
 * @Author 柚子茶
 * @Date 2021/3/1 13:31
 * @Version 1.0
 */
public interface FlowerService {

	/**
	 * @param flowerVo
	 * @return DataGridView
	 * @description 查询鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:38
	 **/
	DataGridView queryFlowerDataByAll(FlowerVo flowerVo);

	/**
	 * @param flowerVo
	 * @return void
	 * @description 添加鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:40
	 **/
	void addFlowerData(FlowerVo flowerVo);

	/**
	 * @param flowerVo
	 * @return void
	 * @description 修改鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:42
	 **/
	void updateFlowerData(FlowerVo flowerVo);

	/**
	 * @param flowerVo
	 * @return void
	 * @description 删除鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:44
	 **/
	void deleteFlowerData(FlowerVo flowerVo);
}
