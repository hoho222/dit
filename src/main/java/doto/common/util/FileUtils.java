package doto.common.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
 
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtils")
public class FileUtils {
	private static String filePath = "";
	
	//configuration.xml 에서 해당 값 불러옴
	@Value("#{config['GOAL_COMMENT_IMG_PATH_LOCAL']}") String goalCommentImgPathLocal;
	@Value("#{config['GOAL_RESULT_IMG_PATH_LOCAL']}") String goalResultImgPathLocal;
	@Value("#{config['GOAL_COMMENT_IMG_PATH']}") String goalCommentImgPath;
	@Value("#{config['GOAL_RESULT_IMG_PATH']}") String goalResultImgPath;
	
	public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
         
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;
         
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null;
         
        String goalIdx = (String)map.get("goalIdx");
        String goalCommentIdx = "";
        String goalResultIdx = "";
        
        String pathGB = (String)map.get("GB");
        
        //path 구분값을 맵에 담겨진 GB값에 따라 바꿔줌
        if(pathGB.equals("commentImg")){
        	goalCommentIdx = String.valueOf(map.get("IDX"));
        	filePath = goalCommentImgPath.toString();
        } else if(pathGB.equals("resultImg")) {
        	goalResultIdx = String.valueOf(map.get("IDX"));
        	filePath = goalResultImgPath.toString();
        }
         
        File file = new File(filePath);
        if(file.exists() == false){
            file.mkdirs();
        }
        
         
        while(iterator.hasNext()){
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                 
                file = new File(filePath + storedFileName);
                multipartFile.transferTo(file);
                 
                listMap = new HashMap<String,Object>();
                listMap.put("goalIdx", goalIdx);
                if(!"".equals(goalCommentIdx)){
                	listMap.put("goalCommentIdx", goalCommentIdx);
                }
                if(!"".equals(goalResultIdx)){
                	listMap.put("goalResultIdx", goalResultIdx);
                }
                listMap.put("originalFileName", originalFileName);
                listMap.put("storedFileName", storedFileName);
                listMap.put("fileSize", multipartFile.getSize());
                listMap.put("filePath", filePath);
                list.add(listMap);
            }
        }
        return list;
    }


}
