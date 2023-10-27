package org.homey.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.homey.domain.ScCriteria;
import org.homey.domain.ScPageDTO;
import org.homey.domain.ShowcaseAttachVO;
import org.homey.domain.ShowcaseVO;
import org.homey.service.ShowcaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Controller
@RequestMapping("/showcase/*")
@AllArgsConstructor
public class ShowcaseController {
	@Setter(onMethod_ = @Autowired)
	private ShowcaseService showcaseService;
	
	@GetMapping("caseList")
	public void list(Model model,ScCriteria cri) {
		model.addAttribute("list",showcaseService.list(cri));
		int totalCount=showcaseService.totalCount(cri);
		log.info(cri.getBuildingType());
		log.info(cri.getSizeRange());
		log.info(cri.getTotalRange());
		model.addAttribute("pageDTO", new ScPageDTO(cri, totalCount));
		
	}
	@GetMapping({"caseView", "caseModify"})
	public void view(int scid, Model model, 
				     @ModelAttribute("cri") ScCriteria cri) {
		model.addAttribute("view",showcaseService.view(scid));
		
	}
	
	
	@PostMapping("caseModify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(ShowcaseVO scvo, RedirectAttributes rttr, 
			 @ModelAttribute("cri") ScCriteria cri) {
		if(showcaseService.modify(scvo)) {
			rttr.addFlashAttribute("msg", "수정이 완료되었습니다.");
		}

		rttr.addAttribute("buildingType", cri.getBuildingType());
		rttr.addAttribute("sizeRange", cri.getSizeRange());
		rttr.addAttribute("totalRange", cri.getTotalRange());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/showcase/caseList";
		}
	@PostMapping("caseRemove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(int scid, RedirectAttributes rttr, 
			 @ModelAttribute("cri") ScCriteria cri) {
		List<ShowcaseAttachVO> attachList=showcaseService.attachList(scid);
		if(showcaseService.remove(scid)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("msg","삭제가 완료되었습니다.");
		}
		rttr.addAttribute("buildingType", cri.getBuildingType());
		rttr.addAttribute("sizeRange", cri.getSizeRange());
		rttr.addAttribute("totalRange", cri.getTotalRange());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/showcase/caseList";
		}
	
	@GetMapping("caseRegist")//여기에서 지연이 누나쪽에서  select?
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void regist() {}
	
	@PostMapping("caseRegist")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String regist(ShowcaseVO scvo,RedirectAttributes rttr) {
		if(showcaseService.register(scvo)) {
			rttr.addFlashAttribute("msg","등록되었습니다.");
		}else{
			rttr.addFlashAttribute("msg","등록 실패!");
		}
		return "redirect:/showcase/caseList";
		}
public void deleteFiles(List<ShowcaseAttachVO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		attachList.forEach(bavo->{
			Path file = Paths.get("c:\\upload\\" + 
									bavo.getUpFolder() + "\\" +
									bavo.getUuid() + "_" +
									bavo.getFileName());
			try {
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbnail = Paths.get("c:\\upload\\" + 
											bavo.getUpFolder() + "\\s_" +
											bavo.getUuid() + "_" + 
											bavo.getFileName());
					Files.deleteIfExists(thumbnail);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
	}
}
