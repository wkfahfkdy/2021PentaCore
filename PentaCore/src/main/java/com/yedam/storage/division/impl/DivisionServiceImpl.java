package com.yedam.storage.division.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.division.service.DivisionService;
import com.yedam.storage.division.vo.DivisionVO;

@Repository("divisionDAO")
public class DivisionServiceImpl implements DivisionService {
	
	@Autowired
	private SqlSessionTemplate map;
	
	@Override
	public List<DivisionVO> divisionSelectList() {
		return map.selectList("divisionSelectList");
	}

}
