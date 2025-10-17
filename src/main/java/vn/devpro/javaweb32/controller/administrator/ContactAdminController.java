package vn.devpro.javaweb32.controller.administrator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.Contact;
import vn.devpro.javaweb32.service.ContactService;

@Controller
@RequestMapping("admin/contact/")
public class ContactAdminController extends BaseController{
	
	@Autowired 
    private ContactService contactService;
    
    // Danh sách tất cả liên hệ
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(Model model) {
        List<Contact> contacts = contactService.findAllActive();
        model.addAttribute("contacts", contacts);
        return "administrator/contact/contact-list";
    }
    
    // Danh sách liên hệ chưa đọc
    @RequestMapping(value = "unread", method = RequestMethod.GET)
    public String unreadList(Model model) {
        List<Contact> unreadContacts = contactService.findUnreadContacts();
        model.addAttribute("contacts", unreadContacts);
        model.addAttribute("title", "Liên hệ chưa đọc");
        return "administrator/contact/contact-list";
    }
    
    // Xem chi tiết liên hệ và đánh dấu đã đọc
    @RequestMapping(value = "detail/{contactId}", method = RequestMethod.GET)
    public String detail(@PathVariable("contactId") int contactId, Model model) {
        Contact contact = contactService.getById(contactId);
        
        // Đánh dấu đã đọc
        if (contact != null && !contact.getIsRead()) {
            contactService.markAsRead(contactId);
        }
        
        model.addAttribute("contact", contact);
        return "administrator/contact/contact-detail";
    }
    
    // Xóa liên hệ (chuyển status = false)
    @RequestMapping(value = "delete/{contactId}", method = RequestMethod.GET)
    public String delete(@PathVariable("contactId") int contactId) {
        Contact contact = contactService.getById(contactId);
        if (contact != null) {
            contact.setStatus(false);
            contactService.saveOrUpdate(contact);
        }
        return "redirect:/admin/contact/list";
    }
	
}
