package org.homey.controller;

import javax.servlet.http.HttpServletRequest;

import org.homey.domain.MemberVO;
import org.homey.domain.ScCriteria;
import org.homey.domain.ScPageDTO;
import org.homey.service.MemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/gen/*")
@AllArgsConstructor
public class GenController {
	private MemberService memberService;
	private PasswordEncoder pwEncoder;
	
	@GetMapping("main")
	public void mainPage() {
	}

	@GetMapping("admin")
	public void adminPage() {
	}

	@GetMapping("myPage")
	public void myPage() {
	}

	@GetMapping("join") // 회원가입과 로그인
	public void join() {
	}

	@PostMapping("join")
	public String join(MemberVO mvo, RedirectAttributes rttr) {
		String pw= mvo.getPw();
		mvo.setPw(pwEncoder.encode(pw));
		if(memberService.regist(mvo)) {
		rttr.addFlashAttribute("msg","회원가입이 완료되었습니다");
		}else {
			rttr.addFlashAttribute("msg","회원가입 실패!");
		}
		
		log.info(mvo);
		return "redirect:/gen/login";
	}
	@GetMapping("jusoPopup")
	public void jusoApi() {}

	@PostMapping("checkId")
	@ResponseBody
	public ResponseEntity<String> checkId(@RequestParam("mid") String mid) {// 아이디 중복체크
		return memberService.chkId(mid)
				 ? new ResponseEntity<>("success", HttpStatus.OK)
						   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping("login") // 회원가입과 로그인
	public String login(String error, String logout, Model model) {
		log.info("Login()");
		log.info("error:" + error);
		log.info("logout:" + logout);

		if (error != null) {
			model.addAttribute("error", "로그인 에러 ");
		}
		if (logout != null) {
			model.addAttribute("logout", "로그아웃이 완료되었습니다. ");
		}

		return "/gen/login";
	}

	@GetMapping("logout")
	public String customLogout() {
		return "/gen/logout";
	}

	@GetMapping("findID")
	public void findId() {

	}

	@PostMapping("findID")
	@ResponseBody
	public ResponseEntity<String> findId(@RequestParam("mname") String mname, @RequestParam("mphone") String mphone) {
		String username = memberService.findId(mname, mphone);

		if (username != null) {
			return ResponseEntity.ok(username);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("findPW")
	public void findPw(String msg,Model model) {
		model.addAttribute("msg",msg);
	}

	@PostMapping("findPW")
	public String findPW( String mid, String mname,
			 String mphone,RedirectAttributes rttr,Model model) {
		String user = memberService.findPw(mid, mname, mphone);
		if (user != null) {
			rttr.addFlashAttribute("mid",user);
			return "redirect:/gen/pwModify";
		} else {
			rttr.addFlashAttribute("msg","다시 입력해 주세요");
			return "redirect:/gen/findPW";
		}
	}

	@GetMapping("pwModify")
	public void modifyPW() {	
		
	}

	@PostMapping("pwModify")
	public String modifyPW(String mid, String newPW, RedirectAttributes rttr) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();//시큐리티에서 권한찾아오기 위함
		String pw=pwEncoder.encode(newPW);
		if (memberService.modifyPw(mid, pw)) {
			rttr.addFlashAttribute("msg", "비밀번호 변경이 완료되었습니다.");
			if (auth == null || !auth.isAuthenticated()) {//로그인 x
				return "redirect:/gen/login";
			}else {//로그인 후 회원정보에서 비밀수정으로 들어 왔을 시
				return "redirect:/gen/memberView?mid="+mid;
			}
			
		} else {
			rttr.addFlashAttribute("msg", "비밀번호 변경 실패");
			return "redirect:/gen/pwModify";
		}
	}

	@GetMapping({"memberView","memberModify"})
	@PreAuthorize("principal.username == #mid or hasRole('ROLE_ADMIN')")
	public void view(String mid, Model model, @ModelAttribute("cri") ScCriteria cri) {
		log.info(mid);
		model.addAttribute("mvo", memberService.view(mid));
	}
	@PostMapping("memberModify")
	@PreAuthorize("principal.username == #mvo.mid or hasRole('ROLE_ADMIN')")
	public String memberModify(MemberVO mvo, RedirectAttributes rttr, 
		     			 @ModelAttribute("cri") ScCriteria cri) {
		if(memberService.modify(mvo)) {
			rttr.addFlashAttribute("msg","수정이 완료되었습니다.");
			log.info("성공");
		}else {
			rttr.addFlashAttribute("msg","수정 실패!");	
			log.info("실패");
		}
		return "redirect:/gen/memberView?mid="+mvo.getMid();
		
	}
	@PostMapping("memberRemove")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public String membterRemove(String mid, RedirectAttributes rttr,
	                            HttpServletRequest request) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null) {
	        new SecurityContextLogoutHandler().logout(request, null, auth);
	    }
	    if(memberService.remove(mid)) {
	    	rttr.addFlashAttribute("msg","탈퇴가 완료 되었습니다.");
	    }else {
	    	rttr.addFlashAttribute("msg","탈퇴 실패!");
	    }
	    return "redirect:/gen/main";
	}
	@PostMapping("adminRemove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String adminRemove(String mid, RedirectAttributes rttr, 
			@ModelAttribute("cri") ScCriteria cri) {
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		if(memberService.remove(mid)) {
			rttr.addFlashAttribute("msg","삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("msg","삭제 실패!");
		}
		return "redirect:/gen/memberList";
	}
	
	@GetMapping("memberList")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void memberList(Model model, @ModelAttribute("cri") ScCriteria cri) {// 12개씩 페이징할듯
		model.addAttribute("list",memberService.list(cri));
		int totalCount = memberService.totalCount(cri);
		model.addAttribute("pageDTO", new ScPageDTO(cri, totalCount));
	}

}
