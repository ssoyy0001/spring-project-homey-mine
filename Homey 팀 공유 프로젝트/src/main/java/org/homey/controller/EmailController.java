package org.homey.controller;

import org.homey.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.MessagingException;

import org.homey.domain.EmailVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class EmailController {
	
	//원데이클래스, 제품 나눔 당첨자 조회 화면에서 [메일발송] 버튼 클릭하여 접속
	
	@Setter(onMethod_ = @Autowired)
	private EmailService emailService;
	
	
	@GetMapping("/send/emailForm")
	@PreAuthorize("hasRole('ROLE_ADMIN')")							//'ROLE_ADMIN'권한을 가지고 있는 경우에만 접근가능
	public String sendMail(Model model, @RequestParam("mailAddress")String mailAddress) {
		log.info("sendMail Form......" + mailAddress + "에게 전송예정");
		
		model.addAttribute("mailAddress", mailAddress);
		return "/email/sendMail";												//sendMail.jsp로 이동
	}//END sendMail()
	
	
	
	@GetMapping("/send/sendMail")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String sendMail(EmailVO evo, RedirectAttributes rttr) throws MessagingException{
		        
        System.out.println("mail send....."+evo.getMailAddress());
        System.out.println("mail send....."+evo.getMailTitle());
        System.out.println("mail send....."+evo.getMailContent());
        
        String mailContentFinal = evo.getMailContent().replace("\n", "<br>");
        
        emailService.sendMail(evo.getMailAddress(), evo.getMailTitle(), mailContentFinal);
        rttr.addFlashAttribute("msg", "메일이 발송되었습니다.");
        
        return "redirect:/send/emailForm?mailAddress="+evo.getMailAddress();			//메일 전송 후 다시 "전송폼"으로 이동
    
	}//END sendMail()
	

	
}
