package org.homey.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.homey.domain.Criteria;
import org.homey.domain.NoticeAttachVO;
import org.homey.domain.NoticeVO;
import org.homey.domain.PageDTO;
import org.homey.service.NoticeService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {
	private NoticeService noticeService;

	// 첨부파일 조회
	@GetMapping(value = "attachList")
	public ResponseEntity<List<NoticeAttachVO>> attachList(int notNo) {
		log.info("attachList........." + notNo);
		return new ResponseEntity<>(noticeService.attachList(notNo), HttpStatus.OK);
	}

	// 첨부 파일 삭제
	public void deleteFiles(List<NoticeAttachVO> attachList) {
		log.info("delete files.....");
		if (attachList == null || attachList.size() == 0) {
			return;
		}
		attachList.forEach(navo -> {
			Path file = Paths
					.get("c:\\upload\\" + navo.getUpFolder() + "\\" + navo.getUuid() + "_" + navo.getFileName());
			try {
				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbnail = Paths.get(
							"c:\\upload\\" + navo.getUpFolder() + "\\s_" + navo.getUuid() + "_" + navo.getFileName());
					Files.deleteIfExists(thumbnail);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
	}

	//공지사항 등록 페이지 이동 GET
	@GetMapping("register")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public void register() {
	}

	//공지사항 등록 POST 
	@PostMapping("register")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public String register(NoticeVO nvo, RedirectAttributes rttr) {
		log.info("register......");
		if (noticeService.register(nvo)) {
			rttr.addFlashAttribute("result", nvo.getNotNo());
		}
		return "redirect:/notice/list";
	}

	//공지사항 전체 목록 조회
	@GetMapping("list")
	public void list(Model model, Criteria cri) {
		log.info("list......" + cri);
		model.addAttribute("noticeList", noticeService.list(cri));
		int totalCount = noticeService.totalCount(cri);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
		model.addAttribute("totalCount", totalCount);
	}

	//공지사항 상세조회
	@GetMapping({ "view", "modify" })
	public void view(@RequestParam("notNo") int notNo, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("view or modify......");
		model.addAttribute("nvo", noticeService.view(notNo));
	}

	//공지사항 수정 POST
	@PostMapping("modify")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public String modify(NoticeVO nvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("modify......");
		if (noticeService.modify(nvo)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		// 공지사항 수정 후, 공지사항 목록 페이지로 리다이렉션
		return "redirect:/notice/list";
	}

	//공지사항을 삭제 POST
	@PostMapping("remove")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public String remove(String writer, int notNo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("remove...... notNo : " + notNo);
		//공지사항에 첨부된 파일 목록 가져오기
		List<NoticeAttachVO> attachList = noticeService.attachList(notNo);
		if (noticeService.remove(notNo)) {
			log.info("remove ok");
			// 첨부파일 삭제
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		// 공지사항 삭제 후, 공지사항 목록 페이지로 리다이렉션
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/notice/list";
	}

}
