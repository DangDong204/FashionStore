package vn.devpro.javaweb32.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_contact")
public class Contact extends BaseModel{
	
	@Column(name = "name", length = 255, nullable = false)
	private String name;

	@Column(name = "email", length = 255, nullable = false)
	private String email;

	@Column(name = "phone", length = 20, nullable = true)
	private String phone;

	@Column(name = "subject", length = 500, nullable = true)
	private String subject;

	@Column(name = "message", columnDefinition = "TEXT", nullable = false)
	private String message;

	@Column(name = "is_read")
	private Boolean isRead;

	public Contact() {
		super();
	}

	public Contact(Integer id, Integer createBy, Integer updateBy, Date createDate, Date updateDate, Boolean status,
			String name, String email, String phone, String subject, String message, Boolean isRead) {
		super(id, createBy, updateBy, createDate, updateDate, status);
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.subject = subject;
		this.message = message;
		this.isRead = isRead;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Boolean getIsRead() {
		return isRead;
	}

	public void setIsRead(Boolean isRead) {
		this.isRead = isRead;
	}	
	
	
}
