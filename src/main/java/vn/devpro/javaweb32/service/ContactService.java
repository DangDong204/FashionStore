package vn.devpro.javaweb32.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.Contact;

@Service
public class ContactService extends BaseService<Contact>{

	@Override
	public Class<Contact> clazz() {
		
		return Contact.class;
	}
	
	// Lấy danh sách contact chưa đọc
    public List<Contact> findUnreadContacts() {
        String sql = "SELECT * FROM tbl_contact WHERE is_read = 0 AND status = 1 ORDER BY create_date DESC";
        return executeNativeSql(sql);
    }
    
    // Lấy danh sách contact đã đọc
    public List<Contact> findReadContacts() {
        String sql = "SELECT * FROM tbl_contact WHERE is_read = 1 AND status = 1 ORDER BY create_date DESC";
        return executeNativeSql(sql);
    }
    
    // Lấy tất cả contact (cho admin)
    public List<Contact> findAllActive() {
        String sql = "SELECT * FROM tbl_contact WHERE status = 1 ORDER BY create_date DESC";
        return executeNativeSql(sql);
    }
    
    // Đánh dấu đã đọc
    public void markAsRead(int contactId) {
        Contact contact = getById(contactId);
        if (contact != null) {
            contact.setIsRead(true);
            saveOrUpdate(contact);
        }
    }

}
