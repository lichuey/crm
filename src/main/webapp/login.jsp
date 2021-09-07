<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/layer/layer.js"></script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="${pageContext.request.contextPath}/image/IMG_7114.JPG" style="width: 100%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2020&nbsp;动力节点</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.html" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<%--用户名--%>
					<div style="width: 350px;">
						<input class="form-control" id="loginAct" autofocus type="text" placeholder="用户名">
					</div>
					<%--密码--%>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" id="loginPwd" type="password" placeholder="密码">
					</div>
					<%--图片验证码--%>
					<div style="width: 350px; position: relative;top: 40px;">
						<input id="inputCode" class="form-control" type="text" placeholder="请输入验证码" style="width: 220px">
						<%--cursor:pointer 鼠标放上显示手指状--%>
						<img src="/crm/code"  id="code" onclick="changeCode()" alt="无法显示图片" style="cursor:pointer; width:120px; height:40px; position: absolute; right: 0; top: 0;" >
					</div>
					<%--回显消息--%>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
							<span id="msg">${message}</span>
					</div>
					<button type="button" onclick="login()" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	<%--点击图片改变验证码--%>
	function changeCode() {
		//attr:attribute 操作自定义属性 prop:操作固有属性
		$("#code").prop("src", "/crm/code?time=" + new Date().getTime());
	}
	<%--登录--%>
	function login() {
		$.post("/crm/settings/user/login", {
			'loginAct': $("#loginAct").val(),
			'loginPwd': $("#loginPwd").val(),
			'code': $("#inputCode").val()
		}, function (data) {
			if (!data.resOK) {
				layer.alert(data.message, {icon: 5});
			} else {
				location.href = "/crm/settings/user/toIndex";
			}
		}, 'json');
	}
	<%--使用回车登录--%>
	$("body").keypress(function (event) {
		if (event.keyCode == 13) {
			$.post("/crm/settings/user/login", {
				'loginAct': $("#loginAct").val(),
				'loginPwd': $("#loginPwd").val(),
				'code': $("#inputCode").val()
			}, function (data) {
				if (!data.resOK) {
					layer.alert(data.message, {icon: 5});
				} else {
					location.href = "/crm/settings/user/toIndex";
				}
			}, 'json');
		}
	})

</script>
</html>