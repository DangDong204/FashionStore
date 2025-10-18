package vn.devpro.javaweb32.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.User;

@Service
public class UserDetailsServiceImpl extends BaseService<User> implements UserDetailsService{

	@Override
	public Class<User> clazz() {
		return User.class;
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		// Lay user trong tbl_user theo username
		
		String sql = "SELECT * FROM tbl_user u WHERE u.username ='" + username + "' AND u.status=1";
		System.out.println(sql);
		User user = this.getEntityByNativeSQL(sql);
		if (user != null) {
			System.out.println(user.getUsername());
			System.out.println(user.getPassword());
			return user;
		} else {
			return new User(); // UserDetails khong duoc null
		}
	}
	
}
