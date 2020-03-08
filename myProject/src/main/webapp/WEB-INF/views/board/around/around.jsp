<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Around me</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="resources/css/main.css" />
		<script src="resources/js/jquery.min.js"></script>
		<script>
		</script>
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<div class="inner">
							<!-- Nav -->
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
								<h1>Abandoned Animals around me</h1>
							</header>
							<section class="tiles">
								<article class="style1">
											<h2>강아지</h2>
									<span class="image">
										<img src="resources/images/dog.png" alt="" />
									</span>
									<a href="aroundDog">
										<div class="content">
											<p>강아지들 만나러 갑니다</p>
										</div>
									</a>
								</article>
								<article class="style2">
											<h2>고양이</h2>
									<span class="image">
										<img src="resources/images/cat.jpg" alt="" />
									</span>
									<a href="aroundCat">
										<div class="content">
											<p>고양이들 만나러 갑니다</p>
										</div>
									</a>
								</article>
								<article class="style3">
											<h2>그 외</h2>
									<span class="image">
										<img src="resources/images/etc.jpeg" alt="" />
									</span>
									<a href="aroundEtc">
										<div class="content">
											<p>그 외 동물들 만나러 갑니다</p>
										</div>
									</a>
								</article>
							</section>
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