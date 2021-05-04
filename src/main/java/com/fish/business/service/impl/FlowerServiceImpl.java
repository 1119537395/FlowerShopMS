package com.fish.business.service.impl;

import com.fish.business.dao.FlowerDao;
import com.fish.business.domain.Flower;
import com.fish.business.service.FlowerService;
import com.fish.business.vo.FlowerVo;
import com.fish.system.utils.AppFileUtils;
import com.fish.system.utils.DataGridView;
import com.fish.system.utils.MessageConstant;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @ClassName FlowerServiceImpl
 * @Description 鲜花的业务层接口实现类
 * @Author 柚子茶
 * @Date 2021/3/1 13:32
 * @Version 1.0
 */
@Service
public class FlowerServiceImpl implements FlowerService {

	@Autowired
	private FlowerDao flowerDao;


	/**
	 * @param flowerVo 鲜花实体类
	 * @return DataGridView
	 * @description 查询鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 13:59
	 **/
	@Override
	public DataGridView queryFlowerDataByAll(FlowerVo flowerVo) {
		// 开启分页
		Page<Object> page = PageHelper.startPage(flowerVo.getPage(), flowerVo.getLimit());
		List<Flower> flowerList = this.flowerDao.queryFlowerDataByAll(flowerVo);

		return new DataGridView(page.getTotal(),flowerList);
	}

	/**
	 * @param flowerVo
	 * @return void
	 * @description 添加鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 14:10
	 **/
	@Override
	public void addFlowerData(FlowerVo flowerVo) {
		flowerVo.setCreateTime(new Date());
		// 判断是否上传了鲜花图片
		// 如果获取到的值不是默认值的代表是上传了鲜花图片
		if (!flowerVo.getFlowerImageAddress().equals(MessageConstant.IMG_DEFAULT_ADDRESS)){
			// 用户上传了鲜花图片
			// 将图片文件的临时后缀去掉
			String fileNameNoSuffix = AppFileUtils.modifyFileSuffix(flowerVo.getFlowerImageAddress(), MessageConstant.FILE_UPLOAD_TEMP);
			flowerVo.setFlowerImageAddress(fileNameNoSuffix);
		}
		// 如果上传的是默认的图片则直接进行保存
		this.flowerDao.insertFlowerData(flowerVo);
	}

	/**
	 * @param flowerVo
	 * @return void
	 * @description 更新鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 14:25
	 **/
	@Override
	public void updateFlowerData(FlowerVo flowerVo) {
		// 判断是否对上传的鲜花图片做了修改
		if (flowerVo.getFlowerImageAddress().endsWith(MessageConstant.FILE_UPLOAD_TEMP)){
			// 将之前上传的旧的鲜花图片删除
			Flower flower = this.flowerDao.selectFlowerById(flowerVo.getFlowerId());
			if (!flower.getFlowerImageAddress().equals(MessageConstant.IMG_DEFAULT_ADDRESS)){
				AppFileUtils.deleteFileUsePath(flower.getFlowerImageAddress());
			}

			// 对新上传的鲜花图片去除临时后缀文件后缀
			String fileSuffix = AppFileUtils.modifyFileSuffix(flowerVo.getFlowerImageAddress(), MessageConstant.FILE_UPLOAD_TEMP);
			flowerVo.setFlowerImageAddress(fileSuffix);
		}

		this.flowerDao.updateFlowerData(flowerVo);
	}

	/**
	 * @param flowerVo
	 * @return void
	 * @description 删除鲜花信息
	 * @author 柚子茶
	 * @date 2021/3/1 14:25
	 **/
	@Override
	public void deleteFlowerData(FlowerVo flowerVo) {
		// 查询出删除的鲜花信息
		Flower flower = this.flowerDao.selectFlowerById(flowerVo.getFlowerId());
		// 对上传的图片进行删除(系统默认使用的图片不会被删除)
		if (!flower.getFlowerImageAddress().equals(MessageConstant.IMG_DEFAULT_ADDRESS)){
			AppFileUtils.deleteFileUsePath(flower.getFlowerImageAddress());
		}
		this.flowerDao.deleteFlowerData(flowerVo.getFlowerId());
	}
}
