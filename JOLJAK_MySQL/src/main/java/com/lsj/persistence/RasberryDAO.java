package com.lsj.persistence;

import java.util.List;

import com.lsj.domain.RasberryVO;

public interface RasberryDAO {

	public List<RasberryVO> readList(RasberryVO vo) throws Exception;
	public RasberryVO readInfo() throws Exception;
	public void updateOnoff(RasberryVO vo) throws Exception;
	public RasberryVO selectOnoff(RasberryVO vo) throws Exception;
	
}
