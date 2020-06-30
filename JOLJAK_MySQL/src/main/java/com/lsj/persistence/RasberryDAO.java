package com.lsj.persistence;

import java.util.List;

import com.lsj.domain.RasberryVO;

public interface RasberryDAO {

	public List<RasberryVO> readList(RasberryVO vo) throws Exception;
	
}
