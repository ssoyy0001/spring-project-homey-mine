package org.homey.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.homey.domain.ASBoardVO;
import org.homey.domain.ASBoardAttachVO;
import org.homey.domain.asCriteria;
import org.homey.domain.asPageDTO;
import org.homey.service.ASBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/asboard/*")
public class ASBoardController {
    private ASBoardService asboardService;

    @GetMapping("asregister")
    @PreAuthorize("hasRole('ROLE_MEMBER')") //로그인 했을 시에만 접근 가능
    public void register(Model model) {
       log.info("as의 register.jsp . . .");
       
        // 사용자 이름(mname) 가져오기
        String mid = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            mid = userDetails.getUsername();
        }
        // 모델에 사용자 이름(mname) 추가
        model.addAttribute("mid", mid);
        
    }

    // 상담을 등록하는 POST 요청을 처리
    @PostMapping("asregister")
    @PreAuthorize("principal.username == #mid or hasRole('ROLE_MEMBER')") //로그인 했을 시에만 등록 가능
    public String register(ASBoardVO avo,  RedirectAttributes rttr) {
        log.info("ASBoardVO의 register. . .");
        log.info("ASBoardVO received: " + avo.toString());

        // 사용자 이름(mid) 가져오기
        String mid = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            mid = userDetails.getUsername();
        }
        // MID를 ConsultVO 객체에 설정
        avo.setMid(mid);
        
        // AS 문의 등록
        if(asboardService.register(avo)) {
			rttr.addFlashAttribute("result", avo.getBno());
		}
       // 등록 성공 시 메인페이지로 이동
        return "redirect:/asboard/asmylist";
    }
  
	


    @GetMapping("aslist")
    @PreAuthorize("hasRole('ROLE_ADMIN')") //로그인 했을 시에만 접근 가능

    public void list(asCriteria cri, Model model) {
        log.info("list: " + cri);
        log.info("pageNum: " + cri.getPageNum() + ", amount: " + cri.getAmount());

        // 사용자가 선택한 검색 조건을 적용하여 ASBoard 목록을 가져옴
        List<ASBoardVO> list = asboardService.listPaging(cri);

        // 전체 ASBoard 수를 가져옴 (페이징 처리를 위해 필요)
        int total = asboardService.getTotal(cri);

        asPageDTO pageDTO = new asPageDTO(cri, total); // PageDTO 객체 생성

        model.addAttribute("list", list);
        model.addAttribute("pageDTO", pageDTO); // 페이지 번호 정보를 모델에 추가
    }

    // 나의 전체 견적상담 목록을 조회하는 GET 요청을 처리
    @GetMapping("asmylist")
    @PreAuthorize("hasRole('ROLE_MEMBER')") //로그인 했을 시에만 접근 가능
    public void list(Model model, asCriteria cri, Authentication authentication) {
    UserDetails userDetails = (UserDetails) authentication.getPrincipal();
    String mid = userDetails.getUsername();

  
    log.info("Current user's ID(mid): " + mid);
    log.info("AS의 나의 list. . .");

    model.addAttribute("mylist", asboardService.list(cri, mid));
    log.info("Calling asboardService.getTotal(cri)...");

    int totalCount = asboardService.getTotal(cri);
    model.addAttribute("pageDTO", new asPageDTO(cri, totalCount));


    }

    
    @GetMapping({"asview", "asmodify"})
    public void view(@RequestParam("bno") int bno, Model model) {
        log.info("view: " + bno);
        ASBoardVO asBoardVO = asboardService.view(bno);
        model.addAttribute("asBoardVO", asBoardVO);
    }

    @PostMapping("asmodify")
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    public String modify(ASBoardVO asBoardVO, RedirectAttributes rttr, asCriteria cri, HttpServletRequest request) {
        log.info("modify:" + asBoardVO);

        if (asboardService.modify(asBoardVO)) {
            rttr.addFlashAttribute("result", "success");
        }
        
        // 수정이 완료된 후 관리자인지 확인
        if (SecurityContextHolder.getContext().getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
            // 관리자라면 이메일 주소를 가져와서 이메일 발송 페이지로 리다이렉트
            String email = asboardService.getEmail(asBoardVO.getBno());
            rttr.addAttribute("bno", asBoardVO.getBno()); // 'bno' 파라미터 추가
            rttr.addAttribute("mailAddress", email);
            return "redirect:/asend/emailForm";
        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/asboard/asview?bno=" + asBoardVO.getBno();
    }

    

    @PostMapping("asremove")
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    public ResponseEntity<String> remove(String mid, int bno, RedirectAttributes rttr, 
                 @ModelAttribute("cri") asCriteria cri) {
        log.info("remove...... bno : " + bno);

        List<ASBoardAttachVO> attachList = asboardService.getBoardAttachList(bno);

        if(asboardService.remove(bno)) {
            log.info("remove ok");
            deleteFiles(attachList);
            rttr.addFlashAttribute("result", "success");
        }

        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
         // 현재 사용자의 권한을 얻습니다.
        Collection<? extends GrantedAuthority> authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();

        // 관리자 권한이 있는 경우
        if (authorities.stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return ResponseEntity.ok("/asboard/aslist");
        } else {
            return ResponseEntity.ok("/asboard/asmylist");
        }
    }

    public void deleteFiles(List<ASBoardAttachVO> attachList) {
        log.info("delete files.....");
        
        if (attachList == null || attachList.size() == 0) {
            return;
        }
        
        attachList.forEach(bavo -> {
            Path file = Paths.get("c:\\upload\\" + bavo.getUuid() + "_" + bavo.getFileName());
            try {
                Files.deleteIfExists(file);
                
                if (Files.probeContentType(file).startsWith("image")) {
                    Path thumbnail = Paths.get("c:\\upload\\s_" + bavo.getUuid() + "_" + bavo.getFileName());
                    Files.deleteIfExists(thumbnail);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
    @RequestMapping(value = "/asboard/redirect", method = RequestMethod.GET)
    public String redirectToList() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().toString();

        if(role.contains("ROLE_ADMIN")){
            return "redirect:/asboard/aslist";
        } else if (role.contains("ROLE_MEMBER")) {
            return "redirect:/asboard/asmylist";
        } else {
            return "redirect:/";
        }
    }


    @GetMapping("attachList")
    public ResponseEntity<List<ASBoardAttachVO>> getAttachList(int bno) {
        log.info("getAttachList: " + bno);
        return new ResponseEntity<>(asboardService.getBoardAttachList(bno), HttpStatus.OK);
    }
}