package com.kh.jipshop.product.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@Controller
public class ProductController {
	
		@RequestMapping("/")
		public String home() {
			return "product/home";
    	}

    	@RequestMapping("/terms")
    	public String terms() {
        	return "product/terms";
    	}

		@RequestMapping("/privacy")
	   public String privacy() {
	       return "product/privacy";
	   }

	   // 강아지 미용용품
	   
	   @RequestMapping("/dog/groom")
	   public String dogGroomPage() {
	       return "product/dogGroom";
	   }
	   
	   @RequestMapping("/dog/groom/detail")
	   public String dogGroomDetailPage() {
	       return "product/dogGroomDetail";
	   }

	   // 강아지 외출용품
	   @RequestMapping("/dog/outdoor")
	   public String dogOutdoorPage() {
	       return "product/dogOutdoor";
	   }

	   @RequestMapping("/dog/outdoor/detail")
	   public String dogOutdoorDetailPage() {
	       return "product/dogOutdoorDetail";
	   }
	   

	   // 강아지 장난감
	   @RequestMapping("/dog/toy")
	   public String dogToyPage() {
	       return "product/dogToy";
	   }

	   @RequestMapping("/dog/toy/detail")
	   public String dogToyDetailPage() {
	       return "product/dogToyDetail";
	   }

	   // ����� �峭��
	   @RequestMapping("/cat/toy")
	   public String catToyPage() {
	       return "product/catToy";
	   }

	   @RequestMapping("/cat/toy/detail")
	   public String catToyDetailPage() {
	       return "product/catToyDetail";
	   }

	   @RequestMapping("/cat/toy/detail2")
	   public String catToyDetail2Page() {
	       return "product/catToyDetail2";
	   }

	   // ����� �̿��ǰ
	   @RequestMapping("/cat/groom")
	   public String catGroomPage() {
	       return "product/catGroom";
	   }

	   @RequestMapping("/cat/groom/detail")
	   public String catGroomDetailPage() {
	       return "product/catGroomDetail";
	   }

	   @RequestMapping("/cat/groom/detail2")
	   public String catGroomDetail2Page() {
	       return "product/catGroomDetail2";
	   }

	   @RequestMapping("/cat/groom/detail3")
	   public String catGroomDetail3Page() {
	       return "product/catGroomDetail3";
	   }

	   @RequestMapping("/cat/groom/detail4")
	   public String catGroomDetail4Page() {
	       return "product/catGroomDetail4";
	   }

	   // ����� �����ǰ
	   @RequestMapping("/cat/outdoor")
	   public String catOutdoorPage() {
	       return "product/catOutdoor";
	   }

	   @RequestMapping("/cat/outdoor/detail")
	   public String catOutdoorDetailPage() {
	       return "product/catOutdoorDetail";
	   }

	   @RequestMapping("/cat/outdoor/detail2")
	   public String catOutdoorDetail2Page() {
	       return "product/catOutdoorDetail2";
	   }
	   
	   // ����� ���
	   @RequestMapping("/cat/feed/detail")
	   public String catFeedDetailPage() {
	       return "product/catFeedDetail";
	   }
	   
	   @RequestMapping("/cat/feed")
	   public String catFeedPage() {
	       return "product/catFeed";
	   }
	   
	   // ������ ���
	   @RequestMapping("/dog/feed")
	   public String dogFeedPage() {
	       return "product/dogFeed";
	   }
	   
	   @RequestMapping("/dog/feed/detail")
	   public String dogFeedDetailPage() {
	       return "product/dogFeedDetail";
	   }
}
