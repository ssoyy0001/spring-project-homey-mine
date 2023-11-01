package org.homey.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;


@Service
public class EmailServiceImpl implements EmailService {
	
	@Autowired
	JavaMailSender javaMailSender;

	@Override
	public void sendMail(String to, String subject, String text) throws MessagingException {
		MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setFrom("ssoyy0001@gmail.com");			//발신인 메일주소
        helper.setTo(to);												//수신인 메일주소
        helper.setSubject(subject);									//제목
        helper.setText(text, true);									//내용

        javaMailSender.send(message);

	}

}
