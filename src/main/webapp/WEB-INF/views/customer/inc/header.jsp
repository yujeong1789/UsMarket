<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false"%>

<c:set var="req" value="${pageContext.request }" />

<%-- <c:set var="loginId" value="${req.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId')}"/> --%>
<c:set var="loginId" value="${req.getSession(false) == null ? '' : pageContext.request.session.getAttribute('userId').member_id}"/>
<c:set var="loginOutLink" value="${empty loginId ? '/member/login' : '/member/logout.do'}"/>
<%-- <c:set var="loginOutLink" value="${empty loginId ? '/member/login' : '/member/logout'}"/> --%>
<c:set var="loginOut" value="${empty loginId ? '로그인' : '로그아웃'}"/>

<script src="https://code.jquery.com/jquery-1.11.3.js"></script>

	<!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__left">
                            <div class="header__top__left__favorite">
                            	<a class="favorite" href="#"><img src="<c:url value='/resources/customer/img/favorite.png' />">즐겨찾기</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__right">
                            <div class="header__top__right__auth">
                            	loginId = ${empty loginId ? '없음' : loginId} <!-- 확인용, 추후 삭제 -->
                            	<div class="header__top__right__auth__login">
                            		<a href="<c:url value='${loginOutLink}' />">${loginOut }</a>
                            	</div>
                            	<div><a href="#">고객센터</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
	<!-- Header Section End -->
	
<script type="text/javascript">
	// 즐겨찾기 추가 스크립트
	$(document).ready(function(){
		$('.favorite').on('click', function(e) {
			let bookmarkURL = window.location.href;
            let bookmarkTitle = document.title;
            let triggerDefault = false;
            if (window.sidebar && window.sidebar.addPanel) {
                // Firefox version < 23
                window.sidebar.addPanel(bookmarkTitle, bookmarkURL, '');
            } else if ((window.sidebar && (navigator.userAgent.toLowerCase().indexOf('firefox') > -1)) || (window.opera && window.print)) {
                // Firefox version >= 23 and Opera Hotlist
                let $this = $(this);
                $this.attr('href', bookmarkURL);
                $this.attr('title', bookmarkTitle);
                $this.attr('rel', 'sidebar');
                $this.off(e);
                triggerDefault = true;
            } else if (window.external && ('AddFavorite' in window.external)) {
                // IE Favorite
                window.external.AddFavorite(bookmarkURL, bookmarkTitle);
            } else { // WebKit - Safari/Chrome
                alert((navigator.userAgent.toLowerCase().indexOf('mac') != -1 ? 'Cmd' : 'Ctrl') + '+D 키를 눌러 즐겨찾기에 등록하실 수 있습니다.');
            }
			return triggerDefault;
		});
	});	    
</script>