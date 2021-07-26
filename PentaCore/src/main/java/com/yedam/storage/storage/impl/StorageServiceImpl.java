package com.yedam.storage.storage.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yedam.storage.storage.service.StorageService;
import com.yedam.storage.storage.vo.StorageVO;


@Repository("storageDAO")
public class StorageServiceImpl implements StorageService {

	@Autowired
	private SqlSessionTemplate sql;
	
	@Override
	public List<StorageVO> storageSelectList() {
		return sql.selectList("storageSelectList");
	}

}
