package com.lsj.service;

import java.util.List;

import com.lsj.domain.RasberryVO;
import com.lsj.persistence.RasberryDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RasberryServiceImpl implements RasberryService {
	
	@Autowired
	private RasberryDAO memberDAO;
	
	public List<RasberryVO> readRasberryList(RasberryVO vo) throws Exception{
		return memberDAO.readList(vo);
	}

	@Override
	public RasberryVO readRasberryInfo() throws Exception {
		return memberDAO.readInfo();
	}

	@Override
	public void updateOnoff(RasberryVO vo) throws Exception {
		memberDAO.updateOnoff(vo);
	}

	@Override
	public RasberryVO selectOnoff(RasberryVO vo) throws Exception {
		return memberDAO.selectOnoff(vo);
	}

	@Override
	public void insertOnoff(String serialnumber) throws Exception {
		memberDAO.insertOnoff(serialnumber);
	}
	
}
