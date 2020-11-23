package com.moonboard.security;

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
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		log.warn("Login Success");
		System.out.println("!!!!!!!!!!!!!!!!!!! 로그인성공 !!!!!!!!!!!!!!!!!!!!!!!!");

		// 권한이 여러개 일 수 있기때문에 배열로 저장
		List<String> roleNames = new ArrayList<>();
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		System.out.println(roleNames);

		log.warn("ROLE NAMES: " + roleNames);

		if (roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/sample/admin");
			return;
		}

		if (roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/sample/member");
			return;
		}
		
		if (roleNames.contains("ROLE_USER")) {
			System.out.println("ROLE_USER 유저접속");
			response.sendRedirect("/sample/member");
			return;
		}

		response.sendRedirect("/");
	}
}


