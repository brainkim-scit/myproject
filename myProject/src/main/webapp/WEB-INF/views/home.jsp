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
	}
	div#main{
		position: absolute;
		top:100px;
		width:100%;
		height: 50px;
		background: rgb(9,15,55);
		z-index: 1;
	}

	div#top{
		position: absolute;
		top:150px;
		border-top: solid rgb(9,15,55) 50px;
		border-left: solid rgb(9,15,55) 50px;
		border-bottom: solid white 50px;
		border-right: solid white 50px;
		z-index: 0;
	}
	
	div#right{
		position: absolute;
		width: 200px;
		height: 100%;
		left: 87%;
		background: rgb(9,15,55);
		z-index: 2;
	}
	
	div.menuWrapper{
		position: relative;
		text-align:center;
		width: 350px;
		float: left;
		left: 65%;
	}
	
	div.preMenu{
		position: relative;
		text-align: center;
		width: 70px;
		display: inline-block;
		top: 10px;
	}
	
	div.menu{
		position: relative;
		text-align:center;
		width:260px;
		display: inline-block;
		bottom: 10px;
	}
	
	div.boardmenu{
		position:relative;
		top: 100px;
		width:200px;
		height: 50px;
		background: yellow;
	}
	
	div.bodyMenu{
		position:relative;
		top: 200px;
		width:200px;
		height: 400px;
		background: yellow;
	}
	
	img#preButton{
		position:relative;
		bottom: 5px;
		height: 40px;
	}
	
	button.buttonOnMain{
		border: none;
		width: 70px;
		height: 30px;
		border-radius: 50px;
		cursor: pointer;
		margin-right: 10px;
	}
	button.buttonOnMain:hover{
		background: rgb(41,64,220);
	}
	
	button.buttonOnMain:active{
		opacity: 0.5;
	}
	
	button.buttonOnMain:focus {
		outline: none;
	}
	
	a{
		text-decoration: none;
	}
</style>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<script>
$(function(){
});
</script>
</head>
<body>
	<div id="wrapper">
		<div id="homepage">
		</div>
		<div id="main">
		<div class="menuWrapper">
				<div class="preMenu">
					<a href="./">
						<img id="preButton" src='<c:url value="resources/img/preButton.png"/>'>
					</a>
				</div>
				
				<div class="menu">
					<c:if test="${sessioinScope.id == null}">
						<a href="login">
							<button class="buttonOnMain">login</button>
						</a>
					</c:if>
				
					<c:if test="${sessioinScope.id == null}">
						<a href="signup">
							<button class="buttonOnMain">회원가입</button>
						</a>
					</c:if>
				
					<c:if test="${sessioinScope.id != null}">
						<a href="mypage">
							<button class="buttonOnMain">myPage</button>
						</a>
					</c:if>
				</div>
			</div>
		</div>
		<div id="top"></div>
		<div id="right">
			<div class="boardmenu">
				게시판 메뉴
			</div>
			<div class="bodyMenu">
				게시판 나타나도록
			</div>
		</div>
	</div>
</body>
</html>
