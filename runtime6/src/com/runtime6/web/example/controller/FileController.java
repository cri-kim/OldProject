package com.runtime6.web.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.runtime6.web.example.model.dao.BusinessDAO;
import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;
import com.runtime6.web.example.service.FileService;

	@Controller
	@RequestMapping("/file")
	public class FileController<fileDAO> {
		
		@Autowired
		private BusinessDAO businessDAO;
		
		@Autowired
		private FileService fileService;
		@Value("#{runtime6Prop['file.upload.dir']}")
		private String fileDir;
		
		@RequestMapping("/upload")
		public String upload(BusinessParam param,
				HttpServletRequest request) throws IOException {
			Business business = fileService.fileUpload(param);		
			request.setAttribute("business", business);
			request.setAttribute("uploadParam", param);
			return "/file/fileupload";
		}
	
		@RequestMapping("/download1/{item_f_no}")
		public void download1(@PathVariable String item_f_no, HttpServletResponse response) {	
			Business business = fileService.getUploadFile(item_f_no);
			File file = new File(fileDir + business.getImg_path());
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(file);
				OutputStream os = response.getOutputStream();
				String fileName = URLEncoder.encode(business.getImg_name(), "UTF-8");
				response.setHeader("Content-Disposition", "attachment; filename=" + fileName);		
				byte[] b = new byte[1024];
				while(fis.read(b) != -1) {
					os.write(b);
				}
				os.flush();	
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if (fis != null) try { fis.close(); } catch (IOException e) {}
			}
		}

		@RequestMapping("/download/{item_f_no}")
		public void download(@PathVariable String item_f_no, HttpServletResponse response) {
			Business business= businessDAO.getBusinessFile(item_f_no);
			File file = new File(fileDir + business.getImg_path());
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(file);
				OutputStream os = response.getOutputStream();
				String fileName = URLEncoder.encode(business.getImg_name(), "UTF-8");
				response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
				byte[] b =new byte[1024];
				while(fis.read(b) !=-1){
					os.write(b);
				}
				os.flush();
			} catch (IOException e) {
				// TODO: handle exception
				e.printStackTrace();
			} finally{
				if(fis != null) try{ fis.close();} catch(IOException e) {}
			}
		}
	}

