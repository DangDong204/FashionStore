package vn.devpro.javaweb32.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "tbl_user")
public class User extends BaseModel implements UserDetails{
	@Column(name = "username", nullable = false, length = 120)
    private String username;

    @Column(name = "password", nullable = false, length = 120)
    private String password;

    @Column(name = "name", length = 300)
    private String name;

    @Column(name = "mobile", length = 60)
    private String mobile;

    @Column(name = "email", length = 200)
    private String email;

    @Column(name = "address", length = 300)
    private String address;

    @Column(name = "avatar", length = 300)
    private String avatar;

    @Column(name = "description", length = 500)
    private String description;

	public User() {
		super();
	}

	public User(Integer id, Integer createBy, Integer updateBy, Date createDate, Date updateDate, Boolean status,
			String username, String password, String name, String mobile, String email, String address, String avatar,
			String description) {
		super(id, createBy, updateBy, createDate, updateDate, status);
		this.username = username;
		this.password = password;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.address = address;
		this.avatar = avatar;
		this.description = description;
	}
	
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
	private List<UserRole> userRoles = new ArrayList<>();

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<UserRole> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(List<UserRole> userRoles) {
		this.userRoles = userRoles;
	}
	
	// Thêm phương thức lấy tên role:
	public String getRoleNames() {
	    if (userRoles == null || userRoles.isEmpty()) return "";
	    StringBuilder sb = new StringBuilder();
	    for (UserRole ur : userRoles) {
	        if (ur.getRole() != null) {
	            if (sb.length() > 0) sb.append(", ");
	            sb.append(ur.getRole().getName());
	        }
	    }
	    return sb.toString();
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// Lấy danh sách roles từ userRoles
        return this.userRoles.stream()
                .map(UserRole::getRole)
                .collect(Collectors.toList());
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

	
}
