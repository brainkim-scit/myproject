<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	$mainFont: 'Lora', serif
$mainColor: #ff4242

body 
	background-color: $mainColor
	font-family: $mainFont

h2
	text-align: center
	color: #fff
	font-size: 40px
	font-family: $mainFont
	font-weight: 700
	margin-top: 60px
	text-shadow: 0 5px 8px rgba(0,0,0,.25)

	span
		font-weight: 400

.pagination
	position: absolute
	left: 50%
	top: 50%
	transform: translate(-50%,-50%)
	margin: 0
	padding: 10px
	background-color: #fff
	border-radius: 40px
	box-shadow: 0 5px 25px 0 rgba(0,0,0,.5)

	li
		display: inline-block
		list-style: none

		a
			display: block
			width: 40px
			height: 40px
			line-height: 40px
			background-color: #fff
			text-align: center
			text-decoration: none
			color: #252525
			border-radius: 4px
			margin: 5px
			box-shadow: inset 0 5px 10px rgba(0,0,0,.1), 0 2px 5px rgba(0,0,0,.5)
			transition: all .3s ease
			&:hover,
			&.active
				color: #fff
				background-color: $mainColor
			
		&:first-child
			a
				border-radius: 40px 0 0 40px
		&:last-child
			a
				border-radius: 0 40px 40px 0

</style>
</head>
<body>
	<!-- Heading -->
<h2><span>Roundie</span> Pagination</h2>

<!-- Start Pagination -->
<ul class="pagination">
	<li><a href="#0">&lt;</a></li>
	<li><a class="active" href="#0">1</a></li>
	<li><a href="#0">2</a></li>
	<li><a href="#0">3</a></li>
	<li><a href="#0">4</a></li>
	<li><a href="#0">&gt;</a></li>
</ul>
<!-- End Pagination -->
</body>
</html>