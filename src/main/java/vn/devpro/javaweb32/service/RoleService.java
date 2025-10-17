package vn.devpro.javaweb32.service;

import org.springframework.stereotype.Service;

import vn.devpro.javaweb32.model.Role;

@Service
public class RoleService extends BaseService<Role>{

	@Override
	public Class<Role> clazz() {
		
		return Role.class;
	}

}
