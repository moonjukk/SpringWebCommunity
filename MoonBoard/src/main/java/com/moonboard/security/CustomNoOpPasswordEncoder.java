package com.moonboard.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {
	//PasswordEncoder를 상속받음
	//클래스명 noop인것은 테스트용으로 잠시 암호화x
	
	public String encode(CharSequence rawPassword) {
		log.warn("before encode :" + rawPassword);
		return rawPassword.toString();
	}

	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		log.warn("matches: " + rawPassword + ":" + encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}

}
