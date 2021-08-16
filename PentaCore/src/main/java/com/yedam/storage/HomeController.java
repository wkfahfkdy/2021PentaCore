package com.yedam.storage;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.yedam.storage.review.service.ReviewService;
import com.yedam.storage.storage.service.StorageService;
import com.yedam.storage.store.service.StoreService;
import com.yedam.storage.store.vo.StoreVO;
import com.yedam.storage.tour.service.TourService;
import com.yedam.storage.tour.vo.TourVO;
import com.yedam.storage.trans.service.TransService;
import com.yedam.storage.trans.vo.TransVO;

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
	@Autowired
	private ReviewService reviewDAO;
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(Model model, StoreVO vo) {
		
		model.addAttribute("list", storeDAO.htSelect(vo));
		model.addAttribute("reviewList", reviewDAO.mainPageReviewList());
		// ~~.getAuthentication() = 우선 로그인 했을 때
		if(SecurityContextHolder.getContext().getAuthentication() != null) {
			// CustomSuccessHandler에서는 Set<GrantedAuthority> 타입을 썼었는데 List도 된다. 원래는 Collection 타입이다.
			List<GrantedAuthority> auth =
					(List<GrantedAuthority>) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
			
			//운송관리자일 시에 해당 페이지로 이동
			if("ROLE_TRANS".equals(auth.get(0).toString())) {
				System.out.println("컨트롤러 : " + auth.get(0).toString());
				return "empty/empty/enterAdmin";
			}
			//지점관리자일 시에 해당 페이지로 이동
			else if("ROLE_STORE".equals(auth.get(0).toString())) {
				System.out.println("컨트롤러 : " + auth.get(0).toString());
				return "storeAdmin/enterStoreAdmin";
			}
		}
		
		// admin이나 고객일 경우 메인으로 이동
		return "common/section";
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
	public String tourTest(Model model) {
		
	// TOUR TABLE에서 TOUR_DATE와 TOUR_TIME을 가져오고 합쳐야한다.
			// Map에서 TOUR_DATE를 가져올때 TO_CHAR을 이용하여 'YYYY-MM-DD'로 가져와야한다
			// 예시 - TOUR_DATE : 2021-08-04, TOUR_TIME : PM 15:00 ~ 16:00
			// 		> String time = vo.gettour_time
			// 		> String subStartTime = time.substring(3,8); // 21.08.05 기준 데이터 1개 있어서 값 18:00 하나 나옴
			//		> String subEndTime = time.substring(11,5); // 19:00 나올 듯?
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
				// 아무튼 TOAST Calendar에서 요구하는 형태로 조립
				String sumStartDate = transDate.format(date) + "T" + subStartTime;
				String sumEndDate = transDate.format(date) + "T" + subEndTime;
				list.get(i).setStart(sumStartDate);
				list.get(i).setEnd(sumEndDate);
			}
			// 확인해야할 값 store_code, member_name, start, end << 확인ㅇ. 존재함
			// System.out.println("vo 조립 확인 : " + list);
				
		model.addAttribute("list", list);
		
		return "test/tourManage";
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
	
	@RequestMapping("goStoreSelect")
	public String goStoreSelect() {
		return "test/goStoreAdmin";
	}
	
	@RequestMapping("goTrans")
	public String goTrans() {
		return "empty/empty/enterAdmin";
	}
	
	
	@RequestMapping("goStoreAdmin")
	public String goStoreAdmin(HttpServletRequest req) {
		
		String store_code = req.getParameter("store_code");
		HttpSession session = req.getSession();
		session.removeAttribute("stCode");
		session.removeAttribute("store_code");
		session.setAttribute("stCode", store_code);
		session.setAttribute("store_code", store_code);
		
		return "storeAdmin/enterStoreAdmin";
	}
	
}
