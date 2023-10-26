package org.homey.service;

import javax.mail.MessagingException;

public interface EmailService {

	
	// 이메일 발송 관련 서비스단					
	
	public void sendMail(String to, String subject, String text) throws MessagingException;			//이메일 발송

}
