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
	
	@Setter(onMethod_ = @Autowired)
	private EmailService emailService;
	
	
	@GetMapping("/send/emailForm")			//클라이언트가 '/send/email'로 들어왔을 때
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String sendMail(Model model, @RequestParam("mailAddress")String mailAddress) {					//list.jsp에서 버튼 클릭하면 등록폼으로 이동할 수 있도록
		log.info("sendMail Form......" + mailAddress + "에게 메일 전송할 것");
		
		model.addAttribute("mailAddress", mailAddress);
		return "/email/sendMail";				//sendMail.jsp로 이동
	}//END register()
	
	
	
	@GetMapping("/send/sendMail")			//클라이언트가 '/send/email'로 들어왔을 때 등록 처리 로직
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String send(EmailVO evo, RedirectAttributes rttr) throws MessagingException{ 		// 저는 input type 값을 클래스로 생성해서 클래스로 만들게요 ~
		        
        System.out.println("mail send....."+evo.getMailAddress());
        System.out.println("mail send....."+evo.getMailTitle());
        System.out.println("mail send....."+evo.getMailContent());
        
        String mailContentFinal = evo.getMailContent().replace("\n", "<br>");
        
        emailService.sendMail(evo.getMailAddress(), evo.getMailTitle(), mailContentFinal);
        rttr.addFlashAttribute("msg", "메일이 발송되었습니다.");
        
        return "redirect:/send/emailForm?mailAddress="+evo.getMailAddress();			//(아마 수정 필요) sendMail.jsp로 이동하는 것. 위에서 보낸 message 모달에 띄울 수 있게 처리하기
    
	}
	

	
}
