<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="resources/css/login.css" />
<style type="text/css">
.home{
	width : 100px;
	height : 30px;
	margin : 0 auto;
	border : solid 1px white;
	display: table-cell;
	text-align: center;
	vertical-align: middle;
	cursor:pointer;
}
.home.on{
	border : solid 1px pink;
	color : pink;
}
</style>
<script src="resources/js/jquery.min.js"></script>
<c:if test="${loginResult == false}">
	<script type="text/javascript">
		alert("아이디 또는 비밀번호를 확인해주세요");
	</script>
</c:if>
<script>
$(function(){
	setTimeout(function(){
		$("#email").focus();
	},0);
	$(".home").on("mouseover",function(){
		$(this).addClass("on");
	});
	$(".home").on("mouseout",function(){
		$(this).removeClass("on");
	});
});

function loginValidation() {
	var email = $("#email").val();
	var pw = $("#pw").val();

	if (email.trim().length==0) {
		alert("아이디를 입력해주세요");
		return false;
	}else if (pw.trim().length==0) {
		alert("패스워드를 입력해주세요");
		return false;
	}else{
		return true;
	};
};

function idCheck(){
	var email = $("#email").val();
	var regExp2 =  /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g;
	
	if(regExp2.test(email)){
		$("#email").val("");
	};
}
</script>
</head>
<body>
	<form action="login" method="post" onsubmit="return loginValidation()">
		<div class="vid-container">
			<img class="bgvid" src="resources/images/login.jpg">
			<div class="inner-container">
				<div class="box">
					<h1>Login</h1>
					<input type="text" class="login" id="email" name="email" onkeyup="idCheck()" autocomplete="off" placeholder="Email" /> <input
						type="password" class="login" id="pw" name="pw" autocomplete="off" placeholder="Password" />
					<button>Login</button>
					<p>
						Not a member?
						<a href="signup">
						<span style="color: white; font-weight: bold; text-decoration: underline;">Sign Up</span>
						</a>
					</p>
					<div style="width: 100px; margin: 0 auto;">
						<div class="home" onclick="location.href='./'">
							HOME
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>