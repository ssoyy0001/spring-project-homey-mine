package org.homey.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.homey.domain.SiScheduleVO;
import org.homey.service.SiRequestService;
import org.homey.service.SiScheduleService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/sischedule/*")
@AllArgsConstructor
public class SiScheduleController {
	private SiScheduleService sicheService;
	private SiRequestService sireqService;
	@GetMapping("sicheList")

	public void sicheList() {

	}

	@GetMapping("list")//풀켈린더에서 사용되는 ajax ,list를 반환
	@ResponseBody
	public ResponseEntity<List<SiScheduleVO>> getAllSchedules() {
		List<SiScheduleVO> list = sicheService.sicheList();
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	@GetMapping("sicheMyList")
	public void sicheMyList(String mid) {
		
	}
	@GetMapping("myList")//풀켈린더에서 사용되는 ajax ,list를 반환
	@ResponseBody
	public ResponseEntity<List<SiScheduleVO>> getMySchedules(@RequestParam("mid") String mid) {
		List<SiScheduleVO> list = sicheService.sicheMyList(mid);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping({"sicheView","sicheModify"})
	public void view(int sicheNo,Model model) {
		model.addAttribute("sicheVO",sicheService.sicheView(sicheNo));
	}
	@PostMapping("sicheModify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String sicheModift(SiScheduleVO sicheVO,RedirectAttributes rttr) {
		//DB에 Date형으로 값이 들어가게 하기위함(input type="date" 는 달력형태로 값을 고를 수 있지만 String임)
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date startDate = formatter.parse(sicheVO.getStartDateStr());
			Date endDate = formatter.parse(sicheVO.getEndDateStr());
			sicheVO.setStartDate(startDate);
			sicheVO.setEndDate(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(sicheService.sicheModify(sicheVO)) {
			rttr.addFlashAttribute("msg", "수정이 완료되었습니다.");
		}else {
			rttr.addFlashAttribute("msg", "수정 실패!");			
		}
		return "redirect:/sischedule/sicheView?sicheNo="+sicheVO.getSicheNo();
	}
	
	@PostMapping("checkDate")//팀별 날짜 중복체크
	@ResponseBody
	public ResponseEntity<List<SiScheduleVO>>checkDate(String workCrew){
		List<SiScheduleVO> sicheVO=sicheService.checkDate(workCrew);
		log.info(sicheVO);
			return ResponseEntity.ok(sicheVO);
		
		}
	@GetMapping("sicheRegist")
	public void sicheRegist(int sireqNo,Model model) {
		model.addAttribute("sireqVO",sireqService.get(sireqNo));
	}
	@PostMapping("sicheRegist")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String regist(SiScheduleVO sicheVO,RedirectAttributes rttr) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date startDate = formatter.parse(sicheVO.getStartDateStr());
			Date endDate = formatter.parse(sicheVO.getEndDateStr());
			sicheVO.setStartDate(startDate);
			sicheVO.setEndDate(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(sicheService.sicheRegister(sicheVO)) {
			rttr.addFlashAttribute("msg","등록 완료");
		}else {
			rttr.addFlashAttribute("msg","등록 실패");			
		}
		return "redirect:/sischedule/sicheList";
		
	}
	@PostMapping("sicheRemove")
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ResponseEntity<String> sicheRemove(int sicheNo) {
		return sicheService.sicheRemove(sicheNo)? new ResponseEntity<>(HttpStatus.OK)
				   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
