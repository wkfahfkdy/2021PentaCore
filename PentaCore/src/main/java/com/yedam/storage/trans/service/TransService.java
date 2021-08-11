package com.yedam.storage.trans.service;

import java.util.List;

import com.yedam.storage.trans.vo.TransVO;

public interface TransService {
	
	
	
	public List<TransVO> customerListAll(TransVO vo); // 신청내역 all
	public List<TransVO> cuStorage(TransVO vo); // 스토리지 셀렉트박스
	public TransVO myCustomerSelect(TransVO vo); // 신청내역 상세정보
	public TransVO FileupSelect(TransVO vo); // 사후관리 파일업로드
	public int customerInsert(TransVO vo); // 추가정보 입력
	public int customerFileup(TransVO vo); // 사후관리 사진+메모 등록
	public List<TransVO> conveyFullList(); // 캘린더 전체 운송 리스트
	public List<TransVO> conveyStoreList(TransVO vo); // 캘린더 지점 운송 리스트
	
}
