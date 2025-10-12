package vn.devpro.javaweb32.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.javaweb32.controller.BaseController;

@Controller
public class CustomerCartController extends BaseController{
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String cart() {
		return "customer/shop-cart";
	}
}
