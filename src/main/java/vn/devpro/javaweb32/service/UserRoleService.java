package vn.devpro.javaweb32.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.devpro.javaweb32.model.Role;
import vn.devpro.javaweb32.model.User;
import vn.devpro.javaweb32.model.UserRole;

@Service
public class UserRoleService extends BaseService<UserRole>{

	@Override
	public Class<UserRole> clazz() {
		
		return UserRole.class;
	}
	
	// Lấy tất cả role của 1 user
    public List<UserRole> findByUserId(int userId) {
        return executeNativeSql("SELECT * FROM tbl_user_role WHERE user_id = " + userId);
    }
    
    @Transactional
    public void delete(UserRole ur) {
        if (ur != null) {
            entityManager.remove(entityManager.contains(ur) ? ur : entityManager.merge(ur));
        }
    }
    
    // Lưu role cho user
    @Transactional
    public void saveRolesForUser(User user, List<Role> roles) {
        // Xóa hết role cũ
        List<UserRole> oldRoles = findByUserId(user.getId());
        oldRoles.forEach(this::delete);

        // Thêm role mới
        for (Role role : roles) {
            UserRole ur = new UserRole(user, role);
            saveOrUpdate(ur);
        }
    }
}
