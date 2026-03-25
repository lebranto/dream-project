package com.kh.jipshop.common.util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletContext;

import org.springframework.web.multipart.MultipartFile;

public class Utils {

    // 파일저장 함수
    // 파일을 저장하면서, 저장된 파일의 webPath(상대경로)를 반환
    public static String saveFile(
            MultipartFile upfile,
            ServletContext application,
            String subPath   // 저장할 하위 경로 (예: "pet", "board" 등)
    ) {
        // 첨부파일을 저장할 웹 경로
        String webPath = "/resources/images/" + subPath + "/";

        // 실제 서버 파일시스템의 절대경로
        String serverPath = application.getRealPath(webPath);
        File dir = new File(serverPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 랜덤 파일명 생성 (현재시간 + 랜덤값 + 확장자)
        String originName = upfile.getOriginalFilename();
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int random = new Random().nextInt(90000) + 10000;
        String ext = originName.substring(originName.lastIndexOf("."));

        String changeName = currentTime + random + ext;

        // 서버에 파일 저장
        try {
            upfile.transferTo(new File(serverPath + changeName));
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return webPath + changeName;
    }

    // XSS 공격 방지 처리
    public static String XSSHandling(String content) {
        if (content != null) {
            content = content.replaceAll("&", "&amp;");
            content = content.replaceAll("<", "&lt;");
            content = content.replaceAll(">", "&gt;");
            content = content.replaceAll("\"", "&quot;");
        }
        return content;
    }

    // 개행문자 처리 (\n → <br>)
    public static String newLineHandling(String content) {
        return content.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
    }

    // 개행 해제 처리 (<br> → \n)
    public static String newLineClear(String content) {
        return content.replaceAll("<br>", "\n");
    }
}