package com.yedam.storage.storeAdmin.web;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yedam.storage.member.serviceImpl.MemberServiceImpl;
import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.mypage.vo.MyPageVO;
import com.yedam.storage.review.common.Paging;
import com.yedam.storage.store.vo.StoreVO;
import com.yedam.storage.storeAdmin.service.StoreAdminService;
import com.yedam.storage.storeAdmin.serviceImpl.StoreAdminServiceImpl;
import com.yedam.storage.storeAdmin.vo.StoreAdminVO;
import com.yedam.storage.tour.service.TourService;
import com.yedam.storage.tour.vo.TourVO;
import com.yedam.storage.trans.service.TransService;
import com.yedam.storage.trans.vo.TransVO;

@Controller
public class StoreAdminController {

	@Autowired
	private StoreAdminServiceImpl storeAdminDAO;
	@Autowired
	private StoreAdminService storeService;
	@Autowired
	private TourService tourDAO;
	@Autowired
	private MemberServiceImpl memberDAO;
	@Autowired
	private TransService transDAO;
	
	// ===================== 정동영 ===================================
	// enterStoreAdmin -> StorageInfoPage (각 지점에 대한 스토리지 현황을 위해 Store_code를 불러온다) + 현재 예약되어있는 정보 List
	@RequestMapping("store/storageInfo")
	public String storageInfo(HttpServletRequest req , Model model, StoreAdminVO vo, StoreVO vo1) {
		HttpSession session = req.getSession();
		String store_code = (String) session.getAttribute("store_code");
		vo.setStore_code(store_code);
		vo1.setStore_code(store_code);
		model.addAttribute("StorageInfoList", storeAdminDAO.selectStorageInfoList(vo));
		model.addAttribute("storageName", storeAdminDAO.storageName());
		// 현재 예약되어있는 정보 List
		model.addAttribute("offerInfoList", storeService.offerInfoList(vo));
		// 현재 지점의 온습도 저보
		model.addAttribute("stroeTemHumInfo", storeService.storeTemHumInfo(vo1));
		return "storeAdmin/StorageInfoPage";
	}
	
	// 사용중인 스토리지 정보
	@RequestMapping("store/usedStorage")
	@ResponseBody
	public StoreAdminVO usedStorage(Model model,  StoreAdminVO vo) {
		System.out.println(vo.getOffer_code() + vo.getStore_code());
		return storeAdminDAO.selectStorageInfo(vo);
	}
	
	// 현재 예약되어 있는 정보 (Ajax)
	@RequestMapping("store/ajaxOfferInfoList")
	@ResponseBody
	public List<StoreAdminVO> offerInfoList(StoreAdminVO vo){
		return storeService.offerInfoList(vo);
	}
	
	// 미사용 스토리지 및 스토리지 예약을 한 정보 (Ajax)
	@RequestMapping("store/offerInfo")
	@ResponseBody
	public Map<String, Object> offerInfo(Model model, StoreAdminVO vo) {
		storeAdminDAO.copyUseNum(vo);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selectOfferInfo", storeService.selectOfferInfo(vo));
		map.put("unUseStorage", storeService.unUseStorageList(vo));
		
		return map;
	}
	
	// use_storage 업데이트
	@RequestMapping("store/updateUseStorage")
	public String updateUseStorage(@RequestParam("store_code") String store_code , StoreAdminVO vo, RedirectAttributes red) {
		System.out.println("fdsfsdf====" + vo.getInfo_num());
		storeService.useStroageUpdate(vo);
		storeService.updateUseProcedure(vo);
		red.addAttribute("store_code", store_code);
		return "redirect:storageInfo";
	}
	
	// 온습도 관리 update
	@RequestMapping("store/temHumUpdate")
	public String updateStoreTemHum(@RequestParam("store_code") String store_code , StoreVO vo, RedirectAttributes red) {
		storeService.storeTemHumUpdate(vo);
		red.addAttribute("store_code", store_code);
		return "redirect:storageInfo";
	}
	
	// 사후보고서 리스트 ajax 호출
	@RequestMapping("store/premiumReportList")
	@ResponseBody
	public List<StoreAdminVO> premiumReportList (Model model, StoreAdminVO vo){
		return storeService.premiumReportList(vo);
	}
	
	// 사후보고서 select Ajax 호출
	@RequestMapping("store/premiumReportSelect")
	@ResponseBody
	public StoreAdminVO premiumReportSelect(Model model, StoreAdminVO vo) {
		return storeService.premiumReportSelect(vo);
	}
	
