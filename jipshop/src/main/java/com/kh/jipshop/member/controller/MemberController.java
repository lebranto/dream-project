package com.kh.jipshop.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.jipshop.member.model.service.MemberService;
import com.kh.jipshop.member.model.vo.Member;

@Controller
@RequestMapping("/member")
@SessionAttributes({"loginUser"})
public class MemberController {
  
	@Autowired //의존성주입
	private MemberService mService;
	
  @RequestMapping("/")
  public String home() {
      return "home";
  }
  @RequestMapping("/terms")
	public String terms() {
		return "terms";
	}

	@RequestMapping("/completed")
	public String completed() {
		return "common/completed";
	}
	
	@RequestMapping("/order")
	public String order() {
		return "common/order";
	}
	
	@RequestMapping("/cart")
	public String cart() {
		return "common/cart";
	}
	
	@RequestMapping("/adminSidebar")
	public String adminSidebar() {
		return "common/adminSidebar";
	}
	
	@RequestMapping("/adminHeader")
	public String adminHeader() {
		return "common/adminHeader";
	}
	
	@RequestMapping("/inquiryList")
	public String inquiryList() {
		return "common/inquiryList";
	}
	
	@RequestMapping("/inquiryList_view")
	public String inquiryList_view() {
		return "common/inquiryList_view";
	}
	
	@RequestMapping("/reportList")
	public String reportList() {
		return "common/reportList";
	}
	
	@RequestMapping("/reportList_view")
	public String reportList_view() {
		return "common/reportList_view";
	}
	
	@RequestMapping("/product_reg")
	public String product_reg() {
		return "common/product_reg";
	}
	
	@RequestMapping("/favorites")
	public String favorites() {
		return "common/favorites";
	}
	
	@RequestMapping("/myPageSidebar")
	public String myPageSidebar() {
		return "common/myPageSidebar";
	}
	
	@RequestMapping("/FAQ")
	public String FAQ() {
		return "common/FAQ";
	}
  
    @GetMapping("/login")
    public String loginMember() {
		return "member/login";
	}
	
	// 비동기 요청 처리
	@ResponseBody // 반환값을 jsp가 아닌, 반환해야할 값으로 처리하게 하는 주석
	@GetMapping("/idCheck")
	public int idCheck(String memberId) {
		int result = mService.idCheck(memberId);
		
		return result;
	}
		
	@ResponseBody
	@PostMapping("/findId")
	public Map<String, Object> findId(Member m) throws Exception {
	    Map<String, Object> result = new HashMap<>();
	    if (m.getPhone() != null) {
	        m.setPhone(m.getPhone().replaceAll("-", ""));
	    }
	    List<String> memberIds = mService.findMemberId(m);
	    if (memberIds != null && !memberIds.isEmpty()) {
	        result.put("success", true);
	        result.put("memberIds", memberIds); // 리스트로 반환
	    } else {
	        result.put("success", false);
	        result.put("message", "입력하신 정보와 일치하는 아이디가 없습니다.");
	    }
	    return result;
	}
	
	


    @RequestMapping("/privacy")
    public String privacy() {
        return "privacy";
    }
    
    // ������ ���
    @RequestMapping("/dog/feed")
    public String dogFeedPage() {
        return "dogFeed";
    }

    @RequestMapping("/dog/feed/detail")
    public String dogFeedDetailPage() {
        return "dogFeedDetail";
    }

    // ������ �̿��ǰ
    @RequestMapping("/dog/groom")
    public String dogGroomPage() {
        return "dogGroom";
    }

    @RequestMapping("/dog/groom/detail")
    public String dogGroomDetailPage() {
        return "dogGroomDetail";
    }

    @RequestMapping("/dog/groom/detail2")
    public String dogGroomDetail2Page() {
        return "dogGroomDetail2";
    }

    @RequestMapping("/dog/groom/detail3")
    public String dogGroomDetail3Page() {
        return "dogGroomDetail3";
    }

    @RequestMapping("/dog/groom/detail4")
    public String dogGroomDetail4Page() {
        return "dogGroomDetail4";
    }

    // ������ �����ǰ
    @RequestMapping("/dog/outdoor")
    public String dogOutdoorPage() {
        return "dogOutdoor";
    }

    @RequestMapping("/dog/outdoor/detail")
    public String dogOutdoorDetailPage() {
        return "dogOutdoorDetail";
    }

    @RequestMapping("/dog/outdoor/detail2")
    public String dogOutdoorDetail2Page() {
        return "dogOutdoorDetail2";
    }

    @RequestMapping("/dog/outdoor/detail3")
    public String dogOutdoorDetail3Page() {
        return "dogOutdoorDetail3";
    }

    @RequestMapping("/dog/outdoor/detail4")
    public String dogOutdoorDetail4Page() {
        return "dogOutdoorDetail4";
    }

    // ������ �峭��
    @RequestMapping("/dog/toy")
    public String dogToyPage() {
        return "dogToy";
    }

    @RequestMapping("/dog/toy/detail")
    public String dogToyDetailPage() {
        return "dogToyDetail";
    }

    @RequestMapping("/dog/toy/detail2")
    public String dogToyDetail2Page() {
        return "dogToyDetail2";
    }

    // ������ �峭��
    @RequestMapping("/cat/toy")
    public String catToyPage() {
        return "catToy";
    }

    @RequestMapping("/cat/toy/detail")
    public String catToyDetailPage() {
        return "catToyDetail";
    }

    @RequestMapping("/cat/toy/detail2")
    public String catToyDetail2Page() {
        return "catToyDetail2";
    }

    // ������ �̿��ǰ
    @RequestMapping("/cat/groom")
    public String catGroomPage() {
        return "catGroom";
    }

    @RequestMapping("/cat/groom/detail")
    public String catGroomDetailPage() {
        return "catGroomDetail";
    }

    @RequestMapping("/cat/groom/detail2")
    public String catGroomDetail2Page() {
        return "catGroomDetail2";
    }

    @RequestMapping("/cat/groom/detail3")
    public String catGroomDetail3Page() {
        return "catGroomDetail3";
    }

    @RequestMapping("/cat/groom/detail4")
    public String catGroomDetail4Page() {
        return "catGroomDetail4";
    }

    // ������ �����ǰ
    @RequestMapping("/cat/outdoor")
    public String catOutdoorPage() {
        return "catOutdoor";
    }

    @RequestMapping("/cat/outdoor/detail")
    public String catOutdoorDetailPage() {
        return "catOutdoorDetail";
    }

    @RequestMapping("/cat/outdoor/detail2")
    public String catOutdoorDetail2Page() {
        return "catOutdoorDetail2";
    }
    
    // ������ ���
    @RequestMapping("/cat/feed")
    public String catFeedPage() {
        return "catFeed";
    }
    
    @RequestMapping("/cat/feed/detail")
    public String catFeedDetailPage() {
        return "catFeedDetail";
    }
    
}

