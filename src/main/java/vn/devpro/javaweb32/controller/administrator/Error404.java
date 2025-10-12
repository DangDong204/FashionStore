package vn.devpro.javaweb32.controller.administrator;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Error404 {
	@RequestMapping(value ="/admin/error404")
	public String list(Model model) {
		return "administrator/layout/error404";
	}
}
