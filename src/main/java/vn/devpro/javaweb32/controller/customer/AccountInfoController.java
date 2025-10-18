package vn.devpro.javaweb32.controller.customer;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.User;
import vn.devpro.javaweb32.service.UserService;

@Controller
public class AccountInfoController extends BaseController {

	@Autowired
	private UserService userService;

	@GetMapping(value = "/account")
	public String accountInfo() {
		return "customer/account-info";
	}

	@PostMapping("/account/update")
	public String updateAccountInfo(
	        @RequestParam("customerName") String name,
	        @RequestParam("customerAddress") String address,
	        @RequestParam("customerPhone") String mobile,
	        @RequestParam("customerEmail") String email,
	        @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile
	) throws IOException {

	    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

	    if (!(principal instanceof User)) {
	        return "redirect:/login";
	    }

	    User loginedUser = (User) principal;

	    // Cập nhật thông tin cơ bản
	    loginedUser.setName(name);
	    loginedUser.setAddress(address);
	    loginedUser.setMobile(mobile);
	    loginedUser.setEmail(email);

	    // Nếu có upload ảnh mới
	    if (avatarFile != null && !avatarFile.isEmpty()) {
	        String uploadDir = "UploadFiles/User/Avatar/";
	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }
	        String fileName = avatarFile.getOriginalFilename();
	        String filePath = uploadDir + fileName;

	        Files.copy(avatarFile.getInputStream(), Paths.get(filePath));
	        loginedUser.setAvatar(filePath);
	    }

	    userService.saveOrUpdate(loginedUser);

	    return "redirect:/account?success=update";
	}

}
