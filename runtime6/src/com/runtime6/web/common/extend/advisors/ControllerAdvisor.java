package com.runtime6.web.common.extend.advisors;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.validation.BindingResult;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
//AOP를 쓰기위해서 만든에가 A
@Aspect
public class ControllerAdvisor {
	//loger를 우리가 직접 찍을수도 있다. debug, warn, fatal, info
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Around("execution(com.runtime6.web.common.mvc.model.vo.ResultVO+ com.runtime6.web..controller.*Controller.*(*,org.springframework.validation.BindingResult,..)) && args(*,bindingResult,..)")
	public ResultVO aroundAdviceForResultVO(ProceedingJoinPoint joinPoint, BindingResult bindingResult) throws Throwable {
		if(bindingResult.hasErrors()) {
			ResultVO rvo = new ResultVO();
			rvo.put("error",bindingResult.getFieldErrors());
			
			if (logger.isDebugEnabled()) {
				logger.debug("ResultVO Validation Error");
				logger.debug(bindingResult.getFieldErrors());
			}
			return rvo;
		}
		return (ResultVO)joinPoint.proceed();
	}
}
