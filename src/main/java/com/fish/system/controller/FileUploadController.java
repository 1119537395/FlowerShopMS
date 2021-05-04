package com.fish.system.controller;

import com.fish.system.utils.AppFileUtils;
import com.fish.system.utils.DataGridView;
import com.fish.system.utils.MessageConstant;
import com.fish.system.utils.RandomUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName FileUploadController
 * @Description 图片上传的前端控制器
 * @Author 柚子茶
 * @Date 2021/3/1 12:43
 * @Version 1.0
 */
@Controller
@RequestMapping("file")
public class FileUploadController {

	/**
	 * @param mf
	 * @return DataGridView
	 * @description 文件上传
	 * @author 柚子茶
	 * @date 2021/3/1 12:50
	 **/
	@ResponseBody
	@RequestMapping("uploadFile")
	public DataGridView uploadFile(MultipartFile mf) throws IOException {

		//得到文件上传的父级目录
		String parentPath = AppFileUtils.PATH;
		//得到当前的日期作为文件夹的名称
		String systemTime = RandomUtils.getSystemTime();
		//构建文件夹对象
		File dirName = new File(parentPath, systemTime);
		if (!dirName.exists()) {
			dirName.mkdirs();
		}
		//得到文件的原名称
		String originalFilename = mf.getOriginalFilename();
		//得到文件的新名称
		String newFileName = RandomUtils.createRandomFileNameByTime(originalFilename,MessageConstant.FILE_UPLOAD_TEMP);
		//组装文件对象
		File file = new File(dirName, newFileName);
		//将文件流写入file中
		mf.transferTo(file);

		//创建Map对象构建返回标准JSon数据格式
		Map<String, Object> map = new HashMap<>(16);

		//将图片上传到服务器的地址保存到map中
		map.put("src", systemTime + "/" + newFileName);

		//将保存的地址返回前台
		return new DataGridView(map);
	}

	/**
	 * @param path 图片路径
	 * @param response 回复响应
	 * @return ResponseEntity<Object>
	 * @description 显示图片
	 * @author 柚子茶
	 * @date 2021/3/1 12:52
	 **/
	@RequestMapping("showImgFileInformation")
	public ResponseEntity<Object> showImgFileInformation(String path, HttpServletResponse response) {
		return AppFileUtils.downloadFile(response, path, "");
	}


	/**
	 * @param path 图片路径
	 * @param response 回复响应
	 * @return ResponseEntity<Object>
	 * @description 下载图片
	 * @author 柚子茶
	 * @date 2021/3/1 12:52
	 **/
	@RequestMapping("downloadFile")
	public ResponseEntity<Object> downloadFile(String path, HttpServletResponse response) {
		String oldName = "";
		return AppFileUtils.downloadFile(response, path, oldName);
	}


}
