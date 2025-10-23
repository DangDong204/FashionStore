package vn.devpro.javaweb32.service;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.configurer.VNPayConfigurer;
import vn.devpro.javaweb32.dto.VNPayPaymentDto;

@Service
public class VNPayService {
	@Autowired VNPayConfigurer vnPayConfig;
	
	public String createPayment(HttpServletRequest request, VNPayPaymentDto paymentDto) {
	    Map<String, String> vnp_Params = new HashMap<>();
	    vnp_Params.put("vnp_Version", vnPayConfig.getVnp_Version());
	    vnp_Params.put("vnp_Command", vnPayConfig.getVnp_Command());
	    vnp_Params.put("vnp_TmnCode", vnPayConfig.getVnp_TmnCode());
	    
	    // Convert amount to VNPay format (multiply by 100)
	    long amount = paymentDto.getAmount().multiply(BigDecimal.valueOf(100)).longValue();
	    vnp_Params.put("vnp_Amount", String.valueOf(amount));
	    
	    vnp_Params.put("vnp_CurrCode", "VND");
	    
	    String vnp_TxnRef = String.valueOf(System.currentTimeMillis());
	    vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
	    
	    vnp_Params.put("vnp_OrderInfo", paymentDto.getOrderInfo());
	    vnp_Params.put("vnp_OrderType", vnPayConfig.getVnp_OrderType());
	    
	    String locate = "vn";
	    if (paymentDto.getLanguage() != null && !paymentDto.getLanguage().isEmpty()) {
	        locate = paymentDto.getLanguage();
	    }
	    vnp_Params.put("vnp_Locale", locate);
	    
	    vnp_Params.put("vnp_ReturnUrl", vnPayConfig.getVnp_ReturnUrl());
	    vnp_Params.put("vnp_IpAddr", getIpAddress(request));
	    
	    // Tạo thời gian
	    Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	    
	    String vnp_CreateDate = formatter.format(cal.getTime());
	    vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
	    
	    cal.add(Calendar.MINUTE, 15);
	    String vnp_ExpireDate = formatter.format(cal.getTime());
	    vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
	    
	    if (paymentDto.getBankCode() != null && !paymentDto.getBankCode().isEmpty()) {
	        vnp_Params.put("vnp_BankCode", paymentDto.getBankCode());
	    }

	    // QUAN TRỌNG: Sắp xếp tham số theo thứ tự alphabet
	    List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
	    Collections.sort(fieldNames);
	    
	    StringBuilder hashData = new StringBuilder();
	    StringBuilder query = new StringBuilder();
	    
	    Iterator<String> itr = fieldNames.iterator();
	    while (itr.hasNext()) {
	        String fieldName = itr.next();
	        String fieldValue = vnp_Params.get(fieldName);
	        if (fieldValue != null && fieldValue.length() > 0) {
	            // Build hash data - KHÔNG encode cho hash data
	            hashData.append(fieldName);
	            hashData.append('=');
	            hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8)); // QUAN TRỌNG: ENCODE giá trị cho hash data
	            
	            // Build query - CÓ encode cho URL
	            query.append(URLEncoder.encode(fieldName, StandardCharsets.UTF_8));
	            query.append('=');
	            query.append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8));
	            
	            if (itr.hasNext()) {
	                query.append('&');
	                hashData.append('&');
	            }
	        }
	    }
	    
	    // Tạo secure hash từ hashData (đã được encode)
	    String vnp_SecureHash = vnPayConfig.hashAllFields(vnp_Params);
	    
	    // Thêm secure hash vào query
	    query.append("&vnp_SecureHash=");
	    query.append(vnp_SecureHash);
	    
	    String paymentUrl = vnPayConfig.getVnp_PayUrl() + "?" + query.toString();
	    
	    // Debug chi tiết
	    System.out.println("=== DEBUG VNPay ===");
	    System.out.println("Hash Data: " + hashData.toString());
	    System.out.println("Generated Hash: " + vnp_SecureHash);
	    System.out.println("Full URL: " + paymentUrl);
	    
	    return paymentUrl;
	}
	
	public Map<String, String> processReturn(HttpServletRequest request) {
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if (fieldValue != null && fieldValue.length() > 0) {
                fields.put(fieldName, fieldValue);
            }
        }
        
        return fields;
    }
    
    public boolean validateSignature(Map<String, String> params, String secureHash) {
        String signValue = vnPayConfig.hashAllFields(params);
        return secureHash.equals(signValue);
    }
	
    private String getIpAddress(HttpServletRequest request) {
        String ipAddress;
        try {
            ipAddress = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = request.getRemoteAddr();
            }
            // Nếu là IPv6 localhost, chuyển sang IPv4
            if ("0:0:0:0:0:0:0:1".equals(ipAddress)) {
                ipAddress = "127.0.0.1";
            }
        } catch (Exception e) {
            ipAddress = "127.0.0.1";
        }
        System.out.println("Client IP: " + ipAddress);
        return ipAddress;
    }
}
