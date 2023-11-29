package kr.spring.service;

public interface PaymentService {
    
   void confirmPayment(String paymentKey, long amount, String orderId);
   
}