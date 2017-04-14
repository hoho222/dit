package doto.common.util;

import java.util.UUID;

public class CommonUtils {
	
	//저장되는 파일명을 랜덤 32글자로 변환
	public static String getRandomString(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
