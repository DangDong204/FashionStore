package vn.devpro.javaweb32.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_user_role")
public class UserRole extends BaseModel{
	
	@ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

	public UserRole() {
		super();
	}

	public UserRole(Integer id, Integer createBy, Integer updateBy, Date createDate, Date updateDate, Boolean status,
			User user, Role role) {
		super(id, createBy, updateBy, createDate, updateDate, status);
		this.user = user;
		this.role = role;
	}
	
	public UserRole(User user, Role role) {
	    super();
	    this.user = user;
	    this.role = role;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	
    
    
	
}
