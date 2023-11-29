<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<title>DrawColi2</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="author" content="TemplatesJungle">
<meta name="keywords" content="Free HTML Template">
<meta name="description" content="Free HTML Template">

<link rel="stylesheet" type="text/css"
   href="${cpath}/icomoon/icomoon.css">
<link rel="stylesheet" type="text/css" href="${cpath}/css/vendor.css">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
   crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${cpath}/css/style.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=Montserrat:wght@900&family=Roboto:ital,wght@0,400;0,700;1,400;1,700&display=swap"
   rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdn.jsdelivr.net/npm/@mediapipe/pose/pose.js"
   crossorigin="anonymous"></script>


<script src="${cpath}/js/ammo.wasm.js"></script>
<script async
   src="https://unpkg.com/es-module-shims@1.3.6/dist/es-module-shims.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@mediapipe/pose/pose.js"
   crossorigin="anonymous"></script>
   

<link rel="stylesheet" href="${cpath}/css/animation.css">

<script type="importmap">
        {
           "imports": {
                 "three": "https://unpkg.com/three@0.158.0/build/three.module.js",
                 "three/addons/": "https://unpkg.com/three@0.158.0/examples/jsm/"
           }
          }
    </script>
<script src="${cpath}/js/html2canvas.min.js"></script>
<script type="module" src="${cpath}/js/animation.js" defer></script>



<style>
/* 페이지 전체에 대한 기본 스타일 */
@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}
body {
   font-family: 'SUITE-Regular';
   margin: 0;
   padding: 0;
   background: #f0f0f0;
   overflow: auto;
}

/* 그리드 레이아웃 스타일 */
.grid-container {
   display: grid;
   grid-template-columns: 100px 1fr;
   gap: 10px;
   padding: 10px;
   height: 100vh;
}

/* 클릭형일 때의 그리드 레이아웃 스타일 */
.grid-item-group.click-layout {
   display: grid;
   grid-template-columns: 4fr 6fr;
   gap: 10px;
   height: 900px;
}

/* 업로드 또는 촬영 형일 때의 그리드 레이아웃 스타일 */
.grid-item-group.upload-capture-layout {
   display: grid;
   grid-template-columns: 5fr 5fr; /* 5:5 비율로 설정 */
   gap: 10px;
   height: 900px;
}

.grid-item {
   background-color: #fff;
   padding: 20px;
   border-radius: 5px;
   border: 1px solid #ddd;
   text-align: center;
   /* height: 100vh !important; */
}

/* 왼쪽 메뉴 스타일 */
#action-selection {
   font-size: 16px;
   text-align: left;
   /* display: flex; */
   flex-wrap: wrap; /* 줄 바꿈 설정 */
   gap: 5px; /* 버튼 사이의 간격 */
   text-align: center;
   
}

#action-selection a {
   display: block;
   width: max-content; /* 텍스트 크기에 맞게 조절됨 */
   height: max-content;
   padding: 10px;
   margin: 2px 0;
   border: 1px solid #ddd;
   border-radius: 4px;
   background-color: #f7f7f7;
   text-decoration: none;
   color: black;
   text-align: center;
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
}

/* 오른쪽 섹션 스타일 */
.my-work-history {
   display: flex; /* 컨텐츠를 가로 정렬하기 위해 flex 사용 */
   justify-content: center; /* 수평 가운데 정렬 */
   align-items: center; /* 수직 가운데 정렬 */
   /* 예시 */
    width: 100%; /* 또는 특정 픽셀값 */
    height: 80%; /* 또는 적절한 다른 값 */
}

#my-work-history img {
   vertical-align: middle;
}

/* 오른쪽 섹션 스타일 */
.my-work-history select {
   width: calc(100% - 40px); /* 아이콘 공간 빼고 너비 */
   padding: 10px;
   margin-right: 10px;
   border: 1px solid #ddd;
   border-radius: 4px;
}

.my-work-history img {
   vertical-align: middle;
}

html, body {
   height: 100%;
}

body {
   display: flex;
   flex-direction: column;
}

.grid-container {
   flex: 1; /* 중요: 그리드 컨테이너가 남은 공간을 모두 차지하도록 설정 */
}

/* 사이드 바 스타일 */
.sidebar {
   grid-column: 1; /* 사이드바를 첫 번째 열에 위치 */
   background-color: #333;
   overflow-x: hidden;
   padding-top: 30px;
   display: flex; /* 가로 정렬을 위해 flex 사용 */
   flex-direction: column; /* 세로 정렬을 위해 컬럼 방향으로 설정 */
   align-items: center; /* 가로 가운데 정렬 */
   height: auto;/* 1010px !important; */
   width: 100px;
   border-radius: 5px;
}

.sidebar button {
   background-color: transparent;
   margin: 0;
   text-decoration: none;
   color: white;
   display: block;
   transition: 0.3s;
   text-align: center; /* 텍스트 가로 가운데 정렬 */
   margin-bottom: 30px;
}

.sidebar a:hover {
   color: #f1f1f1;
}
.grid-item {
   background-color: #fff;
   padding: 30px;
   border-radius: 5px;
   border: 1px solid #ddd;
}

.showButton {
   background-color: #333; 
   border : none;
   color: white;
   padding: 15px 32px; /* 상하 15px, 좌우 32px 패딩 */
   text-align: center;
   text-decoration: none;
   display: inline-block;
   font-size: 16px;
   margin: 4px 2px; /* 위아래 4px, 좌우 2px 마진 */
   cursor: pointer;
   border-radius: 50px; /* 둥근 모서리 효과 */
   box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* 그림자 효과 */
   transition-duration: 0.4s; /* 마우스 호버 시 애니메이션 지속 시간 */
   height: fit-content;
   font-size: 15px;
   border: none;
}