	// 사후보고서 update
	@RequestMapping("store/updatePremiumReport")
	@ResponseBody
	public String updatePremiumReport(StoreAdminVO vo) {
		String result = "";
		
		int pang = storeAdminDAO.updatePremiumReport(vo);
		
		if(pang > 0)
			result = "update success";
		
		return result;
	}
	
	//================= 정동영 ===================================
	//====================== 최반야 ====================================
	// 지점 공지사항 리스트
	@RequestMapping("store/storeNotice")
	public String noticeList(HttpServletRequest req, StoreAdminVO vo, Model model) {
		HttpSession session = req.getSession();
		String s_code = (String) session.getAttribute("stCode");
		System.out.println(s_code);
		
		vo.setStore_code(s_code);
		model.addAttribute("storeNotice", storeAdminDAO.storeNoticeList(vo));
		return "storeAdmin/storeNoticeList";
	}
	
	// 지점 공지사항 등록 form 페이지 이동
	@RequestMapping("store/noticeForm")
	public String noticeForm(StoreAdminVO vo) {
		return "storeAdmin/noticeForm";
	}
	
	// 지점 공지사항 등록
	@RequestMapping("store/registNotice")
	public String registNotice(HttpServletRequest req, StoreAdminVO vo) {
		HttpSession session = req.getSession();
		String s_code = (String)session.getAttribute("stCode");
		vo.setStore_code(s_code);
		storeAdminDAO.registNotice(vo);
		return "redirect:storeNotice";
	}
	
	// 지점 공지사항 상세 및 수정 페이지 모달로 전송
	@ResponseBody
	@RequestMapping(value="store/storeNoticeSelect/{notice_num}", method=RequestMethod.GET)
	public StoreAdminVO storeNoticeSelect(@PathVariable int notice_num, Model model, StoreAdminVO vo) {
		vo.setNotice_num(notice_num);
		
		return storeAdminDAO.storeNoticeSelect(vo);
	}  
	
	// 지점 공지사항 수정
	@ResponseBody
	@RequestMapping("store/editNotice")
	public String storeNoticeEdit(StoreAdminVO vo) {
		String result = "";
		
		int up = storeAdminDAO.storeNoticeEdit(vo);
		
		if(up > 0)
			result = "update success";
		
		return result;
	}
	
	// 지점 공지사항 삭제
	@ResponseBody
	@RequestMapping(value="store/deleteNotice/{notice_num}", method=RequestMethod.GET)
	public String storeNoticeDelete(StoreAdminVO vo) {
		String result = "";
		
		int del = storeAdminDAO.storeNoticeDelete(vo);
		
		if(del > 0)
			result = "delete success";
		return result;
	}
	
	//====================== 최반야 ====================================
	
	
	/////////////////////////////////전형민////////////////////////////////////////////
	//지점관리자 홈으로 이동
	@RequestMapping("store/enterStoreAdmin")
	public String storeAdminHome() {
	return "storeAdmin/enterStoreAdmin";
	}
	
	
	// 이용중인 사용자 리스트
	@RequestMapping("store/usingList")
	@ResponseBody
	public List<StoreAdminVO> usingList(HttpServletRequest request, HttpServletResponse response) {
	// Store - 지점명, 지점주소 (StoreConlloer)
		HttpSession session = request.getSession();
		String storeCode = (String) session.getAttribute("stCode");
		
	List<StoreAdminVO> list = storeAdminDAO.usingStrorageList(storeCode);
	return list;
	}
	
	// 사용종료 사용자 리스트
		@RequestMapping("store/expiredList")
		@ResponseBody
		public List<StoreAdminVO> expiredList(HttpServletRequest request, HttpServletResponse response) {
		// Store - 지점명, 지점주소 (StoreConlloer)
		HttpSession session = request.getSession();
		String storeCode = (String) session.getAttribute("stCode");
		
		List<StoreAdminVO> list = storeAdminDAO.expiredStrorageList(storeCode);
		return list;
		}
	
	@RequestMapping("store/customerManage")
	public String LoginIdCheck(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		
	return "storeAdmin/customerManage";
	}
	

