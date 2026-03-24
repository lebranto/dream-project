package com.kh.jipshop.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {

    @RequestMapping("/")
    public String home() {
        return "home";
    }

    @RequestMapping("/terms")
    public String terms() {
        return "terms";
    }

    @RequestMapping("/privacy")
    public String privacy() {
        return "privacy";
    }
    
    // 강아지 사료
    @RequestMapping("/dog/feed")
    public String dogFeedPage() {
        return "dogFeed";
    }

    @RequestMapping("/dog/feed/detail")
    public String dogFeedDetailPage() {
        return "dogFeedDetail";
    }

    // 강아지 미용용품
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

    // 강아지 외출용품
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

    // 강아지 장난감
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

    // 고양이 장난감
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

    // 고양이 미용용품
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

    // 고양이 외출용품
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
    
    // 고양이 사료
    @RequestMapping("/cat/feed")
    public String catFeedPage() {
        return "catFeed";
    }
    
    @RequestMapping("/cat/feed/detail")
    public String catFeedDetailPage() {
        return "catFeedDetail";
    }
    
}