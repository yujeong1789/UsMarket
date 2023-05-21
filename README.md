# usMarket
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fyujeong1789%2FusMarket&count_bg=%2316A7F1&title_bg=%23808080&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=true)](https://hits.seeyoufarm.com)

<div align="center">
  <img src="https://github.com/yujeong1789/usMarket/assets/73736082/07f6eea0-7b17-492e-acc7-d52f07d9ee2e"/>
</div>

- 개발기간: 2022.11 ~ 2023.04 
> 🔗 [어스마켓](http://64.110.76.236/usMarket/) (테스트 계정: testuser1 / testuser1@@)<br>
> 🔗 [어스마켓 관리자 페이지](http://64.110.76.236/usMarket/admin/home) (테스트 계정: admin1 / admin1)
<br>

### 목차
1. [프로젝트 소개](#프로젝트-소개)
2. [프로젝트 목표](#프로젝트-목표)
3. [기술스택](#기술스택)
4. [Blog](#blog)
5. [구현 기능](#구현-기능)  

<br>

### 프로젝트 소개
어스마켓은 번개장터를 모티브로 한 1:1 온라인 중고거래 플랫폼입니다. 다양한 상품 카테고리를 통해 내 취향에 맞는 상품을 찾을 수 있으며, 채팅을 통해 구매/판매자와 실시간 소통 기능을 제공합니다.

<br>

### 프로젝트 목표
- 실제 서비스되는 웹사이트를 벤치마킹해 핵심 기능 따라 구현해 보기
- WebSocket으로 실시간 채팅, 알림 구현
- Tiles 적용해 페이지 관리 간소화
- AWS S3 사용해 리소스 관리
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

### Blog
- [Oracle Cloud에 프로젝트 배포](https://velog.io/@yujeong1789/m1-mac-Oracle-Cloud에-Spring-Project-배포하기-3-war파일-배포-DB-연동)
- [AWS S3 연동해 파일 업로드하기](https://velog.io/@yujeong1789/Spring-AWS-S3-연동해-파일-업로드하기-2-연동-사진-업로드하기)
- [조회수 중복 방지 구현하기](https://velog.io/@yujeong1789/조회수-중복-방지-구현하기)
<br><br>

### 구현 기능
<details>
<summary>구현 기능 자세히 보기</summary>
<div markdown="1">

### 비회원
  - 회원가입 (SMTP 이용한 이메일 인증 적용)
  - 상품 조회
  - 공지사항 조회
    
### 회원
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
    
### 관리자
  1. 회원
      - 가입 회원 목록 조회 (Chart.js 사용해 차트화)
      - 회원 상세 조회
  2. 결제
      - 발생 결제 목록 조회 (Chart.js 사용해 차트화)
  3. 신고
        - 접수된 신고 목록 조회
        - 신고 상세 조회 (사유별 부가정보 출력)
        - 신고 제재 등록
  4. 문의
        - 접수된 문의 목록 조회
        - 문의 상세 조회
        - 문의 답변 등록
  5. 공지사항
        - 공지사항 목록 조회
        - 공지사항 등록, 조회, 수정, 삭제
    
</div>  
</details>
