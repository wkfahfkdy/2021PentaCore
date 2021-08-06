package com.yedam.storage.mypage.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

@Controller
@RequestMapping("/fileUpload")
public class CkeditorFileUploadController { //reviewRegist
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	@RequestMapping(value="reviewRegist", method=RequestMethod.POST)
	@ResponseBody
	public void ckUpload(HttpServletRequest req, HttpServletResponse res, @RequestParam MultipartFile upload) throws Exception{
			logger.info("ckUpload 진입 =========================================1");
			
			//	@Resource(name="uploadPath")
			// servlet-context 파일에 지정해 놓은 경로를 읽어올 때 사용.
			// 현재는 servlet-context에서 불러오지 않고 getRealPath함수를 사용하기 때문에,
			// 주석으로 막아 놓았음. 
			String uploadPath =req.getServletContext().getRealPath("/resources");
			 // 랜덤 문자 생성
			 UUID uid = UUID.randomUUID();
			 
			 OutputStream out = null;
			 PrintWriter printWriter = null;
			   
			 // 인코딩
			 res.setCharacterEncoding("utf-8");
			 res.setContentType("text/html;charset=utf-8");
			 
			 try {
			  
			  String fileName = upload.getOriginalFilename();  // 파일 이름 가져오기
			  byte[] bytes = upload.getBytes();
			  
			  // 업로드 경로
			  String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uid + "_" + fileName;
			  
			  out = new FileOutputStream(new File(ckUploadPath));
			  out.write(bytes);
			  out.flush();  // out에 저장된 데이터를 전송하고 초기화
			  
			  String callback = req.getParameter("CKEditorFuncNum");
			  printWriter = res.getWriter();
			  String fileUrl = req.getContextPath()+ "/resources/ckUpload/" + uid + "_" + fileName;  // 작성화면
			  //String fileUrl = "/ckUpload/" + uid + "&fileName=" + fileName;  // 작성화면

			  // 업로드시 메시지 출력
			  JsonObject json = new JsonObject();
			  json.addProperty("uploaded", 1);
			  json.addProperty("fileName", fileName);
			  json.addProperty("url", fileUrl);
			  printWriter.println(json);	  
		 		  
			 } catch (IOException e) { e.printStackTrace();
			 } finally {
			  try {
			   if(out != null) { out.close(); }
			   if(printWriter != null) { printWriter.close(); }
			  } catch(IOException e) { e.printStackTrace(); }
			 }
		}
		
}	