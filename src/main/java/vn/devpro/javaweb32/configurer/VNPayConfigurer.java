package vn.devpro.javaweb32.configurer;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class VNPayConfigurer {
	
	@Value("${vnpay.tmnCode}")
	private String vnp_TmnCode;

	@Value("${vnpay.hashSecret}")
	private String vnp_HashSecret;

	@Value("${vnpay.payUrl}")
	private String vnp_PayUrl;

	@Value("${vnpay.returnUrl}")
	private String vnp_ReturnUrl;

	@Value("${vnpay.version}")
	private String vnp_Version;

	@Value("${vnpay.command}")
	private String vnp_Command;

	@Value("${vnpay.orderType}")
	private String vnp_OrderType;

	public String getVnp_TmnCode() {
		return vnp_TmnCode;
	}

	public String getVnp_HashSecret() {
		return vnp_HashSecret;
	}

	public String getVnp_PayUrl() {
		return vnp_PayUrl;
	}

	public String getVnp_ReturnUrl() {
		return vnp_ReturnUrl;
	}

	public String getVnp_Version() {
		return vnp_Version;
	}

	public String getVnp_Command() {
		return vnp_Command;
	}

	public String getVnp_OrderType() {
		return vnp_OrderType;
	}
	
	// Bảo mật
	public String hashAllFields(Map<String, String> fields) {
	    try {
	        // Sắp xếp các fields theo thứ tự alphabet
	        List<String> fieldNames = new ArrayList<>(fields.keySet());
	        Collections.sort(fieldNames);
	        
	        StringBuilder sb = new StringBuilder();
	        Iterator<String> itr = fieldNames.iterator();
	        while (itr.hasNext()) {
	            String fieldName = itr.next();
	            String fieldValue = fields.get(fieldName);
	            if (fieldValue != null && fieldValue.length() > 0) {
	                sb.append(fieldName);
	                sb.append('=');
	                // QUAN TRỌNG: Encode giá trị theo chuẩn URL
	                sb.append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString()));
	                if (itr.hasNext()) {
	                    sb.append('&');
	                }
	            }
	        }
	        
	        String data = sb.toString();
	        System.out.println("Data to hash (encoded): " + data);
	        
	        Mac hmacSha512 = Mac.getInstance("HmacSHA512");
	        SecretKeySpec secretKeySpec = new SecretKeySpec(vnp_HashSecret.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
	        hmacSha512.init(secretKeySpec);
	        
	        byte[] result = hmacSha512.doFinal(data.getBytes(StandardCharsets.UTF_8));
	        StringBuilder hexString = new StringBuilder();
	        for (byte b : result) {
	            hexString.append(String.format("%02x", b));
	        }
	        
	        String hashResult = hexString.toString();
	        System.out.println("Generated hash: " + hashResult);
	        
	        return hashResult;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "";
	    }
	}
    
	// Tạo thời gian khởi tạo khi người dùng bắt đầu thanh toán
    public String getVnp_CreateDate() {
        Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        formatter.setTimeZone(cal.getTimeZone());
        return formatter.format(cal.getTime());
    }
    
    // Quy định người dùng sử dụng VNPay trong 15'
    public String getVnp_ExpireDate() {
        Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
        cal.add(Calendar.MINUTE, 15);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        formatter.setTimeZone(cal.getTimeZone());
        return formatter.format(cal.getTime());
    }
}
