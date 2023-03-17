<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<!-- admin layout -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title><tiles:getAsString name="title" /></title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/bootstrap.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/font-awesome.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/elegant-icons.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/nice-select.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/jquery-ui.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/resources/admin/css/style.css'/>" type="text/css">
    <link rel="icon" type="image/x-icon" href="<c:url value='/resources/admin/favicon/admin-favicon.ico'/>">
    
    <!-- bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    
</head>

<body>
    <!-- Js Plugins -->
    <script src="<c:url value='/resources/customer/js/common.js'/>"></script>
    
    
	<!-- Header begin -->
	<tiles:insertAttribute name="header" />
	<!-- Header end -->
	
	<!-- aside begin -->
	<tiles:insertAttribute name="aside" />
	<!-- aside end -->
		    
	<main class="main-layout">
		<!-- body begin -->
		<tiles:insertAttribute name="body" />
		<!-- body end -->
	</main>
</body>

</html>