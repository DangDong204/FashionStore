package vn.devpro.javaweb32.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RegisterController extends BaseController{

	@GetMapping(value = "/register")
	public String register() {
		return "register";
	}
}
