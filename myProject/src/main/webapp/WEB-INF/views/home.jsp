<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>How many abandoned animals around you</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/css/main.css" />
<c:if test="${signupResult == true}">
	<script type="text/javascript">
		alert("회원가입을 환영합니다!");
	</script>
</c:if>

<c:if test="${byebye == true}">
	<script type="text/javascript">
		alert("지금까지 이용해주셔서 감사합니다");
	</script>
</c:if>

<c:if test="${byebye == false}">
	<script type="text/javascript">
		alert("회원탈퇴를 실패하였습니다");
	</script>
</c:if>
</head>
<body class="is-preload">
	<div id="wrapper">

		<!-- Header -->
		<header id="header">
			<div class="inner">

				<a href="" class="logo">
					<span class="title">How many abandoned animals around you</span>
				</a>

				<nav>
					<ul>
						<li><a href="#menu">Menu</a></li>
					</ul>
				</nav>
			</div>
		</header>

		<!-- Menu -->
		<nav id="menu">
			<h2>Menu</h2>
			<ul>
				<li><a href="./">Home</a></li>
				<c:if test="${sessionScope.loginId == null}">
					<li><a href="login">Login / Signup</a></li>
				</c:if>
				<c:if test="${sessionScope.loginId != null}">
					<li><a href="around">내 주위 유기동물</a></li>
				</c:if>
				<c:if test="${sessionScope.loginId != null}">
					<li><a href="outer">내가 사는 곳 너머의 유기동물</a></li>
				</c:if>
				<c:if test="${sessionScope.loginId != null}">
					<li><a href="myAnimal">내 관심 동물</a></li>
				</c:if>
				<c:if test="${sessionScope.loginId != null}">
					<li><a href="mypage">개인정보수정</a></li>
				</c:if>
				<c:if test="${sessionScope.loginId != null}">
					<li><a href="logout">Logout</a></li>
				</c:if>
			</ul>
		</nav>

		<!-- Main -->
		<div id="main">
			<div class="inner">
				<header>
					<h1>내 주위의 유기동물</h1>
				</header>

				<div>
					<img src="resources/images/main.jpg">
				</div>
			</div>
		</div>
	</div>
	<!-- Scripts -->
	<script src="resources/js/jquery.min.js"></script>
	<script src="resources/js/browser.min.js"></script>
	<script src="resources/js/breakpoints.min.js"></script>
	<script src="resources/js/util.js"></script>
	<script src="resources/js/main.js"></script>
</body>
</html>