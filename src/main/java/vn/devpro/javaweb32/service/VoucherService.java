package vn.devpro.javaweb32.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.Voucher;

@Service
public class VoucherService extends BaseService<Voucher>{

	@Override
	public Class<Voucher> clazz() {
		
		return Voucher.class;
	}
	
	public List<Voucher> findAllActive() {
		String sql = "SELECT * FROM tbl_voucher WHERE status = 1";
		return executeNativeSql(sql);
	}
	
	// Tìm voucher theo mã code
	@SuppressWarnings("unchecked")
	public Voucher findByCode(String code) {
		String sql = "SELECT * FROM tbl_voucher WHERE code = '" + code + "'";
		var result = executeNativeSql(sql);
		return result.isEmpty() ? null : result.get(0);
	}

}
