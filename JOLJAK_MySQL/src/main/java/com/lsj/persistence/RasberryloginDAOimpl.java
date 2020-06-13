package com.lsj.persistence;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.lsj.domain.RasberryVO;
import com.lsj.domain.RasberryloginVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RasberryloginDAOimpl implements RasberryloginDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.lsj.mapper.RasberryMapper";

	@Override
	public RasberryloginVO login(RasberryloginVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".login", vo);	
	}
	
}
