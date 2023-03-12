<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false"%>

<c:set var="req" value="${pageContext.request }" />

<c:set var="loginId" value="${empty req.getSession(false) ? '' : pageContext.request.session.getAttribute('adminId')}"/>
<c:set var="loginNo" value="${empty req.getSession(false) ? '' : pageContext.request.session.getAttribute('adminNo')}"/>
<c:set var="loginOutLink" value="${empty loginId ? '/admin/auth/login' : '/admin/auth/logout'}"/>
<c:set var="loginOut" value="${empty loginId ? '로그인' : '로그아웃'}"/>

<header class="header-container base-layout border-b">
	<div class="header-auth">
		<a href="<c:url value='${loginOutLink}' />">${loginOut }</a>
	</div>
</header>