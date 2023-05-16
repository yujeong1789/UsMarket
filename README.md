# usMarket
<div align="center">
  <img src="https://github.com/yujeong1789/usMarket/assets/73736082/07f6eea0-7b17-492e-acc7-d52f07d9ee2e"/>
</div>

>개발기간: 2022.12 ~ 2023.04 

<br>

### 프로젝트 소개
어스마켓은 번개장터를 모티브로 한 1:1 온라인 중고거래 플랫폼입니다. 다양한 상품 카테고리를 통해 내 취향에 맞는 상품을 찾을 수 있으며, 채팅을 통해 구매/판매자와 실시간으로 소통할 수 있습니다. 

<br> 

### 프로젝트 목표
- WebSocket으로 실시간 채팅, 알림 구현
- Tiles 적용해 페이지 관리 간소화
- AWS S3로 상품, 프로필 이미지 관리
- 클라우드 서버에 웹 어플리케이션 배포

<br>

### 기술스택
- Front-end
  - `javascript` `Bootstrap` 
- Back-end
  - `Java` `Spring` `Spring Security` `MyBatis` `WebSocket`
- Test
  - `JUnit4`
- Database
  - `Oracle` `Oracle Cloud ATP`
- Deploy
  - `Oracle Cloud` `AWS S3`
- etc
  - `Git`

<br>

### 주요 화면
<img style="object-fit=contain;width:49%;" src="https://github.com/yujeong1789/usMarket/assets/73736082/04da4195-9eb8-43e4-872c-f7f1924e3344">
<img style="object-fit=contain;width:49%" src="https://github.com/yujeong1789/usMarket/assets/73736082/a7a6aceb-bda7-465f-95c0-24eda05309fd">
</div>
<br><br>
<img style="object-fit=contain;width:49%" src="https://github.com/yujeong1789/usMarket/assets/73736082/410ab75c-7ad0-4dad-9544-540dfdfd6f84">
<img style="object-fit=contain;width:49%" src="https://github.com/yujeong1789/usMarket/assets/73736082/e9900291-d9b8-41bd-94ae-c0ce83148702">
<br><br>
<img style="object-fit=contain;width:49%" src="https://github.com/yujeong1789/usMarket/assets/73736082/031c62d0-df8f-48ab-abf3-23b0a4da4dd2">

<br>

### 구현 기능
- **비회원**
  - 회원가입 (SMTP 이용한 이메일 인증 적용)
  - 상품 조회
  - 공지사항 조회
- **회원**
  1. 상품
      - 상품 조회
      - 상품 등록, 삭제
      - 상품 판매상태 변경 (판매 중, 예약 중)
      - 상품 찜 등록, 해제
      - 상품 구매 (구매시 채팅으로 알림 발송)
      - 채팅방 이동
      
  2. 마이페이지
      - 등록된 상품 조회
      - 찜한 상품 조회
      - 작성된 후기 조회
      - 회원 정보 수정
      
  3. 거래내역
      - 구매/판매 목록 조회
      - 거래내역 상세 조회
      - 거래상태 변경 (변경시 채팅으로 알림 발송)
      - 후기 작성
  4. 채팅
      - 채팅방 생성
      - 채팅방 목록 조회
      - 채팅방 상세 조회
      - 채팅 전송
      - 알림일 경우 거래내역 이동
  5. qna
      - 문의 작성
      - 문의 목록 조회
      - 문의 상세 조회
  6. 공지사항
      - 공지사항 목록 조회
      - 공지사항 상세 조회
- **관리자**
  1. 회원
      - 가입 회원 목록 조회 (Chart.js 사용해 차트화)
      - 회원 상세 조회
  3. 결제
      - 발생 결제 목록 조회 (Chart.js 사용해 차트화)
  5. 신고
      - 접수된 신고 목록 조회
      - 신고 상세 조회 (사유별 부가정보 출력)
      - 신고 제재 등록
  7. 문의
      - 접수된 문의 목록 조회
      - 문의 상세 조회
      - 문의 답변 등록
  9. 공지사항
      - 공지사항 목록 조회
      - 공지사항 등록, 조회, 수정, 삭제
