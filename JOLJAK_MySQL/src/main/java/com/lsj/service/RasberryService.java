package com.lsj.service;

import java.util.List;

import com.lsj.domain.RasberryVO;

public interface RasberryService {
	
	public List<RasberryVO> readRasberryList(RasberryVO vo) throws Exception;
	public RasberryVO readRasberryInfo() throws Exception;
	public void updateOnoff(RasberryVO vo) throws Exception;
	public RasberryVO selectOnoff(RasberryVO vo) throws Exception;
	public void insertOnoff(String serialnumber) throws Exception;
	
}
