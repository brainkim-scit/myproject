<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignUp</title>
<style type="text/css">
	.notice{
		width:100%;
		color: rgb(250,199,200);
		font-size: 12px;
	}
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
<c:if test="${signupResult == false}">
	<script type="text/javascript">
		alert("회원가입에 실패하였습니다.");
	</script>
</c:if>
<link rel="stylesheet" href="resources/css/login.css" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="resources/js/jquery.min.js"></script>
<script>
$(function(){
	setTimeout(function(){
		$("#email").focus();
	},0);
	$("#address").on("focus",function(){
		address();
		$(this).blur();
	});
	$(".home").on("mouseover",function(){
		$(this).addClass("on");
	});
	$(".home").on("mouseout",function(){
		$(this).removeClass("on");
	});
});

// API 데이터 처리
/////////////////////////////////////////////

//주소 입력
function address(){
	new daum.Postcode({
		oncomplete : function(data) {
			console.log(data);
			$("#address").val(data.address);
			var sido = $("#sido").val(data.sido);
			var sigungu = $("#sigungu").val(data.sigungu);
			sidocode(sido,sigungu);
			
			console.log(
					"주소 : "+$("#address").val()+" "+
					"시도 : "+$("#sido").val()+" "+
					"시군구 : "+$("#sigungu").val()
					);
		}
	}).open();
};

//시도 코드
function sidocode(sido,sigungu){
	$.ajax({
		type : "GET",
		url : "sido",
		success : function(result){
			var parse = JSON.parse(result);
			var sidoArr = parse.response.body.items.item;
			var sidoInput = sido.val();
			var sigunguInput = sigungu.val();
			
			console.log("찾는 시도 : "+sido.val());
			console.log(sidoArr);
			
			$.each(sidoArr,function(index,item){
				if(item.orgdownNm.indexOf(sidoInput) != -1){
					console.log("시도코드 입력 : "+item.orgCd)
					console.log("시군구 메소드로 입력 : "+item.orgCd);
					
					$("#sidocode").val(item.orgCd);
					sigungucode(item.orgCd,sigunguInput);
					return;
				}
			});
		},
		error : function(e){
			console.log("시도코드 에러");
			console.log(e);
		}
	});
}

//시군구 코드
function sigungucode(sidocode,sigunguInput){
	var data = {"sidocode":sidocode};
	$.ajax({
		type : "GET",
		url : "sigungu",
		data : data,
		success : function(result){
			var parse = JSON.parse(result);
			var sigunguArr = parse.response.body.items.item;

			console.log("찾는 시군구 : "+sigunguInput);
			console.log(sigunguArr);

			$.each(sigunguArr, function(indes,item){
				if(item.orgdownNm.indexOf(sigunguInput) != -1){
					console.log("시군구 코드로 입력 : "+item.orgCd);
					
					$("#sigungucode").val(item.orgCd);
					return;
				}
			});
			
		},
		error : function(e){
			console.log("시군구 코드 에러");
			console.log(e);
		}
	});
}

// 유효성 검사
/////////////////////////////////////////////

function idCheckResult(){
	var data = {"email":$("#email").val()};
	var check = "";
	$.ajax({
		type : "GET",
		url : "idCheck",
		data : data,
		async : false,
		success : function(result){
					if(result == "yes"){
						console.log("존재하는 아이디");
						check = result;
					}else if(result == "no"){
						console.log("없는 아이디");
						check = result;
					}
				},
		error : function(e){
				console.log("아이디 중복확인 에러");
				console.log(e);
		}
	});
	return check;
};

function signupValidation() {
	if (!idCheck()) {
		return false;
	}else if(!nameCheck()){
		return false;
	}else if (!passwordCheck()) {
		return false;
	}else if(!addressCheck()){
		return false;
	}else{
		return true;
	};
};

function idCheck(result){
	var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var regExp2 =  /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g;
	var email = $("#email").val();
	
	if (email.trim().length == 0) {
		$("#idCheckNotice").text("");
		return false;
	}else if(!regExp.test(email)){
		$("#idCheckNotice").text("올바른 형식으로 입력해주세요");
		return false;
	}else if(idCheckResult()=="yes"){
		$("#idCheckNotice").text("이미 가입된 아이디입니다");
		return false;
	}else{
		$("#idCheckNotice").text("");
		return true;
	};
};

function passwordCheck(){
	var pw = $("#pw").val();
	var pwCheck = $("#pwCheck").val();

	if ((pw.trim().length < 5 && pw.trim().length >0) || pw.trim().length > 8) {
		$("#pwCheckNotice").text("4자리 이상 8자리 이하로 입력해주세요");
		return false;
	}else if(pw.trim().length == 0){
		$("#pwCheckNotice").text("");
		return false;
	}else if(pw != pwCheck && pwCheck != 0){
		$("#pwCheckNotice").text("패스워드가 맞지 않습니다");
		return false;
	}else{
		$("#pwCheckNotice").text("");
		return true;
	};
};

function nameCheck(){
	var regExp = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
	var username = $("#username").val();

	if(!regExp.test(username) && username.trim().length != 0){
		$("#nameCheckNotice").text("잘못된 입력입니다");
		return false;
	}else if(username.trim().length == 0){
		$("#nameCheckNotice").text("");
		return false;
	}else{
		$("#nameCheckNotice").text("");
		return true;
	};
};

function addressCheck(){
	var address = $("#address").val();

	if(address.trim().length == 0){
		alert("주소를 입력해주세요");
		return false;
	}else{
		return true;
	};
};
</script>
</head>
<body>
	<form action="signup" method="post" onsubmit="return signupValidation()">
		<div class="vid-container">
			<img class="bgvid" src="resources/images/login.jpg">
			<div class="inner-container-signup">
				<div class="box">
					<h1>Sign Up</h1>
					<input type="text" id="email" class="signup1" name="email" autocomplete="off" onkeyup="idCheck()" placeholder="아이디 : example@gmail.com" />
					<span id="idCheckNotice" class="notice"></span>
					
					<input type="text" id="username" class="signup1" name="username" autocomplete="off" onkeyup="nameCheck()" placeholder="이름을 입력해주세요" />
					<span id="nameCheckNotice" class="notice"></span>
					
					<input type="password" id="pw" class="signup1" name="pw" autocomplete="off" onkeyup="passwordCheck()" placeholder="패스워드 : 4자리 이상 8자리 이하로 입력해주세요" />
					<input type="password" id="pwCheck" class="signup1" name="pwCheck" autocomplete="off" onkeyup="passwordCheck()" placeholder="비밀번호 중복체크를 해주세요" />
					<span id="pwCheckNotice" class="notice"></span>
					
					<input type="text" id="address" class="signup1" name="address" autocomplete="off" onkeyup="addressCheck()" placeholder="주소">
					<input type="hidden" id="sido" name="sido">
					<input type="hidden" id="sigungu" name="sigungu">
					<input type="hidden" id="sidocode" name="sidocode">
					<input type="hidden" id="sigungucode" name="sigungucode">
					<button type="submit">Sign Up</button>
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