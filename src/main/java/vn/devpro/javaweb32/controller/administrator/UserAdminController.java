package vn.devpro.javaweb32.controller.administrator;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.dto.Jw32Contant;
import vn.devpro.javaweb32.model.Role;
import vn.devpro.javaweb32.model.User;
import vn.devpro.javaweb32.service.RoleService;
import vn.devpro.javaweb32.service.UserRoleService;
import vn.devpro.javaweb32.service.UserService;

@Controller
@RequestMapping("/admin/user/")
public class UserAdminController extends BaseController implements Jw32Contant{
	
	@Autowired UserService us;
	
	@Autowired RoleService rs;
	
	@Autowired UserRoleService urs;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(Model model) {
		List<User> users =  us.findAll();
		List<Role> roles = rs.findAll();
		
		model.addAttribute("users", users);
		model.addAttribute("roles", roles);
		
		return "administrator/user/user-list";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String addUser(User user,
	                      @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile,
	                      @RequestParam(value = "roleIds", required = false) List<Integer> roleIds) 
	                    throws IOException {

	    // Xử lý avatar
	    if (avatarFile != null && !avatarFile.isEmpty()) {
	        String avatarFolder = FOLDER_UPLOAD + "User/Avatar/";
	        File folder = new File(avatarFolder);
	        if (!folder.exists()) folder.mkdirs();

	        String fileName = avatarFile.getOriginalFilename();
	        File dest = new File(avatarFolder + fileName);
	        avatarFile.transferTo(dest);

	        user.setAvatar("UploadFiles/User/Avatar/" + fileName);
	    } else {
	        user.setAvatar("UploadFiles/User/Avatar/avt_default.jpg"); // avatar mặc định
	    }

	    // Password cần hash nếu muốn bảo mật (nếu chưa hash, lưu thẳng)
	    us.saveOrUpdate(user);
	    
	    // ---- XỬ LÝ PHÂN QUYỀN ----
	    List<Role> rolesToAssign;
	    if (roleIds != null && !roleIds.isEmpty()) {
	        // nếu admin chọn role
	        List<Role> allRoles = rs.findAll();
	        rolesToAssign = allRoles.stream()
	                                 .filter(r -> roleIds.contains(r.getId()))
	                                 .collect(Collectors.toList());
	    } else {
	        // Gán role mặc định là <Customer>
			//	1. Admin
			//	2. Staff
			//	3. Customer
	        Role customerRole = rs.getById(3); 
	        rolesToAssign = List.of(customerRole);
	    }
	    urs.saveRolesForUser(user, rolesToAssign);

	    return "redirect:/admin/user/list";
	}

	
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String editUser(User user, 
						@RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile,
						@RequestParam(value = "roleIds", required = false) List<Integer> roleIds)
			throws IOException {

		// Lấy user cũ từ DB
		User oldUser = us.getById(user.getId());

		// Giữ password cũ nếu không thay đổi
	    user.setPassword(oldUser.getPassword());
	    
		// Giữ avatar cũ nếu không upload mới
		user.setAvatar(oldUser.getAvatar());

		// Xử lý upload avatar mới
		if (avatarFile != null && !avatarFile.isEmpty()) {
			String avatarFolder = FOLDER_UPLOAD + "User/Avatar/";
			File folder = new File(avatarFolder);
			if (!folder.exists())
				folder.mkdirs();

			String fileName = avatarFile.getOriginalFilename();
			File dest = new File(avatarFolder + fileName);
			avatarFile.transferTo(dest);

			user.setAvatar("UploadFiles/User/Avatar/" + fileName);
		}

		us.saveOrUpdate(user);
		
		// Lưu phân quyền
	    if (roleIds != null && !roleIds.isEmpty()) {
	        List<Role> roles = rs.findAll(); // lấy tất cả role
	        List<Role> selectedRoles = roles.stream()
                    .filter(r -> roleIds.contains(r.getId()))
                    .collect(Collectors.toList());
	        urs.saveRolesForUser(user, selectedRoles);
	    } else {
	        // nếu không chọn role nào thì xóa tất cả
	        urs.saveRolesForUser(user, List.of());
	    }

		return "redirect:/admin/user/list";
	}
	
	@RequestMapping(value = "delete/{userId}", method = RequestMethod.GET)
	public String deactivateUser(@PathVariable("userId") int userId) {
	    User user = us.getById(userId);
	    if (user != null) {
	        user.setStatus(false); 
	        us.saveOrUpdate(user);
	    }
	    return "redirect:/admin/user/list";
	}


}
