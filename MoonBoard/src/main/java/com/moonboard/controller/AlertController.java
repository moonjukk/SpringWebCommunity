package com.moonboard.controller;

import java.security.Principal;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_replyVO;
import com.moonboard.domain.Criteria;
import com.moonboard.domain.PageDTO;
import com.moonboard.service.BoardService;
import com.moonboard.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/alert/*")
@AllArgsConstructor
public class AlertController {
	@GetMapping("/cant_make_board")
	public void cant_make_board() {}
	
	@GetMapping("/make_board")
	public void make_board() {}
}

