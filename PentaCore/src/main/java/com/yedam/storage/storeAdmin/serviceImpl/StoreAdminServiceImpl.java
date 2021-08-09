package com.yedam.storage.storeAdmin.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.storeAdmin.service.StoreAdminService;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@Service
public class StoreAdminServiceImpl implements StoreAdminService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<StoreAdminVO> usingStrorageList() {
		return sqlSession.selectList("usingStrorageList");
	}

	@Override
	public List<StoreAdminVO> usingStrorageListPaging(StoreAdminVO vo) {
		return sqlSession.selectList("usingStrorageListPaging",vo);
	} 

}
