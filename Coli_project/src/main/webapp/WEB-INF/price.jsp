<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!-- 로그인한 계정정보 -->
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}" />


<!DOCTYPE html>
<html lang="en">
<head>
<title>DrawColi</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="author" content="TemplatesJungle">
<meta name="keywords" content="Free HTML Template">
<meta name="description" content="Free HTML Template">

<link rel="stylesheet" type="text/css" href="${cpath}/icomoon/icomoon.css">
<link rel="stylesheet" type="text/css" href="${cpath}/css/vendor.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
   integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${cpath}/css/style.css">
<link rel="stylesheet" type="text/css" href="${cpath}/css/pricing-plan.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@900&family=Roboto:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

<!-- 토스 결제위젯 SDK 추가 -->
  <script src="https://js.tosspayments.com/v1/payment-widget"></script>
  
</head>
<body>
   <!-- Header start -->
   <%@ include file="/WEB-INF/header.jsp"%>
   <section id="login-intro" class="login-section">
      <div class="log-in">
         <div class="login-top">
            <img src="${cpath}/images/main-banner1.png" alt="banner"
               class="login-img">
            <div class="login-content">
               <h2 class="login-title">${param.plan} 결제</h2>
            </div>
            <!--banner-content-->
         </div>
         <!--slider-item-->
      </div>
   </section>
   
   
   <!-- 토스 결제 start -->
   
   <!-- 토스 결제 UI, 이용약관 UI 영역 -->
   <div id="payment-method"></div>
   <div id="agreement"></div>
   
   <!-- 결제하기 버튼 -->
   <button id="payment-button">결제하기</button>
   
   <script>
     const clientKey = "test_ck_ex6BJGQOVDK0aj7eB6YJ3W4w2zNb";
     const customerKey = "dBWuNmYAbEB_qq8BDze8S"; // 내 상점에서 고객을 구분하기 위해 발급한 고객의 고유 ID
     const button = document.getElementById("payment-button");
       const orderId = 'DRAW' + Date.now();
       
     // ------  결제위젯 초기화 ------ 
     const paymentWidget = PaymentWidget(clientKey, customerKey) // 회원 결제
   
     // ------  결제 UI 렌더링 ------ 
     const paymentMethodWidget = paymentWidget.renderPaymentMethods(
       "#payment-method", 
       { value: Number("${param.amount}") },
       { variantKey: "DEFAULT" } 
     )
   
     // ------  이용약관 UI 렌더링 ------
     paymentWidget.renderAgreement(
       '#agreement',
       { variantKey: "AGREEMENT" } // 기본 이용약관 UI 렌더링
     )
   
     // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
     button.addEventListener("click", function () {
       paymentWidget.requestPayment({
         orderId: orderId, // 주문 상품 ID           
         orderName: "${param.plan} 요금제", // 주문명                
         customerEmail: "${mvo.email}",
         customerName:  "${mvo.name}",
/*          customerMobilePhone: "${mvo.phone}", */
           successUrl: "http://localhost:8081/boot/toss/success", 
         failUrl: "http://localhost:8081/boot/toss/payFail"
       });
     });
   </script>
   
   <!-- 토스 결제 end -->
    
   <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

   <script src="${cpath}/js/jquery-1.11.0.min.js"></script>
   <script src="${cpath}/js/ui-easing.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
   <script src="${cpath}/js/plugins.js"></script>
   <script src="${cpath}/js/script.js"></script>
</body>
</html>