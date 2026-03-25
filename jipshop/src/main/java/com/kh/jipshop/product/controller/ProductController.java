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
	       return "dproduct/ogGroomDetail";
	   }

	   @RequestMapping("/dog/groom/detail2")
	   public String dogGroomDetail2Page() {
	       return "product/dogGroomDetail2";
	   }

	   @RequestMapping("/dog/groom/detail3")
	   public String dogGroomDetail3Page() {
	       return "product/dogGroomDetail3";
	   }

	   @RequestMapping("/dog/groom/detail4")
	   public String dogGroomDetail4Page() {
	       return "product/dogGroomDetail4";
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

	   @RequestMapping("/dog/outdoor/detail2")
	   public String dogOutdoorDetail2Page() {
	       return "product/dogOutdoorDetail2";
	   }

	   @RequestMapping("/dog/outdoor/detail3")
	   public String dogOutdoorDetail3Page() {
	       return "product/dogOutdoorDetail3";
	   }

	   @RequestMapping("/dog/outdoor/detail4")
	   public String dogOutdoorDetail4Page() {
	       return "product/dogOutdoorDetail4";
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

	   @RequestMapping("/dog/toy/detail2")
	   public String dogToyDetail2Page() {
	       return "product/dogToyDetail2";
	   }

	   // 고양이 장난감
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

	   // 고양이 미용용품
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

	   // 고양이 외출용품
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
	   
	   // 고양이 사료
	   @RequestMapping("/cat/feed")
	   public String catFeedPage() {
	       return "product/catFeed";
	   }
	   
	   // 강아지 사료
	   @RequestMapping("/dog/feed")
	   public String dogFeedPage() {
	       return "product/dogFeed";
	   }
}
