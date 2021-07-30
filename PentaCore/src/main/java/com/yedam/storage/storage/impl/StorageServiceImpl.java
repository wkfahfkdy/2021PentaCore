package com.yedam.storage.storage.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yedam.storage.storage.map.StorageMap;
import com.yedam.storage.storage.service.StorageService;
import com.yedam.storage.storage.vo.StorageVO;


@Service
public class StorageServiceImpl implements StorageService {

	@Autowired
	private StorageMap map;
	
	@Override
	public List<StorageVO> storageSelectList() {
		return map.storageSelectList();
	}

}
