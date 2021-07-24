package com.runtime6.web.example.service;

import java.io.IOException;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dao.BusinessDAO;
import com.runtime6.web.example.model.dao.CommentDAO;
import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;
import com.runtime6.web.example.model.dto.Basket;
import com.runtime6.web.example.model.dto.Paging;



@Service
public class BusinessService {
	@Autowired
	private BusinessDAO businessDAO;
	@Autowired
	private CommentDAO commentDAO;
	
	
	@Value("#{runtime6Prop['file.upload.dir']}")
	private String fileDir;
		
	public JSONObject getBusinessList(BusinessParam param) {
		JSONObject json = new JSONObject();
		List<Business> businessList = null;
		int count = businessDAO.getCountBusinessList(param);
		Paging paging = new Paging(param.getCurrPageNo(), count);
		param.setFromRowNum(paging.getFromRowNum());
		param.setToRowNum(paging.getToRowNum());
		
		if(count>0) {
			 businessList =  businessDAO.getBusinessList(param);         
		}	
		json.accumulate("paging", paging);
		json.accumulate("businessList",  businessList);
		return json;
	}
	//상단에 전체검색
	public JSONObject getTotalSearch(BusinessParam param) {
		JSONObject json = new JSONObject();
		List<Business> businessList = null;
		int count = businessDAO.getCountSearchList(param);
		System.out.println("count= "+count);
		Paging paging = new Paging(param.getCurrPageNo(), count);
		param.setFromRowNum(paging.getFromRowNum());
		param.setToRowNum(paging.getToRowNum());
		
		if(count>0) {
			 businessList =  businessDAO.getBusinessList(param);         
		}	
		json.accumulate("paging", paging);
		json.accumulate("businessList",  businessList);
		return json;
	}
	
		
	public Business getBusiness(BusinessParam param){
		System.out.println(businessDAO.getBusiness(param));
		return businessDAO.getBusiness(param);
	}
	@Transactional
	public int insertBusiness(BusinessParam param) throws IOException {
		String name = param.getImg_name();
		System.out.println("name : "+name);
		boolean hasFile = name != null && !"".equals(name);
		int result = -1;
		Business business = new Business();
		
		if(hasFile) {
			business.setImg_name(param.getImg_name());
			//business.setImg_path(param.getBusiness_file().getOriginalFilename());
			business.setImg_path(param.getImg_path());
			business.setVender_id(param.getUpdId());
			business.setItem_f_no(param.getItem_f_no());		
			System.out.println("확인할것 에프아이템엔오 잘넘어왓나");
			System.out.println(business.getItem_f_no());
			result = businessDAO.insertBusinessFile(business);
		}
		System.out.println(result);
		if(result > 0 || result == -1) {
			business.setItem_name(param.getItem_name());
			business.setContent(param.getContent());
			business.setVender_id(param.getVender_id());
			business.setItem_type(param.getItem_type());
			business.setItem_no(param.getItem_no());
			business.setMaximum(param.getMaximum());
			business.setItem_charge(param.getItem_charge());
			business.setRemainder(param.getMaximum());
			business.setItem_f_no(param.getItem_f_no());
			business.setMinimum(param.getMinimum());
			System.out.println(business.getMinimum()+"  서비스성공");
			result = businessDAO.insertBusiness(business);
			System.out.println("파일말고 데이터인설트성공");
		}
		
		/*if(result > 0 && hasFile) {	
				FileOutputStream fos = new FileOutputStream(fileDir + name);
				InputStream is = param.getBusiness_file().getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);
				byte[] buffer = new byte[2048];
				while(bis.read(buffer) != -1) {
					fos.write(buffer);
				}
				fos.close();
			}*/
		System.out.println("result : "+ result);
		return result;
	}
	
	@Transactional
	public ResultVO insertBasket(Basket basket) {	
		int ret = businessDAO.insertBasket(basket); 
		System.out.println("ret값 잘넘어오나  "+ret);
		ResultVO result = new ResultVO();
		return result;
	}
	
	
	public JSONObject pay(BusinessParam param) {
		JSONObject json = new JSONObject();
		return json;
	}
	

}
