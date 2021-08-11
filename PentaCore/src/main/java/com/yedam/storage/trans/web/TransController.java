package com.yedam.storage.trans.web;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.trans.service.TransService;
import com.yedam.storage.trans.vo.TransVO;

@Controller
public class TransController {
	@Autowired
	private TransService transDAO;
	
	// 스케줄
	@RequestMapping("schedule")
	public String schedule() {
		
		return "empty/empty/schedule";
	}
	
	// 신청내역
	@RequestMapping("customer")
	public String customer(Model model, TransVO vo) {

		model.addAttribute("customerListAll", transDAO.customerListAll(vo));
		System.out.println(vo);
		
		return "empty/empty/customer";
	}
	
	// 모달창 list
	@RequestMapping(value="myCustomer", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> myCustomerSelect(Model model, TransVO vo) {
		System.out.println("123");
		System.out.println(vo.getApply_code() + vo.getStore_code());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cus", transDAO.myCustomerSelect(vo));
		map.put("list", transDAO.cuStorage(vo));
		System.out.println("1 : " + transDAO.myCustomerSelect(vo));
		System.out.println("2 : " + transDAO.cuStorage(vo));
		return map;
	}
	
	//추가입력
	@RequestMapping("customerInsert")
	public String customerInsert(TransVO vo) {
		
		transDAO.customerInsert(vo);
		
		return "redirect:customer";
	}

	// 사후관리 페이지이동
	@RequestMapping("FileupSelect")
	public String FileupPage(@RequestParam("apply_code") String apply_code, Model model, TransVO vo) {
		
		model.addAttribute("apply_code", apply_code);
		System.out.println(apply_code);
		model.addAttribute("FileupSelect", transDAO.FileupSelect(vo));
		System.out.println(vo);
		
		return "empty/empty/customerFileup";
	}
	
	
	// file upload
	@RequestMapping("customerFileup")
	public String customerFileup(TransVO vo) {
		
		System.out.println("123");
		transDAO.customerFileup(vo);
		
		
		return "redirect:customer";
	}

	// 월간 캘린더 API TEST (운송관리)
	@RequestMapping("calendarTest")
	public String calendarTest(Model model) {
		
		// CONVEY_APPLY TABLE과 CONVEY_LIST TABLE를 JOIN한 SQL문에서 APPLY_END와 CONVEY_TIME을 가져오고 합쳐야한다.
		// 예시 - APPLY_END : 2021-08-04, CONVEY_TIME : PM 15:00 ~ 16:00
		// 		> String time = vo.getconvey_time
		// 		> String subStartTime = time.substring(3,8); // 21.08.11 기준 데이터 1개 있어서 값 11:00 하나 나옴
		//		> String subEndTime = time.substring(11,16); // 12:00
		// 		> String date = vo.getapply_end + "T" + subtime
		//		> 하면 나올 것 같다
		//					*** 주의점 : 21.08.05 기준 입력 데이터는 'AM 11:00 ~ 12:00'과 같이 입력되어있는데
		//								위와같이 들어가지 않을 시에 substring(x,y) 값을 수정해주어야 함
		// 가져와야 하는 값 : store_id / member_name(id로 join) / tour_date / tour_time
		// 각각 calendarId / title / start, end(투어는 1시간이므로 가져올 때 subtime +1을 해서 subtiem2에 담던말던)
		// 아무튼 여기서 list로 넘겨서 jsp에서 c:forEach로 json type으로 바꾸고 스케쥴하면 나올 것 같다...
		
	
		// 전체 운송 리스트 가져오기.
		List<TransVO> list = transDAO.conveyFullList();
		
		for(int i = 0; i < list.size(); i++) {
			String time =  list.get(i).getConvey_time();
			String subStartTime = time.substring(3,8); 
			String subEndTime = time.substring(11,16); 
			Date date = list.get(i).getApply_end();
			SimpleDateFormat transDate = new SimpleDateFormat("yyyy-MM-dd");
			
			String sumStartDate = transDate.format(date) + "T" + subStartTime;
			String sumEndDate = transDate.format(date) + "T" + subEndTime;
			list.get(i).setStart(sumStartDate);
			list.get(i).setEnd(sumEndDate);
		}
		//System.out.println("vo 조립 확인 : " + list);
			
		model.addAttribute("list", list);
	
		
		return "empty/empty/schedule";
	}
	
}
