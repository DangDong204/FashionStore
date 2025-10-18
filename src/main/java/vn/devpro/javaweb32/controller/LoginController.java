package vn.devpro.javaweb32.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController extends BaseController{
	
	@GetMapping(value = "/login")
	public String login() {
		return "login";
	}
}
