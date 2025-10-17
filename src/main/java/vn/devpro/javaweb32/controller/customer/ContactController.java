package vn.devpro.javaweb32.controller.customer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.model.Contact;
import vn.devpro.javaweb32.service.ContactService;
import vn.devpro.javaweb32.service.EmailService;

@Controller
public class ContactController extends BaseController{
	
	@Autowired 
    private ContactService contactService;
    
    @Autowired 
    private EmailService emailService;
    
    // Hiển thị form liên hệ
    @RequestMapping(value = "/contact", method = RequestMethod.GET)
    public String contact(final Model model) {
        model.addAttribute("contact", new Contact());
        return "customer/contact"; // ← ĐÚNG TÊN VIEW
    }

    // Xử lý submit form liên hệ
    @RequestMapping(value = "/contact", method = RequestMethod.POST)
    public String contactPost(final Model model, 
                    final HttpServletRequest request, 
                    final Contact contact) {

        try {
            // Set status = true (active) và isRead = false (chưa đọc)
            contact.setStatus(true);
            contact.setIsRead(false);

            // Lưu contact vào database
            contactService.saveOrUpdate(contact);

            // GỬI EMAIL THÔNG BÁO CHO ADMIN
            emailService.sendContactNotification(
                contact.getName(),
                contact.getEmail(),
                contact.getSubject(),
                contact.getMessage()
            );
            
            // Thông báo thành công
            model.addAttribute("successMessage",
                    "✅ Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi trong thời gian sớm nhất.");

        } catch (Exception e) {
            // Thông báo lỗi
            model.addAttribute("errorMessage", "❌ Có lỗi xảy ra! Vui lòng thử lại.");
            e.printStackTrace();
        }

        // Trả về lại form contact - SỬA THÀNH customer/contact
        model.addAttribute("contact", new Contact());
        return "customer/contact"; // ← SỬA Ở ĐÂY
    }
}
