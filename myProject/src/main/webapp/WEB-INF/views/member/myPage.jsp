<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/css/main.css" />
<style type="text/css">
	th{
		width: 30%;
	}
	
	#notice1, #notice2{
		color: red;
	    width: 300px;
	    margin-left: 20px;
	    font-size: 14px;
	}
	
	#pwChange{
		width: 70px;
		letter-spacing: 0;
		height: 36px;
	}
	
	#change{
		width: 70px;
		letter-spacing: 0;
		height: 36px;
	}
	
	#cancle{
		width: 70px;
		letter-spacing: 0;
		height: 36px;
	}
	#addressChange{
		width: 70px;
		letter-spacing: 0;
		height: 36px;
	}
	#address{
		display:inline-block;
		margin-right:15px;
		padding-left: 20px;
		height: 36px;
		font-size: 15px;
		width: 300px;
	}
	td{
	font-size: 17px;
}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="resources/js/jquery.min.js"></script>
<script>
$(function(){

	$("#byebye").on("click",function(){
		var check = confirm("회원을 탈퇴하시겠습니까");
		if(check){
			location.href = "byebye?memberno=${requestScope.user.memberno}"
		}
	});
});

function pwCheck(){
	if($("#pwModify").val().trim().length != 0){
		var data = {"pw":$("#pwModify").val()};
		$.ajax({
			type : "POST",
			url : "pwCheck",
			data : data,
			success : function(result){
				if(result == "success"){
					$("#pwModify").prop("readonly",true);
					$("#pwChange").attr("type","hidden");
					var output = '<tr id="forCancle1">';
					output += '<th>변경할 패스워드 입력</th>';
					output += '<td class="tdon"><input type="password" id="changingPw" onkeyup="passwordCheck()" style="width: 300px; display: inline-block; placeholder="변경할 패스워드를 입력해주세요">'
					output += '<div id="notice1" style="color:red;"></div></td>';	
					output += '</tr>';
					output += '<tr id="forCancle2">';
					output += '<th>비밀번호 확인</th>';
					output += '<td class="tdon"><input type="password" id="checkingPw" onkeyup="passwordCheck()" style="width: 300px; display: inline-block; margin-right:18px;">';
					output += '<input type="button" id="change" class="button primary small" style="display: inline-block; margin-right:6px;" value="수  정" disabled/>';
					output += '<input type="button" id="cancle" class="button primary small" style="display: inline-block;" value="취  소"/>';
					output += '<div id="notice2" style="color:red;"></div></td>';
					output += '</tr>';
				
					$("#pwAppend").after(output);
					passwordCheck();
					$("#cancle").on("click",function(){
						cancle();
					});
					$("#change").on("click",function(){
						goModify();
					});
				}else{
					alert("패스워드가 잘못되었습니다");
				}
			},
			error : function(e){
				console.log(e);
			}
		});
	}else{
		alert("현재 비밀번호를 입력해주시기 바랍니다");
	}
}

function passwordCheck(){
	var pw = $("#changingPw").val();
	var pwCheck = $("#checkingPw").val();
	if (pw.trim().length == 0) {
		$("#notice1").text("");
	}else if((pw.trim().length < 4 && pw.trim().length >0) || pw.trim().length > 8){
		$("#notice1").text("4자리 이상 8자리 이하로 입력해주세요");
	}else if(pw.trim().length > 3 && pw.trim().length < 9){
		$("#notice1").text("");
		if(pw != pwCheck && pwCheck == 0){
			$("#notice2").text("");
		}else if(pw != pwCheck && pwCheck != 0){
			$("#notice2").text("패스워드가 맞지 않습니다");
		}else{
			$("#notice2").text("");
			$("#change").prop("disabled",false);
		}
	}
};

function cancle(){
	$("#forCancle1").remove();
	$("#forCancle2").remove();
	$("#pwModify").prop("readonly",false);
	$("#pwChange").attr("type","button");
	$("#pwModify").val("");
}

function goModify(){
	var check = confirm("현재 정보로 수정하시겠습니까");
	var pw = $("#changingPw").val();
	var address = $("#address").val();
	var sido = $("#sido").val();
	var sigungu = $("#sigungu").val();
	var sidocode = $("#sidocode").val();
	var sigungucode = $("#sigungucode").val();
	var data = {
			"pw" : pw,
			"address" : address,
			"sido" : sido,
			"sigungu" : sigungu,
			"sidocode" : sidocode,
			"sigungucode" : sigungucode
			};
	console.log(data)
	if(check){
		$.ajax({
			type : "POST",
			url : "goModify",
			data : data,
			success : function(result){
				if(result == 1){
					alert("회원정보를 수정하였습니다");
				}else{
					alert("회원정보 수정에 실패하였습니다");
				}
			},
			error : function(e){
				console.log(e);
			}
		});
	}
}

function changing(original, change){
	if(original == change){
		$("#notice1").text("기존 비밀번호와 동일합니다.");
		return false;
	}else{
		$("#notice1").text("");
		 return true;
	}
}

function lastCheck(change, check){
	if(change != check){
		$("#notice2").text("입력한 비밀번호와 일치하지 않습니다.");
		return false;
	}else{
		$("#notice2").text("");
		 return true;
	}
}

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

function addressCheck(){
	var address = $("#address").val();

	if(address.trim().length == 0){
		alert("주소를 입력해주세요");
		return false;
	}else{
		return true;
	};
}
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
					<h1>myPage</h1>
				</header>
				
				<div class="inner">
					<div style="text-align: center;">
						<h2>개인정보 수정</h2>
					</div>
					
					<div style="width: 700px; margin: 0 auto;">
						<div id="byebye"style="float: right;">
							<img id="byebye" src="resources/images/byebye.gif" title="회원탈퇴 버튼입니다." style="height: 80px; cursor: pointer;">
						</div>
					</div>
					<div style="width: 700px; margin: 0 auto; height: 600px;">
						<table style="width: 700px; margin: 0 auto;">
							<tr>
								<th>Email</th>
								<td class="tdon">${requestScope.user.email}</td>
							</tr>
							<tr>
								<th>이름</th>
								<td class="tdon">${requestScope.user.username}</td>
							</tr>
							<tr id="pwAppend">
								<th>비밀번호 변경</th>
								<td class="tdon">
								<input type="password"id="pwModify" style="width: 300px; display: inline-block; margin-right: 15px;" placeholder="현재 비밀번호를 입력해주세요">
								<input type="button" id="pwChange" class="button primary small" style="display: inline-block;" onclick="pwCheck()" value="변  경">
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td class="tdon">
									<input type="text" id="address" name="address" autocomplete="off" value="${requestScope.user.address}" readonly="readonly" placeholder="주소">
									<input type="button" id="addressChange" class="button primary small" style="display: inline-block;" onclick="goModify()" value="변  경">
									<input type="hidden" value="${requestScope.user.sido}" id="sido" name="sido">
									<input type="hidden" value="${requestScope.user.sigungu}" id="sigungu" name="sigungu">
		 							<input type="hidden" value="${requestScope.user.sidocode}" id="sidocode" name="sidocode">
									<input type="hidden" value="${requestScope.user.sigungucode}" id="sigungucode" name="sigungucode">
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="inner">
				
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