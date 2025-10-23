package vn.devpro.javaweb32.controller.customer;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.dto.VNPayPaymentDto;
import vn.devpro.javaweb32.model.SaleOrder;
import vn.devpro.javaweb32.service.SaleOrderService;
import vn.devpro.javaweb32.service.VNPayService;

@Controller
public class VNPayController extends BaseController {

	@Autowired
	VNPayService vnPayService;

	@Autowired
	SaleOrderService sos;

	@RequestMapping(value = "/create-payment", method = RequestMethod.GET)
	public String createPayment(HttpServletRequest request, HttpSession session) {
		// Lấy thông tin từ session
		BigDecimal totalAmount = (BigDecimal) session.getAttribute("totalCartPrice");
		SaleOrder pendingOrder = (SaleOrder) session.getAttribute("pendingOrder");

		if (totalAmount == null || pendingOrder == null) {
			return "redirect:/checkout";
		}
		
		System.out.println("Creating payment for order: " + pendingOrder.getCode());
	    System.out.println("Amount: " + totalAmount);
	    System.out.println("=== DEBUG TIME INFO ===");
        System.out.println("Current time: " + new Date());
        System.out.println("Calendar time: " + Calendar.getInstance().getTime());
        System.out.println("Creating payment for order: " + pendingOrder.getCode());
        System.out.println("Amount: " + totalAmount);
        
		// Tạo payment DTO
		VNPayPaymentDto paymentDto = new VNPayPaymentDto(totalAmount, "Thanh toan don hang " + pendingOrder.getCode());

		String paymentUrl = vnPayService.createPayment(request, paymentDto);

		return "redirect:" + paymentUrl;
	}

	@RequestMapping(value = "/payment-return")
	public String paymentReturn(HttpServletRequest request, HttpSession session, Model model) {
	    Map<String, String> fields = vnPayService.processReturn(request);

	    String vnp_ResponseCode = fields.get("vnp_ResponseCode");
	    String vnp_TransactionNo = fields.get("vnp_TransactionNo");
	    String vnp_Amount = fields.get("vnp_Amount");
	    String vnp_OrderInfo = fields.get("vnp_OrderInfo");

	    SaleOrder pendingOrder = (SaleOrder) session.getAttribute("pendingOrder");

	    if ("00".equals(vnp_ResponseCode)) {
	        // Thanh toán thành công
	        if (pendingOrder != null) {
	            // Cập nhật trạng thái đơn hàng
	            pendingOrder.setOrderStatus(1); // Đã thanh toán
	            pendingOrder.setPaymentMethod(1); // VNPay
	            sos.saveOrUpdate(pendingOrder);

	            // Xóa session
	            session.removeAttribute("pendingOrder");
	            session.removeAttribute("cart");
	            session.removeAttribute("appliedVoucher");
	            session.removeAttribute("discountValue");

	            model.addAttribute("success", true);
	            model.addAttribute("orderCode", pendingOrder.getCode());
	            model.addAttribute("transactionNo", vnp_TransactionNo);
	            model.addAttribute("amount", new BigDecimal(vnp_Amount).divide(BigDecimal.valueOf(100)));
	        }
	    } else {
	        // Thanh toán thất bại - KHÔNG XÓA ĐƠN HÀNG
	        model.addAttribute("success", false);
	        model.addAttribute("message", "Thanh toán thất bại. Vui lòng thử lại.");

	        if (pendingOrder != null) {
	            // THAY VÌ XÓA, chỉ cập nhật trạng thái thành "thanh toán thất bại"
	            pendingOrder.setOrderStatus(3); // Thanh toán thất bại
	            sos.saveOrUpdate(pendingOrder);
	            
	            // GIỮ đơn hàng trong session để người dùng có thể thử lại
	            // session.removeAttribute("pendingOrder"); // KHÔNG xóa khỏi session
	        }
	    }

	    return "customer/payment-return";
	}
}
