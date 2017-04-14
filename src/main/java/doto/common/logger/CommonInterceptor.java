package doto.common.logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import doto.common.logger.CommonInterceptor;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import doto.common.logger.CommonInterceptor;

public class CommonInterceptor extends HandlerInterceptorAdapter{
	protected Log log = LogFactory.getLog(CommonInterceptor.class);
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		String requestUrl = request.getRequestURL().toString();
		
		
        if (log.isDebugEnabled()) {
            log.debug("======================================          FRONT interceptor START         ======================================");
            log.debug(" Request URI \t:  " + request.getRequestURI());
        }
        
        
        HttpSession session = request.getSession();
        
        String sessionName = (String)session.getAttribute("loginName");
        String sessionNickName = (String)session.getAttribute("loginNickName");
       
        if(requestUrl.contains("/doto/goals") || requestUrl.contains("/doto/goalsform") || requestUrl.contains("/doto/mypages")){
        	//목표달성 관련된 mapping일 때는 로그인 여부를 체크해야함.
	        if(sessionName == null && sessionNickName == null){
	        	//로그인 안된 상태이면 로그인 페이지로 이동
	        	response.sendRedirect("/doto/users/login"); 
				return false;
	        }
        }
        
        return super.preHandle(request, response, handler);
    }
     
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("======================================           FRONT interceptor END          ======================================\n");
        }
    }
}
