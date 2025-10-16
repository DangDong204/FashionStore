package vn.devpro.javaweb32.controller.administrator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.User;
import vn.devpro.javaweb32.service.UserService;

@Controller
@RequestMapping("/admin/user/")
public class UserAdminController extends BaseController {
	
	@Autowired UserService us;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(Model model) {
		List<User> users =  us.findAll();
		model.addAttribute("users", users);
		
		return "administrator/user/user-list";
	}
}
