package com.lsj.service;

import java.util.List;

import com.lsj.domain.RasberryVO;
import com.lsj.domain.RasberryloginVO;
import com.lsj.persistence.RasberryDAO;
import com.lsj.persistence.RasberryloginDAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RasberryloginServiceImpl implements RasberryloginService {
	
	@Autowired
	private RasberryloginDAO loginDAO;

	@Override
	public RasberryloginVO login(RasberryloginVO vo) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.login(vo);
	}
	
}
