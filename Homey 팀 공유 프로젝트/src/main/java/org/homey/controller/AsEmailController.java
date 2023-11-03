package org.homey.controller;

import org.homey.service.ASBoardService;
import org.homey.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.MessagingException;

import org.homey.domain.AsEmailVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class AsEmailController {
 
    private EmailService emailService;
    private ASBoardService asBoardService;

    @Autowired
    public AsEmailController(EmailService emailService, ASBoardService asBoardService) {
        this.emailService = emailService;
        this.asBoardService = asBoardService;
    }

    @GetMapping("/asend/emailForm")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String sendMail(Model model, @RequestParam("bno")int bno) {
        String mailAddress = asBoardService.getEmail(bno);
        log.info("sendMail Form......" + mailAddress + "에게 전송예정");
        model.addAttribute("bno", bno); // 'bno' 파라미터를 모델에 추가
        model.addAttribute("mailAddress", mailAddress);
        return "/email/asendMail"; //sendMail.jsp로 이동
    }

    @GetMapping("/asend/sendMail")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String sendMail(AsEmailVO evo, RedirectAttributes rttr) throws MessagingException{
        
        System.out.println("mail send....."+evo.getMailAddress());
        System.out.println("mail send....."+evo.getMailTitle());
        System.out.println("mail send....."+evo.getMailContent());
        
        String mailContentFinal = evo.getMailContent().replace("\n", "<br>");
        
        emailService.sendMail(evo.getMailAddress(), evo.getMailTitle(), mailContentFinal);
        rttr.addFlashAttribute("msg", "메일이 발송되었습니다.");
        
        return "redirect:/asend/emailForm?bno=" + evo.getBno() + "&mailAddress=" + evo.getMailAddress(); //메일 전송 후 다시 "전송폼"으로 이동
    }
}
