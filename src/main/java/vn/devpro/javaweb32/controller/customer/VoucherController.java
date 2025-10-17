package vn.devpro.javaweb32.controller.customer;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.number.NumberStyleFormatter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import vn.devpro.javaweb32.controller.BaseController;
import vn.devpro.javaweb32.dto.Cart;
import vn.devpro.javaweb32.model.Voucher;
import vn.devpro.javaweb32.service.VoucherService;

@Controller
public class VoucherController extends BaseController{
	
	@Autowired VoucherService vs;
	
	@RequestMapping(value = "/apply-voucher", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> applyVoucher(HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        String code = request.getParameter("code");
        if (cart == null || cart.getCartProducts().isEmpty()) {
            result.put("valid", false);
            result.put("message", "Giỏ hàng của bạn đang trống.");
            return result;
        }

        Voucher voucher = vs.findByCode(code);
        if (voucher == null) {
            result.put("valid", false);
            result.put("message", "Mã giảm giá không tồn tại.");
            return result;
        }

        // Kiểm tra trạng thái và thời gian hiệu lực
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime start = voucher.getStartDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
        LocalDateTime end = voucher.getEndDate() == null ? now.plusDays(1)
                : voucher.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();

        if (!voucher.getStatus() || now.isBefore(start) || now.isAfter(end)) {
            result.put("valid", false);
            result.put("message", "Mã giảm giá đã hết hạn hoặc không còn hiệu lực.");
            return result;
        }

        if (voucher.getQuantity() <= 0) {
            result.put("valid", false);
            result.put("message", "Mã giảm giá này đã hết lượt sử dụng.");
            return result;
        }

        BigDecimal cartTotal = cart.totalCartPrice();
        if (cartTotal.compareTo(voucher.getMinOrderValue()) < 0) {
            result.put("valid", false);
            result.put("message", "Đơn hàng chưa đạt giá trị tối thiểu để dùng mã này.");
            return result;
        }
        
        System.out.println("cartTotal = " + cartTotal);
        System.out.println("discountType = " + voucher.getDiscountType());
        System.out.println("discountValue = " + voucher.getDiscountValue());
        
        // Tính số tiền giảm
        BigDecimal discount;
        if (voucher.getDiscountType() == Voucher.DiscountType.PERCENT) {
            discount = cartTotal.multiply(voucher.getDiscountValue())
                    .divide(new BigDecimal("100"), RoundingMode.HALF_UP)
                    .setScale(0, RoundingMode.HALF_UP);
            System.out.println("1 - PERCENT discount applied");
        } else {
            discount = voucher.getDiscountValue();
            System.out.println("2 - AMOUNT discount applied");
        }

        // Không cho giảm quá tổng tiền
        if (discount.compareTo(cartTotal) > 0) discount = cartTotal;

        BigDecimal newTotal = cartTotal.subtract(discount);
        
        
        System.out.println("discount = " + discount);
        System.out.println("newTotal = " + newTotal);

        
        // Lưu voucher đã áp dụng vào session
        session.setAttribute("appliedVoucher", voucher);
        session.setAttribute("discountValue", discount);
        
    	// Format lại tiền Việt Nam
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        String newTotalFormatted = formatter.format(newTotal) + " ₫";
        String discountText;
        if (voucher.getDiscountType() == Voucher.DiscountType.PERCENT) {
            discountText = formatter.format(discount) + " ₫"; // Hiển thị số tiền thực tế được giảm
        } else {
            discountText = formatter.format(discount) + " ₫"; // Hiển thị số tiền thực tế được giảm
        }

        result.put("valid", true);
        result.put("discountText", discountText); // Sửa thành discountText đã format
        result.put("newTotalFormatted", newTotalFormatted);
        result.put("message", "Áp dụng mã thành công!");
        return result;
    }
}
