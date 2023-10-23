package org.homey.security;

import org.homey.domain.MemberVO;
import org.homey.mapper.MemberMapper;
import org.homey.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("loadUserByUsername:"+username);
		MemberVO mvo=memberMapper.select(username);
		log.info("authlist"+mvo.getAuthList());
		return mvo==null?null:new CustomUser(mvo);
	}

}
