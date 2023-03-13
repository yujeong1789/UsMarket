<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false"%>

<c:set var="req" value="${pageContext.request }" />

<c:set var="admin" value="${empty req.getSession(false) ? '' : pageContext.request.session.getAttribute('admin')}"/>

<header class="header-container base-layout border-b">
	<div class="header-auth">
		<!-- 확인용, 추후 삭제 -->
		<div>${empty admin ? '없음' : ('no = ' += admin.ADMIN_NO +=', id = ' += admin.ADMIN_ID += ', name = ' += admin.ADMIN_NAME)}</div>
		<input type="hidden" id="admin_auth" data-no="${admin.ADMIN_NO }" data-id="${admin.ADMIN_ID }" data-name="${admin.ADMIN_NAME }" />
		<a href="<c:url value='/admin/logout' />">로그아웃</a>
	</div>
</header>