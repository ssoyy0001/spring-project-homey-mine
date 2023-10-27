package org.homey.controller;

import org.homey.domain.ScCriteria;
import org.homey.domain.ScPageDTO;
import org.homey.service.ScrabService;
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

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Controller
@RequestMapping("/scrab/*")
@AllArgsConstructor
public class ScrabController {
	private ScrabService scrabService;

	@GetMapping("myScrab")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public void myScrab(Model model, ScCriteria cri,String mid) {
		
		model.addAttribute("list",scrabService.scrabList(mid, cri));
		int totalCount=scrabService.myscrabTotalCnt(mid);
		model.addAttribute("pageDTO",new ScPageDTO(cri,totalCount));
	}

	@PostMapping("regist")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public ResponseEntity<String> addScrab(@RequestParam("scid") int scid, @RequestParam("mid") String mid) {
	log.info(mid);
	log.info(scid);
		return scrabService.addScrab(scid, mid)	 ? new ResponseEntity<>("success", HttpStatus.OK)
				   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PostMapping("remove")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public ResponseEntity<String> removeScrab(@RequestParam("scid") int scid, @RequestParam("mid") String mid) {
		return scrabService.removeScrab(scid, mid)? new ResponseEntity<>("success", HttpStatus.OK)
				   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping("isScrab")
	@ResponseBody
	public ResponseEntity<String> isScrab(@RequestParam("scid") int scid,@RequestParam("mid") String mid) {
		log.info(scrabService.isScrab(scid, mid));
		return scrabService.isScrab(scid, mid)?new ResponseEntity<>("scrab", HttpStatus.OK)
				   : new ResponseEntity<>("not", HttpStatus.OK);
	}
	@PostMapping("scrabCnt")
	@ResponseBody
	public  ResponseEntity<Integer> scrabCnt(@RequestParam("scid") int scid){
		int scrabCnt=scrabService.scScrabCnt(scid);
		  if(scrabCnt >= 0) {
		        return ResponseEntity.ok(scrabCnt);
		    } else {
		        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		    }
	}
	@PostMapping("updateScrabCnt")
	@RequestMapping
	public ResponseEntity<String> updateScrabCnt(@RequestParam("scid") int scid){
		int scrabCnt=scrabService.scScrabCnt(scid);
		return scrabService.updateScrabCnt(scid, scrabCnt)?new ResponseEntity<>("success", HttpStatus.OK)
				   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
}
