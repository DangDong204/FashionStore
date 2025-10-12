package vn.devpro.javaweb32.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;

@Controller
public class CustomerProductDetailController extends BaseController {

	@RequestMapping(value = "/product-detail", method = RequestMethod.GET)
	public String productDetail() {
		return "customer/product-detail";
	}
}
