<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<section class="hero">
	<div class="row">
		<div class="container">
			<div class="visual__container">
				<a href="<c:url value='/'/>">
					<img src="<c:url value='/resources/customer/img/logo.png'/>" alt="">
				</a>
				<div class="hero__search__form">
					<form action="<c:url value='/product/list'/>" id="searchForm">
						<input type="text" name="keyword" id="searchKeyword"
							placeholder="상품명 또는 태그로 원하는 상품을 검색하세요.">
						<button type="submit" id="submit" class="site-btn">SEARCH</button>
					</form>
				</div>
				<div class="hero__search__mypage">
					<a href="<c:url value='/product/sell'/>">판매하기</a>
					<span>|</span> 
					<a href="<c:url value='/member/mypage'/>">내상점</a>
					<span>|</span>
					<a href="<c:url value='/chat/list'/>">채팅</a>
					<img src="<c:url value='/resources/customer/img/new_chat_icon.png'/>">
				</div>
			</div>

		</div>
	</div>
	
	<div class="row bottom__shadow">
		<div class="container">
			<div class="index__visual">
				<div class="hero__categories">
					<div class="hero__categories__all" id="hero__categories__all">
						<img src="<c:url value='/resources/customer/img/categories/line1.png' />">
						<span>전체 카테고리</span>
					</div>
					<ul id="ul__allCategory">
						<li><a id="1" href="<c:url value='/product/list?category1=1'/>">여성의류</a></li>
						<li><a id="2" href="<c:url value='/product/list?category1=2'/>">남성의류</a></li>
						<li><a id="3" href="<c:url value='/product/list?category1=3'/>">패션잡화</a></li>
						<li><a id="4" href="<c:url value='/product/list?category1=4'/>">시계/쥬얼리</a></li>
						<li><a id="5" href="<c:url value='/product/list?category1=5'/>">디지털/가전</a></li>
						<li><a id="6" href="<c:url value='/product/list?category1=6'/>">스포츠/레저</a></li>
						<li><a id="7" href="<c:url value='/product/list?category1=7'/>">차량/오토바이</a></li>
						<li><a id="8" href="<c:url value='/product/list?category1=8'/>">음반/악기</a></li>
						<li><a id="9" href="<c:url value='/product/list?category1=9'/>">도서/티켓/문구</a></li>
						<li><a id="10" href="<c:url value='/product/list?category1=10'/>">뷰티/미용</a></li>
						<li><a id="11" href="<c:url value='/product/list?category1=11'/>">가구/인테리어</a></li>
						<li><a id="12" href="<c:url value='/product/list?category1=12'/>">생활/가공식품</a></li>
						<li><a id="13" href="<c:url value='/product/list?category1=13'/>">유아동/출산</a></li>
						<li><a id="14" href="<c:url value='/product/list?category1=14'/>">반려동물용품</a></li>
						<li><a id="15" href="<c:url value='/product/list?category1=15'/>">기타</a></li>
					</ul>
				</div> <!-- hero__categories__all -->
			</div>
		</div>
	</div>
</section>

<script type="text/javascript">
const searchForm = document.getElementById('searchForm');
searchForm.addEventListener('submit', function(e){
	if(document.getElementById('searchKeyword').value.length < 2){
		alert("검색어는 두 글자 이상 입력해 주세요.");
		e.preventDefault();
	};
});
		
if(!isEmpty(document.getElementById('loginNo').dataset.no)){
	fetch('/usMarket/fetch/newchat')
	.then((response) => response.text())
	.then((text) => {
		if(text > 0){
			document.querySelector('.hero__search__mypage > img').style.visibility = 'visible';
		}	
	}).catch((error) => console.log("error: "+error));
}
</script>