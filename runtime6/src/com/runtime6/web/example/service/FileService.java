package com.runtime6.web.example.service;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.runtime6.web.example.model.dao.BusinessDAO;
import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;

@Service
public class FileService {
	
	@Value("#{runtime6Prop['file.upload.dir']}")
	private String fileDir;
	
	@Autowired
	private BusinessDAO businessDAO;

	public Business getUploadFile(String item_f_no) {
		return businessDAO.getUploadFile(item_f_no);
	}
	
	public Business fileUpload(BusinessParam param) throws IOException {
		System.out.println("파일업로드 서비스");
		String name = param.getUpload().getOriginalFilename();
		System.out.println(name);
		boolean hasFile = name != null && !"".equals(name);
		System.out.println(hasFile);
		Business business = new Business();
		
		if (hasFile) {
			business.setImg_name(param.getUpload().getName());
			business.setImg_path(param.getUpload().getOriginalFilename());
						
			if (businessDAO.insertUploadFile(business) > 0) {
				FileOutputStream fos = new FileOutputStream(fileDir + name);
				InputStream is = param.getUpload().getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);
				byte[] buffer = new byte[2048];
				while(bis.read(buffer) != -1) {
					fos.write(buffer);
				}		
				fos.close();
			}
		}
		return business;
	}
}
