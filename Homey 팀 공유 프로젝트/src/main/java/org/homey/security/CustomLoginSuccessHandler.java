package org.homey.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		log.warn("로그인 성공");
		
		List<String> roleNms=new ArrayList<String>();
		auth.getAuthorities().forEach(authority->{
			roleNms.add(authority.getAuthority());
		});
		if(roleNms.contains("ROLE_ADMIN")){//ROLE_ADMIN이면 /sample/admin으로 리다이렉트
			response.sendRedirect("/sample/admin");
			return;
		}
		if(roleNms.contains("ROLE_MEMBER")){//ROLE_MEMBER이면 /sample/member로 리다이렉트
			response.sendRedirect("/sample/member");
			return;
		}
		response.sendRedirect("/");//그 외는 /로 리다이렉트
	}

}
