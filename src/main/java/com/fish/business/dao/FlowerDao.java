package com.fish.business.dao;

import com.fish.business.domain.Flower;
import com.fish.business.vo.FlowerVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @InterfaceName FlowerDao
 * @Description 鲜花管理(Flower)数据访问层
 * @Author 柚子茶
 * @Date 2021/3/1 13:26
 * @Version 1.0
 */
public interface FlowerDao {
	/**
	 * @param flowerVo
	 * @return List<Flower>
	 * @description 查询鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 14:00
	 **/
	List<Flower> queryFlowerDataByAll(FlowerVo flowerVo);


	/**
	 * @param flower
	 * @return void
	 * @description 添加鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 14:33
	 **/
	void insertFlowerData(Flower flower);

	/**
	 * @param flower
	 * @return void
	 * @description 修改鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 14:46
	 **/
	void updateFlowerData(Flower flower);

	/**
	 * @param flowerId
	 * @return Flower
	 * @description 根据ID查询鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 15:05
	 **/
	Flower selectFlowerById(@Param("flowerId") Integer flowerId);

	/**
	 * @param flowerId
	 * @return void
	 * @description 删除鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 15:22
	 **/
	void deleteFlowerData(@Param("flowerId") Integer flowerId);
}
