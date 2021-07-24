package com.runtime6.web.example.service;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dao.JoinDao;
import com.runtime6.web.example.model.dto.Join;
import com.runtime6.web.example.model.dto.JoinParam;


//서비스 어노테이션이 있어서 객체 생성할 준비를 하고 있다가 호출을 하면 생성되서 우리가 메소드를 그냥
//가져다가 쓸 수 있다.
@Service("joinService")
public class JoinService {
	
	private Logger logger = Logger.getLogger(JoinService.class);
	@Autowired
	private JoinDao joinDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	
	@Value("#{runtime6Prop['file.upload.dir']}")
	private String fileDir;
	
	@Transactional
	public ResultVO createUser(JoinParam param) {
		String newPwd = param.getPasswd();
		param.setPasswd(passwordEncoder.encodePassword(newPwd, null));//encodePassword암호화하는 클래스
		int ret = joinDao.createUser(param); 
		if (ret > 0) {
			joinDao.createUserAuthority(param);
		}
		ResultVO result = new ResultVO();
		return result;
	}
	
	
	
	@Transactional
	public int createProvider(JoinParam param) throws IOException {
		String name = param.getBuss_file().getOriginalFilename();
		
		boolean hasFile = name != null && !"".equals(name);
		int result = -1;
		Join join = new Join();
		
		if(hasFile) {		
			join.setImg_name(name);	
			join.setImg_path(param.getBuss_file().getOriginalFilename());
			//파일이 있으면 넣어줌.
			result = joinDao.createBussFile(join);
		}
		if(result > 0) {	
			String newPwd =param.getPasswd();
			System.out.println(param.getPasswd());
			param.setPasswd(passwordEncoder.encodePassword(newPwd, null));//encodePassword암호화하는 클래스
			System.out.println(param.getPasswd());
			param.setF_no(join.getF_no());
			System.out.println("파일번호   "+param.getF_no());
			int ret = joinDao.createProvider(param); 
			if (ret > 0) {
				joinDao.createUserAuthority(param);
			}
		}
	
		if(result > 0 && hasFile) {
				FileOutputStream fos = new FileOutputStream(fileDir + name);
				InputStream is = param.getBuss_file().getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);
				byte[] buffer = new byte[2048];
				while(bis.read(buffer) != -1) {
					fos.write(buffer);
				}
				fos.close();
			}
		System.out.println("result : "+ result);
		return result;

	}
	
	@Transactional
	public ResultVO checkValidation(JoinParam param) {
		int countCid = joinDao.checkCid(param);//조인값을 체크(1아니면0이오면)이값은 int로 countCid에 저장
//		int countWorkNo = joinDao.checkWorkNo(param);
//		resultJson.accumulate("workNo", countWorkNo == 0);
//		
//		ExtJsResultVO result = new ExtJsResultVO();
//		result.setRoot(resultJson);
		//중복확인
		JSONObject resultJson = new JSONObject();
		resultJson.accumulate("cid", countCid == 0);
		return new ResultVO(resultJson);
		
	}
	
}
