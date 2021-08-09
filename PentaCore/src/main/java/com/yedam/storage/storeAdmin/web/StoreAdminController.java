package com.yedam.storage.storeAdmin.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.review.common.Paging;
import com.yedam.storage.review.vo.ReviewVO;
import com.yedam.storage.storeAdmin.serviceImpl.StoreAdminServiceImpl;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;

@Controller
public class StoreAdminController {

	@Autowired
	private StoreAdminServiceImpl storeAdminDAO;
	

	//고객관리 페이지 이동
	@RequestMapping("store/customerManage")
	public String LoginIdCheck(Model model , StoreAdminVO vo , HttpServletRequest req) {
				
		
				//이용중인 고객 리스트  
		
				String page = req.getParameter("page");
				//요청받은 페이지번호
				if(page == null) {
					page = "1";
				}
				//10개씩 페이징
				int pageCnt = Integer.parseInt(page);
				int firstCnt = (pageCnt - 1) * 5 + 1; // 1 , 11 ,21
				int lastCnt = (pageCnt * 5); // 10 , 20 , 30
				vo.setFirstCnt(firstCnt);
				vo.setLastCnt(lastCnt);
				
				List<StoreAdminVO> total = storeAdminDAO.usingStrorageList();//전체 검색결과
				Paging paging = new Paging();
				paging.setPageNo(pageCnt);//요청받은 페이지
				paging.setPageSize(8);//한페이지에 보여줄 값
				paging.setTotalCount(total.size());//페이지에 필요한 변수 생성
				
				
				
			    
				model.addAttribute("paging", paging);//페이징에 필요한 값
				model.addAttribute("usingStorageList", storeAdminDAO.usingStrorageListPaging(vo));//검색 결과중 페이지에 요청된 페이지에 띄울 결과들
				return "storeAdmin/customerManage";
			
	
	}
	
	// 카카오 지도 API TEST - DATA
		@RequestMapping("store/usingList")
		@ResponseBody
		public List<StoreAdminVO> usingList() {
			// Store - 지점명, 지점주소 (StoreConlloer)
			List<StoreAdminVO> list = storeAdminDAO.usingStrorageList();
			return list;
		}
	
				
	
	
	
	@RequestMapping("store/customerManage2")
	public String LoginIdCheck(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		return "storeAdmin/customerManage2";
		
	}
			
			
		
}
