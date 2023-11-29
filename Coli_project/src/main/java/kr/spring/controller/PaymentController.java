package kr.spring.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.service.PaymentService;

@Controller
@RequestMapping("toss/*")
public class PaymentController {

    private final PaymentService paymentService;

    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @RequestMapping("/success")
    public String confirmPayment(@RequestParam String paymentKey,
                                 @RequestParam long amount,
                                 @RequestParam String orderId) {
        try {
            // 토스페이먼츠 결제 승인 로직 처리
            paymentService.confirmPayment(paymentKey, amount, orderId);
            // 결제 성공시 paySuccess 뷰로 리디렉션
            return "draw";
        } catch (Exception e) {
            // 결제 실패 또는 예외 발생시 payFail 뷰로 리디렉션
        	return "draw";
        }
    }
    
}