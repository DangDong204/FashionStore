package vn.devpro.javaweb32.dto;

import java.math.BigDecimal;

public class VNPayPaymentDto {
	private BigDecimal amount;
    private String orderInfo;
    private String bankCode;
    private String language;
    
	public VNPayPaymentDto() {
		super();
	}
    
	public VNPayPaymentDto(BigDecimal amount, String orderInfo) {
        this.amount = amount;
        this.orderInfo = orderInfo;
        // Nếu không có bankCode -> hiện danh sách banks cho người dùng chọn
        this.language = "vn";
    }

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(String orderInfo) {
		this.orderInfo = orderInfo;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}
		
}
