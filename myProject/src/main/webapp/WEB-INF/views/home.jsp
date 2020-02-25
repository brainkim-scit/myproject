<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="function" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
	<title>First</title>
<style type="text/css">
	body{
		margin: 0;
		width: 1536px;
	}
		
	div#main{
		position: absolute;
		top:100px;
		width:1536px;
		height: 50px;
		background: rgb(9,15,55);
		z-index: 1;
	}
	
	div.right.on{
		position: absolute;
		left: 1281px;
		width: 260px;
		height: 100%;
		background: rgb(9,15,55);
		z-index: 0;
	}
	
	img.homeimg{
		vertical-align: top;
		height: 50px;
	}
	
	div.premenu{
		position: relative;
		left:900px;
		text-align:center;
		width: 50px;
		height: 50px;
		line-height:50px;
		display: inline-block;
	}
	
	div.menu{
		position: relative;
		left:900px;
		text-align:center;
		width: 330px;
		height:50px;
		display: inline-block;
	}
	
	div#menulist{
		position:relative;
		display:inline-block;
		left:890px;
		width:260px;
		height:50px;
		line-height:50px;
		text-align:center;
		color: white;
	}
	
	div.buttonOnMain{
		width: 100px;
		height: 50px;
		line-height:50px;
		color: white;
		cursor: pointer;
		display: inline-block;
		text-align: center;
	}
	div.buttonOnMain:hover{
		background: rgb(41,64,220);
	}
	
	div.buttonOnMain:active{
		opacity: 0.5;
	}
	
	a{
		text-decoration: none;
	}
</style>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script>
$(function(){
	$("#login").on("click",function(){
		location.href = "/login";
	});

	$("#signup").on("click",function(){
		location.href = "/signup";
	});

	$("#mypage").on("click",function(){
		location.href = "/mypage";
	});

	$("#menulist").on("click",function(){
		if($(".right").hasClass("on")){
			$(".right").removeClass("on");
		}else{
			$(".right").addClass("on");
		}
	});
});
</script>
</head>
<body>
	<div id="wrapper">
		<div id="homepage">
		</div>
		<div id="main">
			<div class="premenu">
				<a href="./">
					<img class="homeimg" src='<c:url value="resources/img/preButton.png"/>'>
				</a>
			</div>
			<div class="menu">
				<c:if test="${sessioinScope.id == null}">
					<div id="login" class="buttonOnMain">login</div>
				</c:if>
			
				<c:if test="${sessioinScope.id == null}">
					<div id="signup" class="buttonOnMain">회원가입</div>
				</c:if>
				
				<c:if test="${sessioinScope.id == null}">
					<div id="mypage" class="buttonOnMain">myPage</div>
				</c:if>
			</div>
			<div id="menulist" class="buttonOnMain">
				MENU
			</div>
		</div>
		<div class="right">
<!-- 			<div class="boardmenu"> -->
<!-- 				게시판 메뉴 -->
<!-- 			</div> -->
<!-- 			<div class="bodyMenu"> -->
<!-- 				게시판 나타나도록 -->
<!-- 			</div> -->
		</div>
	</div>
</body>
</html>
