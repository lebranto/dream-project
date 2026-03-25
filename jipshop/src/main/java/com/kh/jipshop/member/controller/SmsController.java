package com.kh.jipshop.member.controller;
 
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.jipshop.member.model.service.MemberService;
import com.kh.jipshop.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
 
@Controller
@RequestMapping("/sms")
@RequiredArgsConstructor
public class SmsController {
 
    private static final String API_KEY      = "NCSV2H8XE9A1JPVI";
    private static final String API_SECRET   = "2XUKX6WYNRMUAHR9GFF6USHJ0J6UJPB0";
    private static final String FROM_NUMBER  = "01027159165 "; // 발신번호 (Coolsms에 등록된 번호)
 
    // ── 인증번호 발송 ──
    @ResponseBody
    @PostMapping("/send")
    public Map<String, Object> sendSms(
            @RequestParam("phone") String phone,
            HttpSession session) {
    	
    	phone = phone.replaceAll("-", "");
    	
        Map<String, Object> result = new HashMap<>();
 
        try {
            // 6자리 난수 생성
            //String authCode = String.format("%06d", new Random().nextInt(1000000));
        	String authCode = "123456"; // ← 테스트용 고정값
        	
            // Coolsms 메시지 발송
            DefaultMessageService messageService =
                NurigoApp.INSTANCE.initialize(API_KEY, API_SECRET, "https://api.coolsms.co.kr");
 
            Message message = new Message();
            message.setFrom(FROM_NUMBER);
            message.setTo(phone);
            message.setText("[집사상점] 인증번호: " + authCode + "\n3분 이내에 입력해주세요.");
            
            // 돈 때문에 테스트 끝나고 주석해제
            //messageService.sendOne(new SingleMessageSendingRequest(message)); 
 
            // 세션에 인증번호 + 만료시간 저장
            session.setAttribute("smsAuthCode", authCode);
            session.setAttribute("smsAuthExpire", System.currentTimeMillis() + (3 * 60 * 1000)); // 3분
 
            result.put("success", true);
            // 테스트 중 인증번호 발송되는지 확인 끝나면 authCode변수 삭제
            result.put("message", "인증번호가 발송되었습니다."+ authCode);
 
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("SMS 오류 상세: " + e.getMessage());
            result.put("success", false);
            result.put("message", "SMS 발송 실패: " + e.getMessage());
        }
 
        return result;
    }
 
    // ── 인증번호 확인 ──
    @ResponseBody
    @PostMapping("/verify")
    public Map<String, Object> verifySms(
            @RequestParam("code") String code,
            HttpSession session) {
 
        Map<String, Object> result = new HashMap<>();
 
        String savedCode   = (String) session.getAttribute("smsAuthCode");
        Long   expireTime  = (Long)   session.getAttribute("smsAuthExpire");
 
        if (savedCode == null || expireTime == null) {
            result.put("success", false);
            result.put("message", "인증번호를 먼저 요청해주세요.");
            return result;
        }
 
        // 유효시간 체크 (3분)
        if (System.currentTimeMillis() > expireTime) {
            session.removeAttribute("smsAuthCode");
            session.removeAttribute("smsAuthExpire");
            result.put("success", false);
            result.put("message", "인증번호가 만료되었습니다. 다시 요청해주세요.");
            return result;
        }
 
        // 인증번호 일치 여부
        if (savedCode.equals(code.trim())) {
            session.removeAttribute("smsAuthCode");
            session.removeAttribute("smsAuthExpire");
            session.setAttribute("phoneVerified", true); // 인증 완료 플래그
            result.put("success", true);
            result.put("message", "인증이 완료되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "인증번호가 일치하지 않습니다.");
        }
 
        return result;
    }
    
 // ── 비밀번호 찾기용 인증번호 확인 ──
    @ResponseBody
    @PostMapping("/verifyPwd")
    public Map<String, Object> verifyPwdSms(
            @RequestParam("code") String code,
            HttpSession session) {
 
        Map<String, Object> result = new HashMap<>();
 
        String savedCode  = (String) session.getAttribute("smsAuthCode");
        Long   expireTime = (Long)   session.getAttribute("smsAuthExpire");
 
        if (savedCode == null || expireTime == null) {
            result.put("success", false);
            result.put("message", "인증번호를 먼저 요청해주세요.");
            return result;
        }
 
        if (System.currentTimeMillis() > expireTime) {
            session.removeAttribute("smsAuthCode");
            session.removeAttribute("smsAuthExpire");
            result.put("success", false);
            result.put("message", "인증번호가 만료되었습니다. 다시 요청해주세요.");
            return result;
        }
 
        if (savedCode.equals(code.trim())) {
            session.removeAttribute("smsAuthCode");
            session.removeAttribute("smsAuthExpire");
            session.setAttribute("pwdPhoneVerified", true); // 비밀번호 찾기 인증 완료
            result.put("success", true);
            result.put("message", "인증이 완료되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "인증번호가 일치하지 않습니다.");
        }
 
        return result;
    }
    
}