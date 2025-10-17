package vn.devpro.javaweb32.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
	
	@Autowired
    private JavaMailSender mailSender;
    
    @Value("${contact.email.to}")
    private String toEmail;
    
    @Value("${contact.email.from}")
    private String fromEmail;
    
    @Value("${spring.mail.username}")
    private String smtpUsername;
    
    public void sendContactNotification(String customerName, String customerEmail, 
                                      String subject, String message) {
        try {
            System.out.println("🔄 Đang gửi email...");
            System.out.println("📧 SMTP Username: " + smtpUsername);
            System.out.println("📨 From: " + fromEmail);
            System.out.println("📩 To: " + toEmail);
            
            SimpleMailMessage mailMessage = new SimpleMailMessage();
            
            mailMessage.setFrom(fromEmail);
            mailMessage.setTo(toEmail);
            mailMessage.setSubject("📧 Liên hệ mới từ: " + customerName);
            
            String emailContent = 
                "Thông tin liên hệ mới từ website:\n\n" +
                "👤 Họ tên: " + customerName + "\n" +
                "📧 Email: " + customerEmail + "\n" +
                "📋 Chủ đề: " + (subject != null ? subject : "Không có chủ đề") + "\n" +
                "💬 Nội dung:\n" + message + "\n\n" +
                "---\n" +
                "Email được gửi tự động từ hệ thống";
                
            mailMessage.setText(emailContent);
            
            mailSender.send(mailMessage);
            System.out.println("✅ Email thông báo đã được gửi thành công đến: " + toEmail);
            
        } catch (Exception e) {
            System.err.println("❌ Lỗi gửi email: " + e.getMessage());
            System.err.println("🔧 Nguyên nhân có thể:");
            System.err.println("   - Chưa bật 2-Factor Authentication");
            System.err.println("   - Sai App Password");
            System.err.println("   - Chưa bật Less Secure App Access");
            e.printStackTrace();
        }
    }
}
