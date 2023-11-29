package kr.spring.service;



import javax.servlet.http.HttpSession;

import kr.spring.entity.Member;
import kr.spring.exception.PasswordNotMatchException;

public interface MemberService {
    boolean join(Member vo) throws PasswordNotMatchException;
    
    boolean login(Member vo, HttpSession session);
    
    public void modify(Member vo, HttpSession session );
    
    boolean isPasswordMatch(String password, String passwordConfirmation);

   Member getMemberByUsername(String username);
    
}