package myPageTest;

import java.util.List;

import org.junit.Test;
import org.junit.internal.runners.JUnit4ClassRunner;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import com.yedam.storage.mypage.service.MyPageService;
import com.yedam.storage.mypage.vo.MyPageVO;

@RunWith(JUnit4ClassRunner.class)
@Configuration(value = "classpath:/config/*-context.xml")
public class MpTest {
	@Autowired
	MyPageService MyPageDAO;
	
	@Test
	public void getNotice() {
		MyPageVO vo = new MyPageVO();
		
		String s_code = "ST002";
		vo.setStore_code(s_code);
		
		List<MyPageVO> noticeList = MyPageDAO.noticeSelectList(vo);
		System.out.println(noticeList);
		
	}
}
