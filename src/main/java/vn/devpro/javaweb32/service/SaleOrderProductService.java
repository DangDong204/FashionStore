package vn.devpro.javaweb32.service;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.SaleOrderProduct;

@Service
public class SaleOrderProductService extends BaseService<SaleOrderProduct>{

	@Override
	public Class<SaleOrderProduct> clazz() {
		
		return SaleOrderProduct.class;
	}

}
