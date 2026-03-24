package com.kh.jipshop.security.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jipshop.common.util.Utils;
import com.kh.jipshop.member.model.service.MemberService;
import com.kh.jipshop.member.model.validator.MemberValidator;
import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/security")
@Slf4j
public class SecurityController {
	
	// 필드방식 의존성 주입
	//@Autowired
	private final MemberService mService;
	private final BCryptPasswordEncoder passwordEncoder;
	private final ServletContext application;
	
	//생성자방식 의존성 주입
	// 단, 생성자가 여러개면 @Autowired어노테이션 필요.
	public SecurityController(MemberService mService, BCryptPasswordEncoder passwordEncoder,ServletContext application ) {
		this.mService = mService;
		this.passwordEncoder = passwordEncoder;
		this.application = application;
	}
	
	@RequestMapping("/accessDenied")
	public String accessDenied(Model m) {
		m.addAttribute("errorMsg", "접근불가능한 페이지입니다.");
		return "common/errorPage";
	}
	
	//회원가입페이지 이동
	@GetMapping("/insert")
	public String enroll(
			@ModelAttribute Member member
			/*
			 * @ModelAttribute
			 *  - 커멘드객체 바인딩시 사용
			 *  - model영역에 커멘드객체를 저장
			 */
			) {
		//log.info("bcrypto : {}",passwordEncoder);
		return "member/memberEnrollForm";
	}
	
	/*
	 * InitBinder
	 *  - 현재 컨트롤러에서 Binding작업을 수행할 때 실행되는 객체.
	 *  - @ModelAttribute로 지정한 커맨드객체에 대해 바인딩 작업을 수행한다.
	 *  
	 *  처리순서
	 *  1) 클라이언트가 요청 파라미터를 커맨드 객체 필드에 바인딩시도
	 *  2) 바인딩 과정에서 WebDataBinder가 필요한 경우 타입변환 및 유효성검사를 수행
	 *  3) 유효성 검사 결과를 저장한다.(BindingReuslt)
	 * */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.addValidators(new MemberValidator());
		
		//타입변환 수행
		// 문자열 형태의 날짜값을 Date로 변환하기.(birthday)
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
		dateFormat.setLenient(false); // yyMMdd형식이 아닌경우 에러발생
		
		binder.registerCustomEditor(Date.class, "birthday", 
				new CustomDateEditor(dateFormat, true));
		// 날짜형태의 값이 들어오는 경우 자동으로 date자료형으로 변환해주는 커스텀에디터
		
	}
	@PostMapping("/insert")
	public String register(
	        @Validated @ModelAttribute Member member,
	        BindingResult bindingResult,
	        @RequestParam(value = "petName",   required = false) String petName,
	        @RequestParam(value = "petType",   required = false) String petType,
	        @RequestParam(value = "petBirth",  required = false) String petBirth,
	        @RequestParam(value = "petWeight", required = false) String petWeight,
	        @RequestParam(value = "petPhoto",  required = false) MultipartFile petPhoto,
	        HttpServletRequest request,
	        RedirectAttributes ra
	        ) throws Exception {
	 
	    // 유효성 검사 실패시
	    if (bindingResult.hasErrors()) {
	        return "member/memberEnrollForm";
	    }
	 
	    // 비밀번호 암호화
	    String encryptedPassword = passwordEncoder.encode(member.getMemberPwd());
	    member.setMemberPwd(encryptedPassword);
	 
	    // 회원 저장
	    int result = mService.insertMember(member);
	 
	    if (result > 0) {
	        // 애완동물 정보가 있으면 저장
	        if (petName != null && !petName.trim().isEmpty()) {
	            Pet pet = new Pet();
	            pet.setMemberNo(member.getMemberNo()); // insertMember 후 memberNo 세팅됨
	            pet.setPetName(petName.trim());
	            pet.setPetType(petType);
	 
	            // 생년월일 변환 (yyyy-MM-dd → Date)
	            if (petBirth != null && !petBirth.isEmpty()) {
	                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	                pet.setPetAge(sdf.parse(petBirth));
	            }
	 
	            // 몸무게 변환
	            if (petWeight != null && !petWeight.isEmpty()) {
	                pet.setPetWeight(Double.parseDouble(petWeight));
	            }
	 
	            // 사진 파일 업로드
	            if (petPhoto != null && !petPhoto.isEmpty()) {
	                // petType에 따라 저장 경로 분기 (pet/dog 또는 pet/cat)
	                String subPath = "pet/" + petType.toLowerCase();
	                String changeName = Utils.saveFile(petPhoto, application, subPath);
	                pet.setPetPhoto(changeName);
	            }
	 
	            mService.insertPet(pet);
	        }
	 
	        ra.addFlashAttribute("alertMsg", "회원가입 성공");
	        return "redirect:/member/login";
	    } else {
	        throw new RuntimeException("회원가입 실패");
	    }
	
	
	
	}
	
}
