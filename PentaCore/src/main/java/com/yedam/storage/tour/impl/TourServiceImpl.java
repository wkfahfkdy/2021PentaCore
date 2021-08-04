package com.yedam.storage.tour.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.tour.service.TourService;
import com.yedam.storage.tour.vo.TourVO;

@Service("tourDAO")
public class TourServiceImpl implements TourService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<TourVO> tourManageEx(TourVO vo) {
		return sqlSession.selectList("tourManageEx", vo);
	}

}
