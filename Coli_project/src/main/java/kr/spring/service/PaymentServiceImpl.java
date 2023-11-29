package kr.spring.service;

import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.entity.Member;
import kr.spring.entity.Payment;
import kr.spring.entity.Role;
import kr.spring.repository.MemberRepository;
import kr.spring.repository.PaymentRepository;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Optional;

@Service
public class PaymentServiceImpl implements PaymentService {

   private final PaymentRepository paymentRepository;
    private final MemberRepository memberRepository; 

   public PaymentServiceImpl(PaymentRepository paymentRepository, MemberRepository memberRepository) {
      this.paymentRepository = paymentRepository;
        this.memberRepository = memberRepository;
   }

   @Override
   @Transactional
   public void confirmPayment(String paymentKey, long amount, String orderId) {
      try {
         String requestBody = String.format("{\"paymentKey\":\"%s\",\"amount\":%d,\"orderId\":\"%s\"}", paymentKey,
               amount, orderId);

         HttpRequest request = HttpRequest.newBuilder()
               .uri(URI.create("https://api.tosspayments.com/v1/payments/confirm"))
               .header("Authorization", "Basic dGVzdF9za19HdjZMamVLRDhhamp4TDBOeEFYTjN3WXhBZFh5Og==") // 인코딩된 시크릿 키
               .header("Content-Type", "application/json")
               .method("POST", HttpRequest.BodyPublishers.ofString(requestBody)).build();

         HttpResponse<String> response = HttpClient.newHttpClient().send(request,
               HttpResponse.BodyHandlers.ofString());

         // 결제 승인 응답 처리
         String responseContent = response.body();

         JSONObject jsonResponse = new JSONObject(responseContent);

         // 필요한 정보 추출
         String payOrderId = jsonResponse.getString("orderId");
         long payAmount = jsonResponse.getLong("totalAmount");
         String orderName = jsonResponse.getString("orderName").replace("'", "").replace(" ", "").replace("요금제", "");
         String approvedAt = jsonResponse.getString("approvedAt");
         String payType = jsonResponse.getString("method");
         
            // 현재 로그인한 사용자의 username 조회
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String currentUsername = authentication.getName();
            Optional<Member> memberOptional = memberRepository.findById(currentUsername);

            
            if (memberOptional.isPresent()) {
               Member member = memberOptional.get();
               
                // orderName에 따라 Member의 role 업데이트
                Role updatedRole = convertOrderNameToRole(orderName);
                member.setRole(updatedRole);

                // 업데이트된 Member 저장
                memberRepository.save(member);
                
             // Payment 객체 생성 및 저장         
             Payment payment = new Payment(0, member, payOrderId, payAmount, orderName, approvedAt, payType);
             paymentRepository.save(payment);
             
             System.out.println(orderName);
            }    
      } catch (Exception e) {
         e.printStackTrace();
         // 예외 처리 로직
      }
   }
   
   // orderName을 Role로 변환하는 메서드
    private Role convertOrderNameToRole(String orderName) {
        switch (orderName) {
            case "Standard":
                return Role.STANDARD;
            case "Premium":
                return Role.PREMIUM;
            default:
                return Role.FREE;
        }
    }
}