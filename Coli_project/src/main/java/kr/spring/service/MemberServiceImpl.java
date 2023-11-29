package kr.spring.service;




import java.security.Principal;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.spring.entity.Member;
import kr.spring.exception.PasswordNotMatchException;
import kr.spring.repository.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Override
    public boolean join(Member vo) throws PasswordNotMatchException {
        if (isPasswordMatch(vo.getPassword(), vo.getPasswordConfirmation())) {
            String encPw = vo.getPassword();
            vo.setPassword(passwordEncoder.encode(encPw));
            memberRepository.save(vo);
            return true;  // 가입 성공
        } else {
            throw new PasswordNotMatchException("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        }
    }

    @Override
    public boolean login(Member vo, HttpSession session) {
        Member existingMember = memberRepository.findById(vo.getUsername()).orElse(null);
        
        boolean check = existingMember != null && passwordEncoder.matches(vo.getPassword(), existingMember.getPassword());
        System.out.println("login : " + check);
        if(check) {
        	
        	// 세션에 사용자 정보 저장
        	session.setAttribute("user", existingMember);
        }

        return check;
    }
    
    @Override
    public void modify(Member vo, HttpSession session ) {
        // 기존 회원 정보를 데이터베이스에서 가져옴
       System.out.println(vo);
        Optional<Member> member = memberRepository.findById(vo.getUsername());
//      
        Member existingMember = member.get();
        if (existingMember != null) {
            // 변경할 속성들만 업데이트
            existingMember.setNickname(vo.getNickname());
            existingMember.setPhone(vo.getPhone());
            existingMember.setEmail(vo.getEmail());
            System.out.println(existingMember);
            // 수정된 회원 정보 저장
            memberRepository.save(existingMember);
            
			            
        }
    }
    
    @Override
    public Member getMemberByUsername(String username) {
       // 회원 이름을 기반으로 회원 정보를 데이터베이스에서 가져옴
        Optional<Member> memberOptional = memberRepository.findById(username);

        // Optional에서 값이 존재하면 해당 회원 정보 반환, 없으면 null 반환
        return memberOptional.orElse(null);
    }



    @Override
    public boolean isPasswordMatch(String password, String passwordConfirmation) {
        return password.equals(passwordConfirmation);
    }
    
    
    


}