	@RequestMapping("store/storageUserDetail")
	public String storageUserDetail(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {
		String use_num = request.getParameter("use_num");
		StoreAdminVO rvo = storeAdminDAO.storageUserDetail(use_num);
		
		model.addAttribute("selectUserVO", rvo);
		
		return "storeAdmin/storageUserDetail";
	}	
	
	//세탁물 위탁날짜 입력
	@RequestMapping("store/laundryConsignUpdate")
	@ResponseBody
	public String laundryConsignUpdate(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException, ParseException {
		 
		String laundry_consign = request.getParameter("laundry_consign");

		vo.setLaundry_consign(laundry_consign);

		
		
			System.out.println(vo.getLaundry_consign());
			String result = "";
			
		 	int i = storeAdminDAO.updateLaundryConsign(vo);
			
			if(i > 0)
				result = "update success";
			
			return result;
	}
	
	//세탁물 회수날짜 입력
		@RequestMapping("store/laundryCollectUpdate")
		@ResponseBody
		public String userLoginIdCheck(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws IOException, ParseException {
			 
			String laundry_collect = request.getParameter("laundry_collect");

			vo.setLaundry_collect(laundry_collect);
			
				System.out.println(vo.getLaundry_collect());
				String result = "";
				
			 	int i = storeAdminDAO.updateLaundryCollect(vo);
				
				if(i > 0)
					result = "update success";
				
				return result;
		}
	
	
	
		// 고객관리 보고서 입력
		@ResponseBody
		@RequestMapping("store/insertReport")
		public String insertReport(StoreAdminVO vo) {
			String result = "";

			int up = storeAdminDAO.insertReport(vo);

			if (up > 0)
				result = "insert success";

			return result;
		}

		// 쿠폰정보 입력
		@ResponseBody
		@RequestMapping("store/insertCoupon")
		public String insertCoupon(StoreAdminVO vo, HttpServletRequest request, HttpServletResponse response)  {
			
			//int getCoupon_discount= Integer.parseInt(request.getParameter("coupon_discount"));
			//int coupon_discount =1-getCoupon_discount;
			//String coupon_discountToString= String.valueOf(coupon_discount);

			//vo.setCoupon_discount(coupon_discount);
			String result = "";

			int i = storeAdminDAO.insertCoupon(vo);

			if (i > 0)
				result = "insert success";

			return result;
		}
	

	/////////////////////////////////전형민////////////////////////////////////////////		
	//===============최반야 > 1:1 문의 관리 ============================
	
	// 1:1 문의 관리 페이지 로딩
	@RequestMapping("store/supervisionAsk")
	public String supervisionAsk(StoreAdminVO vo, HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String s_code = (String) session.getAttribute("stCode");
		vo.setStore_code(s_code);
		System.out.println(s_code);
		
		model.addAttribute("customerAskList",storeAdminDAO.customerAskList(vo));
		
		return "storeAdmin/answerAsk";
	}
	
	// 1:1 문의 상세
	@ResponseBody
	@RequestMapping(value="store/custormerAskSelect/{question_num}", method=RequestMethod.GET)
	public List<StoreAdminVO> custormerAskSelect(@PathVariable int question_num, StoreAdminVO vo, HttpServletRequest req) {
		vo.setQuestion_num(question_num);
		
		List<StoreAdminVO> custormerAskSelect = storeAdminDAO.customerAskSelect(vo);
		
		return custormerAskSelect;
	}
	
	// 1:1 문의 답변 등록
	@ResponseBody
	@RequestMapping(value="store/answerAsk", method=RequestMethod.POST)
	public String answerAsk(HttpServletRequest req, StoreAdminVO vo) {
		HttpSession session = req.getSession();
		String empId = (String) session.getAttribute("empId");
		String s_code = (String) session.getAttribute("stCode");
		System.out.println(empId+"====="+s_code);
		vo.setMember_id(empId);
		vo.setStore_code(s_code);
		
		String result = "";

		int answer = storeAdminDAO.answerAsk(vo);
		
		if(answer > 0)
			result = "success";
		
		return result;
	}
	
	
	//==============최반야 > 1:1 문의 관리 끝 ==========================
	
	// 투어 신청 페이지 실행
		@RequestMapping("store/tourConfirm")
		public String storeTour(HttpServletRequest req, Model model, StoreAdminVO vo) {
			HttpSession session = req.getSession();

			String id = (String) session.getAttribute("loginId");
			String store_code = (String) session.getAttribute("store_code");
			
			vo.setStore_code(store_code);
			vo.setMember_id(id);
			
			if(id != null) {
				vo.setMember_id(id);
				model.addAttribute("storeTourList", storeAdminDAO.storeTourList(vo));
			}
			return "storeAdmin/tourConfirm";
		}
	
	// 투어 승인
		@ResponseBody
		@RequestMapping(value = "store/tourChange", method=RequestMethod.PUT)
		public int tourChange(@RequestBody StoreAdminVO vo) {	
			storeAdminDAO.updateTour(vo);
			return 0;
		}		
	
	// 주간 캘린더 API TEST
	@RequestMapping("store/tourCalendar")
	public String calendarTest2(Model model) {
		
		// TOUR TABLE에서 TOUR_DATE와 TOUR_TIME을 가져오고 합쳐야한다.
		// 예시 - TOUR_DATE : 2021-08-04, TOUR_TIME : PM 15:00 ~ 16:00
		// 		> String time = vo.gettour_time
		// 		> String subStartTime = time.substring(3,8); // 21.08.05 기준 데이터 1개 있어서 값 18:00 하나 나옴
		//		> String subEndTime = time.substring(11,16); // 19:00 나올 듯?
		// 		> String date = vo.gettour_date + "T" + subtime
		//		> 하면 나올 것 같다
		//					*** 주의점 : 21.08.05 기준 입력 데이터는 'AM 11:00 ~ 12:00'과 같이 입력되어있는데
		//								위와같이 들어가지 않을 시에 substring(x,y) 값을 수정해주어야 함
		// 가져와야 하는 값 : store_id / member_name(id로 join) / tour_date / tour_time
		// 각각 calendarId / title / start, end(투어는 1시간이므로 가져올 때 subtime +1을 해서 subtiem2에 담던말던)
		// 아무튼 여기서 list로 넘겨서 jsp에서 c:forEach로 json type으로 바꾸고 스케쥴하면 나올 것 같다...
		
		
		// 테스트 중에 여기서 에러가 난다면 로그인을 안해서 에러가 나는 것
		UserDetails userDetails =
				(UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 지점관리자 페이지에 있을 것이므로 지점관리자 ID를 가져와서 해당 지점 코드 값 가져오기
		String id = userDetails.getUsername();
		String store_code = memberDAO.empStoreCode(id);
		
		TourVO vo = new TourVO();
		vo.setStore_code(store_code);
		// 지점코드로 해당 지점 투어 일정 리스트 가져오기
		List<TourVO> list = tourDAO.tourManageEx(vo);
		
		
		for(int i = 0; i < list.size(); i++) {
			// 생각해보니 고객 이름도 필요함
			MemberVO vo2 = new MemberVO();
			vo2 = memberDAO.tourMemberName(list.get(i).getMember_id());
			// 이름 집어넣고
			list.get(i).setMember_name(vo2.getMember_name());
			// 시간 값 가져와서 조립 시작
			// 근데 여기와서 생각해보니 이렇게 하지말고 처음부터 가져올때 sql에서 조립하는게 나을듯
			String time =  list.get(i).getTour_time();
			String subStartTime = time.substring(3,8); // 21.08.05 오전 기준으로 데이터 1개 있어서 값 18:00과
			String subEndTime = time.substring(11,16); // 19:00이 나온다
			Date date = list.get(i).getTour_date();
			SimpleDateFormat transDate = new SimpleDateFormat("yyyy-MM-dd");
			// 아무튼 Calendar에서 요구하는 형태로 조립
			String sumStartDate = transDate.format(date) + "T" + subStartTime;
			String sumEndDate = transDate.format(date) + "T" + subEndTime;
			list.get(i).setStart(sumStartDate);
			list.get(i).setEnd(sumEndDate);
		}
		// 확인해야할 값 store_code, member_name, start, end << 확인ㅇ. 존재함
		// System.out.println("vo 조립 확인 : " + list);
			
		model.addAttribute("list", list);
		
		
		return "storeAdmin/tourCalendar";
	}
	
	// 월간 캘린더 API TEST (지점관리)
	@RequestMapping("store/transCalendar")
	public String calendarTest1(Model model) {
		
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
		
		// 테스트 중에 여기서 에러가 난다면 로그인을 안해서 에러가 나는 것
		UserDetails userDetails =
				(UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 지점관리자 페이지에 있을 것이므로 지점관리자 ID를 가져와서 해당 지점 코드 값 가져오기
		String id = userDetails.getUsername();
		String store_code = memberDAO.empStoreCode(id);
		
		TransVO vo = new TransVO();
		vo.setStore_code(store_code);
		
		// 지점 운송 리스트 가져오기.
		List<TransVO> list = transDAO.conveyStoreList(vo);
		
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
	
		
		return "storeAdmin/transCalendar";
	}
	
}
