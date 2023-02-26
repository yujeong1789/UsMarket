<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/owl.carousel.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/slicknav.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/resources/customer/css/style.css'/>" type="text/css">
    <link rel="shortcut icon" type="image/x-icon" href="data:image/x-icon;," >
    
    <!-- bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    
</head>

<body>
    
    <!-- Header begin -->
    <tiles:insertAttribute name="header" />
    <!-- Header end -->


    <!-- visual begin -->
	<tiles:insertAttribute name="visual" />
    <!-- visual end -->
    
    
	<!-- body begin -->
	<tiles:insertAttribute name="body" />
	<!-- body end -->



    <!-- footer begin -->
    <tiles:insertAttribute name="footer" />
    <!-- footer end -->


    <!-- Js Plugins -->
    <script src="<c:url value='/resources/customer/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/resources/customer/js/jquery.nice-select.min.js'/>"></script>
    <script src="<c:url value='/resources/customer/js/jquery-ui.min.js'/>"></script>
    <script src="<c:url value='/resources/customer/js/jquery.slicknav.js'/>"></script>
    <script src="<c:url value='/resources/customer/js/mixitup.min.js'/>"></script>
    <script src="<c:url value='/resources/customer/js/owl.carousel.min.js'/>"></script>
    <script src="<c:url value='/resources/customer/js/main.js'/>"></script>
	<script src="<c:url value='/resources/customer/js/common.js'/>"></script>
</body>

</html>