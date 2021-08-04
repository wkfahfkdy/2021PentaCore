package com.yedam.storage;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yedam.storage.coupon.service.CouponService;
import com.yedam.storage.division.service.DivisionService;
import com.yedam.storage.laundryinfo.service.LaundryInfoService;
import com.yedam.storage.member.serviceImpl.MemberServiceImpl;
import com.yedam.storage.member.vo.MemberVO;
import com.yedam.storage.product.service.ProductService;
import com.yedam.storage.rental.service.RentalService;
import com.yedam.storage.storage.service.StorageService;
import com.yedam.storage.store.service.StoreService;
import com.yedam.storage.store.vo.StoreVO;
import com.yedam.storage.tour.service.TourService;
import com.yedam.storage.tour.vo.TourVO;

@Controller
public class HomeController {
	
	@Autowired
	private CouponService couponDAO;
	@Autowired
	private LaundryInfoService laundryInfoDAO;
	@Autowired
	private RentalService rentalDAO;
	@Autowired
	private DivisionService divisionDAO;
	@Autowired
	private ProductService productDAO;
	@Autowired
	private StoreService storeDAO;
	@Autowired
	private StorageService storageDAO;
	@Autowired
	private TourService tourDAO;
	@Autowired
	private MemberServiceImpl memberDAO;
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home() {
		
		// ~~.getAuthentication() = 우선 로그인 했을 때
		if(SecurityContextHolder.getContext().getAuthentication() != null) {
			// CustomSuccessHandler에서는 Set<GrantedAuthority> 타입을 썼었는데 List도 된다. 원래는 Collection 타입이다.
			List<GrantedAuthority> auth =
					(List<GrantedAuthority>) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
			
			// 관리자일 시에 해당 페이지로 이동
			if("ROLE_STORE".equals(auth.get(0).toString()) || "ROLE_TRANS".equals(auth.get(0).toString()) ) {
				System.out.println("컨트롤러 : " + auth.get(0).toString());
				return "common/enterAdmin";
			}
		}
		
		// admin이나 고객일 경우 메인으로 이동
		return "common/section";
	}
	
	// 캘린더 API TEST
	@RequestMapping("calendarTest")
	public String calendarTest() {
		
		return "test/calendar2";
	}
	
	// 카카오 지도 API TEST 이동
	@RequestMapping("kakaoMapTest")
	public String kakaoMapTest() {
		
		return "test/kakaoMapTest";
	}
	
	// 카카오 지도 API TEST - DATA
	@RequestMapping("storeAddr")
	@ResponseBody
	public List<StoreVO> StoreAddr() {
		// Store - 지점명, 지점주소 (StoreConlloer)
		List<StoreVO> list = storeDAO.SelectStoreAddr();
		return list;
	}
	
	// 투어관리 예제 페이지 이동
	@RequestMapping("tourTest")
	public String tourTest() {
		
		UserDetails userDetails =
				(UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		String id = userDetails.getUsername();
		String store_code = memberDAO.empStoreCode(id);
		
		TourVO vo = new TourVO();
		vo.setStore_code(store_code);
		List<TourVO> list = tourDAO.tourManageEx(vo);
		for(int i = 0; i < list.size(); i++) {
			String time =  list.get(i).getTour_time();
			String subtime = time.substring(3,5);
			Date date = list.get(i).getTour_date();
			System.out.println(date);
		}
		
		return "test/tourManage";
	}
	
	// 투어관리 예제
	@RequestMapping("tourManageEx")
	@ResponseBody
	public List<TourVO> tourManageEx() {
		// TOUR TABLE에서 TOUR_DATE와 TOUR_TIME을 가져오고 합쳐야한다.
		// Map에서 TOUR_DATE를 가져올때 TO_CHAR을 이용하여 'YYYY-MM-DD'로 가져와야한다
		// 예시 - TOUR_DATE : 2021-08-04, TOUR_TIME : PM 15:00 ~ 16:00
		// 		> String time = vo.gettour_time
		// 		> String subtime = time.substr(3,5) << 아마 15 나올듯??
		// 		> String date = vo.gettour_date + "T" + subtime
		//		> 하면 나올 것 같다
		// 가져와야 하는 값 : store_id / member_name(id로 join) / tour_date / tour_time
		// 각각 calendarId / title / start, end(투어는 1시간이므로 가져올 때 subtime +1을 해서 subtiem2에 담던말던)
		// 아무튼 여기서 list로 넘겨서 jsp에서 c:forEach로 json type으로 바꾸고 스케쥴하면 나올 것 같다...
		
		UserDetails userDetails =
				(UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		String id = userDetails.getUsername();
		String store_code = memberDAO.empStoreCode(id);
		
		TourVO vo = new TourVO();
		vo.setStore_code(store_code);
		List<TourVO> list = tourDAO.tourManageEx(vo);
		for(int i = 0; i < list.size(); i++) {
			String time =  list.get(i).getTour_time();
			System.out.println(time.substring(4,2));
		}
		
		return list;
	}
	
	@RequestMapping("selfOffer")
	public String selfOfferPage(Model model) {
		// 물품 카테고리 출력
		model.addAttribute("divisionList", divisionDAO.divisionSelectList());
		// 스토리지 정보 출력
		model.addAttribute("storageList", storageDAO.storageSelectList());
		// 물품 정보
		model.addAttribute("getProductList", productDAO.selectProductList());
		// 렌탈 물품 정보
		model.addAttribute("rentalList", rentalDAO.selectRentalList());
		// 세탁 물품 리스트
		model.addAttribute("laundryInfoList", laundryInfoDAO.selectLaundryInfoList());
		// 쿠폰 정보 리스트
		model.addAttribute("couponeInfoList", couponDAO.selectCouponList());
		return "offer/selfOfferPage";
	} 
	
}
