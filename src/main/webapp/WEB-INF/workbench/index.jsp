<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="UTF-8">
		<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
		<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="jquery/layer/layer.js"></script>
		<%--异步上传文件js--%>
		<script type="text/javascript" src="jquery/ajaxfileupload.js"></script>

		<script type="text/javascript">

		//页面加载完毕
		$(function(){

			//导航中所有文本颜色为黑色
			$(".liClass > a").css("color" , "black");

			//默认选中导航菜单中的第一个菜单项
			$(".liClass:first").addClass("active");

			//第一个菜单项的文字变成白色
			$(".liClass:first > a").css("color" , "white");

			//给所有的菜单项注册鼠标单击事件
			$(".liClass").click(function(){
				//移除所有菜单项的激活状态
				$(".liClass").removeClass("active");
				//导航中所有文本颜色为黑色
				$(".liClass > a").css("color" , "black");
				//当前项目被选中
				$(this).addClass("active");
				//当前项目颜色变成白色
				$(this).children("a").css("color","white");
			});


			window.open("main/index.html","workareaFrame");

		});

	</script>
		<style>
			/*上传按钮美化*/
			.a-upload{
				padding: 4px 10px;
				/*height: 34px;*/
				line-height: 28px;
				position: relative;
				cursor: pointer;
				color: #fff;
				background-color: #286090;
				border-color: #204d74;
				border-radius: 4px;
				overflow: hidden;
				display: inline-block;
				*display: inline;
				*zoom: 1;
			}
			.a-upload input{
				position: absolute;
				font-size: 100px;
				right: 0;
				top: 0;
				opacity: 0;
				filter: alpha(opacity=0);
				cursor: pointer
			}
			.a-upload:hover{
				color: #FFFFFF;
				background: #337ab7;
				border-color: #204d74;
				text-decoration: none;
			}
		</style>
	</head>
	<body>
		<!-- 我的资料 -->
		<div class="modal fade" id="myInformation" role="dialog">
			<div class="modal-dialog" role="document" style="width: 30%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">我的资料</h4>
					</div>
					<div class="modal-body">
						<div style="position: relative; left: 40px;">
							姓名：<b>张三</b><br><br>
							登录帐号：<b>zhangsan</b><br><br>
							组织机构：<b>1005，市场部，二级部门</b><br><br>
							邮箱：<b>zhangsan@bjpowernode.com</b><br><br>
							失效时间：<b>2017-02-14 10:10:10</b><br><br>
							允许访问IP：<b>127.0.0.1,192.168.100.2</b>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 修改密码的模态窗口 -->
		<div class="modal fade" id="editPwdModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 70%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">修改密码</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form">

							<%--图片路径的隐藏域--%>
							<input type="hidden" id="img" >


							<div class="form-group">
								<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="oldPwd" name="oldPwd" style="width: 200%;">
								</div>
							</div>

							<div class="form-group">
								<label for="newPwd" class="col-sm-2 control-label">新密码</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="newPwd" name="newPwd" style="width: 200%;">
								</div>
							</div>

							<div class="form-group">
								<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
								</div>
							</div>

							<div class="form-group">
								<label for="confirmPwd" class="col-sm-2 control-label">上传头像</label>
								<a href="javascript:" class="a-upload mr10" style="position: absolute;left: 240px"><input type="file" name="photo" id="photo">点击这里上传文件</a>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<%--更新用户密码--%>
						<button type="button" onclick="updatePwd()" class="btn btn-primary" data-dismiss="modal">更新</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 退出系统的模态窗口 -->
		<div class="modal fade" id="exitModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 30%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">离开</h4>
					</div>
					<div class="modal-body">
						<p>您确定要退出系统吗？</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='/crm/settings/user/logOut';">确定</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 顶部 -->
		<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
			<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
			<div style="position: absolute; top: 15px; right: 15px;">
				<ul>
					<li class="dropdown user-dropdown">

						<%--图片、名字、下拉框--%>
						<c:choose>
							<c:when test="${not empty user.img}">
								<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
									<img src="${user.img}" style="width: 30px;height: 30px;border-radius: 100%">
									${user.name}<span class="caret"></span>
								</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
									<span class="glyphicon glyphicon-user"></span>${user.name}<span class="caret"></span>
								</a>
							</c:otherwise>
						</c:choose>


						<ul class="dropdown-menu">
							<li><a href="settings/index.html"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
							<li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
							<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
							<%--伪脚本--%>
							<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>

		<!-- 中间 -->
		<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">

			<!-- 导航 -->
			<div id="navigation" style="left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;">

				<ul id="no1" class="nav nav-pills nav-stacked">
					<li class="liClass"><a href="main/index.html" target="workareaFrame"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-tag"></span> 动态</a></li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-time"></span> 审批</a></li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 客户公海</a></li>
					<li class="liClass"><a href="activity/index.html" target="workareaFrame"><span class="glyphicon glyphicon-play-circle"></span> 市场活动</a></li>
					<li class="liClass"><a href="clue/index.html" target="workareaFrame"><span class="glyphicon glyphicon-search"></span> 线索（潜在客户）</a></li>
					<li class="liClass"><a href="customer/index.html" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 客户</a></li>
					<li class="liClass"><a href="contacts/index.html" target="workareaFrame"><span class="glyphicon glyphicon-earphone"></span> 联系人</a></li>
					<li class="liClass"><a href="transaction/index.html" target="workareaFrame"><span class="glyphicon glyphicon-usd"></span> 交易（商机）</a></li>
					<li class="liClass"><a href="visit/index.html" target="workareaFrame"><span class="glyphicon glyphicon-phone-alt"></span> 售后回访</a></li>
					<li class="liClass">
						<a href="#no2" class="collapsed" data-toggle="collapse"><span class="glyphicon glyphicon-stats"></span> 统计图表</a>
						<ul id="no2" class="nav nav-pills nav-stacked collapse">
							<li class="liClass"><a href="chart/activity/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-chevron-right"></span> 市场活动统计图表</a></li>
							<li class="liClass"><a href="chart/clue/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-chevron-right"></span> 线索统计图表</a></li>
							<li class="liClass"><a href="chart/customerAndContacts/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-chevron-right"></span> 客户和联系人统计图表</a></li>
							<li class="liClass"><a href="chart/transaction/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-chevron-right"></span> 交易统计图表</a></li>
						</ul>
					</li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-file"></span> 报表</a></li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-shopping-cart"></span> 销售订单</a></li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-send"></span> 发货单</a></li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-earphone"></span> 跟进</a></li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-leaf"></span> 产品</a></li>
					<li class="liClass"><a href="javascript:void(0);" target="workareaFrame"><span class="glyphicon glyphicon-usd"></span> 报价</a></li>
				</ul>

				<!-- 分割线 -->
				<div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
			</div>

			<!-- 工作区 -->
			<div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
				<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
			</div>

		</div>

		<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>

		<!-- 底部 -->
		<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>


		<script>

			//校验用户输入原始密码是否正确 focus
			$('#oldPwd').blur(function () {
				$.post("settings/user/verifyOldPwd", {
					"oldPwd": $(this).val()
				}, function (data) {
					if (!data.resOK) {
						layer.alert(data.message, {icon: 5});
					}
				}, "json");
			});

			//验证两次输入密码是否一致
			$("#confirmPwd").blur(function () {
				if ($(this).val() !== $("#newPwd").val()) {
					$("#newPwd").val = "";
					layer.alert("两次输入密码不一致", {icon: 5});
				}
			});

			//异步上传文件
			$('#photo').change(function () {
				$.ajaxFileUpload({
							url: 'settings/user/fileUpload', //用于文件上传的服务器端请求地址
							fileElementId: 'photo', //文件上传域的ID
							dataType: 'json', //返回值类型 一般设置为json
							success: function (data, status) {
								if (data.resOK) {
									$("#img").val(data.t);
									//上传文件成功
									layer.alert(data.message, {icon: 6});
								} else {
									//上传文件失败
									layer.alert(data.message, {icon: 5});
								}
							}
						}
				);
				return false;
			});

			//更新用户密码
			function updatePwd() {
				$.post("workbench/settings/user/updatePwd", {
					//在js中获取el表达式中的值
					"id": "${sessionScope.user.id}",
					"loginPwd": $("#newPwd").val(),
					"img": $("#img").val()
				}, function (data) {
					if (data.resOK) {
						//用户操作成功
						layer.alert(data.message, {icon: 6});
					}
				}, "json");
			}
		</script>
	</body>
</html>