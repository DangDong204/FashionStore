package vn.devpro.javaweb32.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.User;

@Service
public class UserService extends BaseService<User>{

	@Override
	public Class<User> clazz() {
		
		return User.class;
	}
	public List<User> findAllActive() {
		String sql = "SELECT * FROM tbl_user WHERE status = 1 ORDER BY id DESC";
		return executeNativeSql(sql);
	}
	
	// Lấy số lượng user
    public Long countAllUsers() {
        String sql = "SELECT COUNT(*) FROM tbl_user";
        Object result = entityManager.createNativeQuery(sql).getSingleResult();
        return result != null ? ((Number) result).longValue() : 0L;
    }
}