.showButton:hover {
   box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
      rgba(0, 0, 0, 0.19); /* 호버 시 그림자 효과 강조 */
}

/* 버튼이 활성화(클릭됐을 때) 상태일 때의 스타일 */
.showButton:active {
   background-color: #3e8e41;
   box-shadow: 0 5px #666;
   transform: translateY(4px);
}

.fa-solid {
   color: #fff;
   font-size: 25px;
}
.sidebar button:hover {
  transform: scale(1.2); /* 마우스 오버 시 버튼 크기 20% 증가 */
}

.sticky-header {
    position: sticky;
    top: 0; /* 상단에 고정 */
    background-color: #fff; /* 회색 배경 */
    text-align: center; /* 텍스트 중앙 정렬 */
    padding: 10px 0; /* 상하 패딩 */
    z-index: 1; /* 다른 요소 위에 나타나도록 z-index 설정 */
    border-bottom: 2px lightgray solid;
    font-size: 20px;
    color: black;
    font-weight: bold;
    margin-bottom: 50px;
}

/* 캡쳐 버튼 스타일 */
#captureButton {
   position: sticky;
    top: 0;
    left: 0;
    z-index: 0;
    margin-top: 15px; /* 헤더 아래에 간격 추가 */
    padding: 10px 20px; /* 버튼 패딩 조정 */
    background-color: #007bff; /* 버튼 배경색 */
    color: white; /* 버튼 텍스트 색상 */
    border: none; /* 버튼 테두리 제거 */
    cursor: pointer;
    font-size: 16px;
    border-radius: 5px;
}

#captureButton:hover {
    background-color: #0056b3; /* 마우스 호버시 배경색 변경 */
}

.right_r{
   margin-bottom: 10px !important;
}

</style>
</head>
<body>
   <%@ include file="/WEB-INF/header.jsp"%>
   <section id="login-intro" class="login-section"">
      <div class="log-in"">
         <div class="login-top"">
            <img src="${cpath}/images/main-banner1.png" alt="banner"
               class="login-img">
            <div class="login-content">
               <h2 class="login-title">Draw</h2>
            </div>
            <!--banner-content-->
         </div>
         <!--slider-item-->

         <div class="grid-container">

            <!-- 사이드 바 -->
            <div class="sidebar">
               <button id="click-button" title="클릭형 자세 만들기"
                  onclick="window.location.href='${cpath}/draw2';"><i class="fa-solid fa-arrow-pointer"></i></button>
               <button id="upload-button" title="이미지 업로드 자세 만들기"
                  onclick="window.location.href='${cpath}/draw3';"><i class="fa-solid fa-images"></i></button>
               <button id="capture-button" title="실시간 자세 만들기"
                  onclick="window.location.href='${cpath}/draw4';"><i class="fa-solid fa-video"></i></button>
            </div>

            <!-- 클릭 콘텐츠 -->
            <div id="click-content" class="content-section ">
               <div class="grid-item-group click-layout">

                  <!-- 왼쪽 섹션: 동작 선택 -->
                  <div class="grid-item" id="action-selection">
                     <div class="sticky-header">자세 선택창</div>
                     <button class="showButton" id="pose1">깜찍한 자세</button>
                     <button class="showButton" id="pose2">두 팔 벌려 선 자세</button>
                     <button class="showButton" id="pose3">바닥에 누워 한손 올린 자세</button>
                     <button class="showButton" id="pose4">뛰는 자세</button>
                     <button class="showButton" id="pose5">서서 한쪽 발만 올린 자세</button>
                     <button class="showButton" id="pose6">엎드려 턱괴고 있는 자세</button>
                     <button class="showButton" id="pose7">뒤에 기대어 앉아있는 자세</button>
                     <button class="showButton" id="pose8">바닥에 누워 한팔로 기대고있는
                        자세</button>
                     <button class="showButton" id="pose9">뒤로 기대 누운 자세</button>
                     <button class="showButton" id="pose10">앉아서 고민하는 자세</button>
                     <button class="showButton" id="pose11">정자세로 서있는 자세</button>
                     <button class="showButton" id="pose12">기어가는 자세</button>
                     <button class="showButton" id="pose13">뭔자세야</button>
                     <button class="showButton" id="pose14">바닥에 누워 한팔로 기대고있는
                        자세2</button>
                     <button class="showButton" id="pose15">서서 한쪽 팔로 기대고 있는
                        자세</button>
                     <button class="showButton" id="pose16">두팔 벌려 점프하는 자세</button>
                     <button class="showButton" id="pose17">전속력으로 뛰는 자세</button>
                     <button class="showButton" id="pose18">앉아서 쉬는 자세</button>


                  </div>

                  <!-- 오른쪽 섹션: 현재 작업 내역 -->
                  <div class="grid-item">
                     <div class="sticky-header right_r">작업물</div>
                     <button id="captureButton" class="btn_download">Save Image</button>
                       남은 다운로드 횟수: <span id="downloadCount">10</span> <!-- 클릭 횟수를 표시할 요소 -->
                     <div class="my-work-history">
                        <div id="webgl-container" style="display: none;"></div>
                     </div>
                  </div>
               </div>
            </div>

         </div>
      </div>


      <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
      <script
         src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
      <script
         src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

      <script src="${cpath}/js/jquery-1.11.0.min.js"></script>
      <script src="${cpath}/js/ui-easing.js"></script>
      <script
         src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
         integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
         crossorigin="anonymous"></script>
      <script src="${cpath}/js/plugins.js"></script>
      <script src="${cpath}/js/script.js"></script>

      <script type="text/javascript">
         var cpath = "${cpath}";
    </script>
</body>

</html>