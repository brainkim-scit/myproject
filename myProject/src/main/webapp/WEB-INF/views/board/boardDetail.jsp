<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Details of Abandoned Animal</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/css/main.css" />
<style type="text/css">
td{
	text-align: center;
	font-size: 17px;
}

.photo {
	width: 450px;
	height: 340px;
}

#popfile {
	width: 450px;
	margin:0 auto;
	padding-bottom: 50px;
}
</style>
<script src="resources/js/jquery.min.js"></script>
<script>
	$(function(){
		replyList();
		savedCheck();
		$("#replyInsert").on("click",function(){
			if($("#replyContent").val().trim().length != 0){
				var content = $("#replyContent").val();
				replyInsert(content);
			}else{
				alert("내용을 입력해주세요");
			}
		});

		$(".small button modify").on("click",function(){
			if($("#replyContent").val().trim().length != 0){
				var content = $("#replyContent").val();
				replyInsert(content);
			}else{
				alert("내용을 입력해주세요");
			}
		});

		$("#take").on("click",function(){
			if($(this).attr("data-text") == "no"){
				var check = confirm("관심 등록을 하시겠습니까");
				if(check){
					myAnimalSend();
					savedCheck();
				};
			}else if($(this).attr("data-text") == "yes"){
				var check = confirm("관심 등록을 해제 하시겠습니까");
				if(check){
					myAnimalDelete();
					savedCheck();
				};
			};
		});
	});

	function savedCheck(){
		var data = {"desertionNo":"${requestScope.vo.desertionNo}"};
		$.ajax({
			type : "GET",
			url : "savedCheck",
			data : data,
			success : function(result){
				console.log("존재여부 : "+result);
				if(result == 1){
					$(".take").addClass("on").attr("data-text","yes");
				}else{
					$(".take").removeClass("on").attr("data-text","no");
				}
			},
			error : function(e){
				console.log(e);
			}
		});
	}

	function myAnimalDelete(){
		var data = {"desertionNo":"${requestScope.vo.desertionNo}"};
		$.ajax({
			type : "POST",
			url : "myAnimalDelete",
			data : data,
			success : function(result){
				if(result == 1){
					alert("관심 등록이 해제되었습니다");
				}else{
					alert("해제 실패");
				}
			},
			error : function(e){
				console.log(e);
			}
		});
	}

	function myAnimalSend(){
		var data = {
					"desertionNo":"${requestScope.vo.desertionNo}",
					"age":"${requestScope.vo.age}",
					"careAddr":"${requestScope.vo.careAddr}",
					"careNm":"${requestScope.vo.careNm}",
					"careTel":"${requestScope.vo.careTel}",
					"colorCd":"${requestScope.vo.colorCd}",
					"happenDt":"${requestScope.vo.happenDt}",
					"happenPlace":"${requestScope.vo.happenPlace}",
					"kindCd":"${requestScope.vo.kindCd}",
					"processState":"${requestScope.vo.processState}",
					"sexCd":"${requestScope.vo.sexCd}",
					"specialMark":"${requestScope.vo.specialMark}",
					"weight":"${requestScope.vo.weight}",
					"neuterYn":"${requestScope.vo.neuterYn}",
					"popfile":"${requestScope.vo.popfile}",
					};
		$.ajax({
			type : "POST",
			url : "myAnimalSend",
			data : data,
			success : function(result){
				if(result == 1){
					alert("등록이 완료되었습니다");
				}else{
					alert("등록실패");
				};
			},
			error : function(e){
				console.log("관심등록 에러");
				console.log(JSON.parse(e));
			}
		});
	}

	function replyList(currentPage){
		var desertionNo = "${requestScope.vo.desertionNo}";
		var data = {
					"desertionNo" : desertionNo,
					"currentPage" : currentPage
					};

		$.ajax({
			type : "GET",
			url : "animalReplyList",
			data : data,
			success : function(map){
				var output = '<table>';

				if(map.list.length != 0){
					$.each(map.list, function(index,item){
						output += '<tr>';
						output += '<td style="border-left: solid 1px #c9c9c9; width:79%; height: 130px; text-align: left;">';
						output += '<span style="font-weight: bold;">'+item.username+'</span><br>';
						output += '<span>'+item.replyContent+'</span><br>';
						output += '<span>'+item.replyDate+'</span></td>';
						output += '<td style="border-right: solid 1px #c9c9c9;">';
						output += '<div id="actions" style="display: inline-block;">';
		
						if("${sessionScope.loginId}" == item.email){
							output += '<input type="button" class="small button modify" data-num="'+item.animalReplyNum+'" data-text="'+item.replyContent+'" style="margin-right: 15px;" value="Modify">';
							output += '<input type="button" data-num="'+item.animalReplyNum+'" class="small button delete" value="Delete">';
						}
						output += '</div></td></tr>';
					});

				}else{
					output += '<tr>';
					output += '<td style="border-left: solid 1px #c9c9c9; width:79%; height: 130px; text-align: left;">';
					output += '<p>등록된 댓글이 없습니다.</p>';
					output += '<td style="border-right: solid 1px #c9c9c9;">';
					output += '<div id="actions" style="display: inline-block; float: right;">';
					output += '</div></td></tr>';
				};

				output += '</table>';
				$("#replyList").html(output);

				paging(map);
				replyDelete(currentPage);
				replyModify(currentPage);
			},
			error : function(e){
				console.log("내 구역 동물 댓글 리스트 에러 : "+e)
			}
		});
	}

	function paging(map){
		var pageno = '<a href="javascript:replyList('+(map.navi.currentPage-5)+')" class="icon brands style2">'+'◁'+'</a>';
			pageno += '<a href="javascript:replyList('+(map.navi.currentPage-1)+')" class="icon brands style2">'+'◀'+'</a>';
		for(var page = map.navi.startPageGroup; page<=map.navi.endPageGroup; page++){
			if(page == map.navi.currentPage){
				pageno += '<div class="currentPage">'+page+'</div>';
			}else{
				pageno += '<a href="javascript:replyList('+page+')" class="icon brands style2">'+page+'</a>';
			}
		};
		pageno += '<a href="javascript:replyList('+(map.navi.currentPage+1)+')" class="icon brands style2">'+'▶'+'</a>';
		pageno += '<a href="javascript:replyList('+(map.navi.currentPage+5)+')" class="icon brands style2">'+'▷'+'</a>';
		
		$("#paging").html(pageno);
	};

	function replyInsert(content){
		var replyContent = content;
		var desertionNo = "${requestScope.vo.desertionNo}";
		var data = {
					"replyContent" : replyContent,
					"desertionNo" : desertionNo
					};

		$.ajax({
			type : "POST",
			url : "insertAnimalReply",
			data : data,
			success : function(result){
				if(result == 1){
					replyList();
					$("#replyContent").val("");
				}else{
					alert("댓글 입력 실패!");
				};
			},
			error : function(e){
				console.log("내 구역 동물 댓글 입력 에러 : "+e)
			},
		});
	}

	function replyDelete(currentPage){
		$(".delete").on("click",function(){
			var check = confirm("댓글을 삭제하시겠습니까");
			var animalReplyNum = $(this).attr("data-num");
			var data = {"animalReplyNum" : animalReplyNum}
			if(check){
				$.ajax({
					type : "POST",
					url : "deleteAnimalReply",
					data : data,
					success : function(result){
						if(result == 1){
							replyList(currentPage);
						}else{
							alert("삭제 실패");
						};
					},
					error : function(e){
						console.log("삭제 에러");
						console.log(JSON.Stringify(e));
					}
				});
			}
		});
	}

	function replyModify(currentPage){
		$(".modify").on("click",function(){
			moveTo();
			$("#replyInsert").attr("type","hidden");
			$("#replyModify").attr("type","button");
			$("#modifyCancle").attr("type","button");
			$(".delete").attr("type","hidden");
			$(".modify").attr("type","hidden");
			var content = $(this).attr("data-text");
			$("#replyContent").val(content);
			var animalReplyNum = $(this).attr("data-num");
			
			$("#modifyCancle").on("click",function(){
				initModify();
			});

			$("#replyModify").on("click",function(){
				var modifyContent = "";

				if($("#replyContent").val().trim().length == 0){
					modifyContent = content;
				}else{
					modifyContent = $("#replyContent").val();
				}
			
				var check = confirm("댓글을 수정하시겠습니까");
				var data = {
							"animalReplyNum" : animalReplyNum,
							"replyContent" : modifyContent
							}
				if(check){
					$.ajax({
						type : "POST",
						url : "modifyAnimalReply",
						data : data,
						success : function(result){
							if(result == 1){
								replyList(currentPage);
								initModify();
							}else{
								alert("수정 실패");
							};
						},
						error : function(e){
							console.log("수정 에러");
							console.log(JSON.Stringify(e));
						}
					});
				}
			})
		});
	}

	function moveTo(){
		var offset = $("#replyContent").offset();
		var winH = $(window).height();
		$("html, body").animate({scrollTop : offset.top - winH/2}, 100);
	}

	function initModify(){
		$("#replyInsert").attr("type","button");
		$("#replyModify").attr("type","hidden");
		$("#modifyCancle").attr("type","hidden");
		$(".delete").attr("type","button");
		$(".modify").attr("type","button");
		$("#replyContent").val("");
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
			<div class="inner" style="height: 1050px;">
				<h1>About</h1>
				
				<div style="width: 100%; height: 53px;">
					<c:if test="${requestScope.vo.insertDate != null}">
						<h3 style="display: inline-block;">${requestScope.vo.insertDate}에 관심 등록 하였습니다.</h3>
					</c:if>
					<div id="take" class="take" style="float: right; font-size: 20px; font-weight: bold;">♥</div>
					<a href="${requestScope.fromWhere}">
						<div id="back" class="back" style="float: right; font-size: 20px; font-weight: bold; width: 100px; margin-right: 20px;">Back</div>
					</a>
				</div>
				<div>
					<div style="width: 600px; height:900px; float: left;">
						<h2>Details</h2>
						<table>
							<tr>
								<th style="width: 30%;">발견날짜</th>
								<td>${requestScope.vo.happenDt}</td>
							</tr>
							<tr>
								<th>발견장소</th>
								<td>${requestScope.vo.happenPlace}</td>
							</tr>
							<tr>
								<th>나이</th>
								<td>${requestScope.vo.age}</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>${requestScope.vo.sexCd}</td>
							</tr>
							<tr>
								<th>품종</th>
								<td>${requestScope.vo.kindCd}</td>
							</tr>
							<tr>
								<th>색상</th>
								<td>${requestScope.vo.colorCd}</td>
							</tr>
							<tr>
								<th>체중</th>
								<td>${requestScope.vo.weight}</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>${requestScope.vo.processState}</td>
							</tr>
							<tr>
								<th>중성화여부</th>
								<td>${requestScope.vo.neuterYn}</td>
							</tr>
							<tr>
								<th>특징</th>
								<td>${requestScope.vo.specialMark}</td>
							</tr>
							<tr>
								<th>보호소 이름</th>
								<td>${requestScope.vo.careNm}</td>
							</tr>
							<tr>
								<th>보호소 전화번호</th>
								<td>${requestScope.vo.careTel}</td>
							</tr>
							<tr>
								<th>보호소 주소</th>
								<td>${requestScope.vo.careAddr}</td>
							</tr>
						</table>
					</div>
					<div style="width: 550px; height:900px; float: right;">
						<h2>Picture</h2>
						<div id="popfile">
							<img class="photo" src="${requestScope.vo.popfile}">
						</div>
						<h2>Reply</h2>
						<div id="reply" style="padding: 10px; text-align: center;">
							<textarea id="replyContent" rows="6" cols="20" placeholder="  댓글을 남겨주세요"></textarea>
							<input type="button" id="replyInsert" class="actions button primary" style="margin-top: 20px;" value="댓글등록"/>
							<input type="hidden" id="replyModify" class="actions button primary" style="margin-top: 20px;" value="댓글수정"/>
							<input type="hidden" id="modifyCancle" class="actions button primary" style="margin-top: 20px;" value="수정취소"/>
						</div>
					</div>
				</div>
			</div>
			<div id="replyList" class="inner">
			
			</div>
			<div id="paging" class="inner" style="text-align: center;">
			
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