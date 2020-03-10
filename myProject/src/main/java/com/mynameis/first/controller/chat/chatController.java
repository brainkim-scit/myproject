package com.mynameis.first.controller.chat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class chatController {

	private static final Logger logger = LoggerFactory.getLogger(chatController.class);
	
	@GetMapping("/chatting")
	public String chatView() {
		logger.info("채팅창 이동");
		return "chatting";
	}
}
