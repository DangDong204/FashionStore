package vn.devpro.javaweb32.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.devpro.javaweb32.model.Role;
import vn.devpro.javaweb32.model.User;
import vn.devpro.javaweb32.model.UserRole;
import vn.devpro.javaweb32.service.RoleService;
import vn.devpro.javaweb32.service.UserRoleService;
import vn.devpro.javaweb32.service.UserService;

@Controller
public class RegisterController extends BaseController{

	@Autowired UserService us;
	
	@Autowired RoleService rs;
	
	@Autowired UserRoleService urs;
	
	@GetMapping(value = "/register")
	public String register() {
		return "register";
	}
	
	@PostMapping("/register")
    public String doRegister(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("username") String username,
            @RequestParam("password") String password) throws IOException {

        // --- Kiểm tra username trùng ---
        String sql = "SELECT * FROM tbl_user WHERE username = '" + username + "'";
        User existUser = us.getEntityByNativeSQL(sql);
        if (existUser != null) {
            // nếu username đã tồn tại thì quay lại form + thông báo
            return "redirect:/register?error=exists";

        }

        // --- Tạo user mới ---
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setUsername(username);
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        user.setPassword(encoder.encode(password));	// nếu muốn bảo mật hơn, bạn có thể mã hóa bằng BCrypt
        user.setStatus(true);
        user.setAvatar("UploadFiles/User/Avatar/avt_default.jpg");

        us.saveOrUpdate(user);

        // --- Gán quyền mặc định CUSTOMER ---
        Role customerRole = rs.getById(3);
        urs.saveRolesForUser(user, List.of(customerRole));

        // Sau khi đăng ký thành công → quay về trang login
        return "redirect:/login?success=register";

        
    }
}
