package com.lsj.persistence;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.lsj.domain.RasberryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RasberryDAOImpl implements RasberryDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.lsj.mapper.RasberryMapper";
	
	public List<RasberryVO> readList(RasberryVO vo) throws Exception {
		List<RasberryVO> studentlist = new ArrayList<RasberryVO>();
		studentlist = sqlSession.selectList(namespace + ".selectByDate", vo);
		return studentlist;
	}
	
}
