<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<%--日历插件--%>
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
		<%--layer--%>
		<script type="text/javascript" src="jquery/layer/layer.js"></script>

		<script type="text/javascript">

			//默认情况下取消和保存按钮是隐藏的
			var cancelAndSaveBtnDefault = true;

			$(function(){
				$("#remark").focus(function(){
					if(cancelAndSaveBtnDefault){
						//设置remarkDiv的高度为130px
						$("#remarkDiv").css("height","130px");
						//显示
						$("#cancelAndSaveBtn").show("2000");
						cancelAndSaveBtnDefault = false;
					}
				});

				$("#cancelBtn").click(function(){
					//显示
					$("#cancelAndSaveBtn").hide();
					//设置remarkDiv的高度为130px
					$("#remarkDiv").css("height","90px");
					cancelAndSaveBtnDefault = true;
				});

				$(".remarkDiv").mouseover(function(){
					$(this).children("div").children("div").show();
				});

				$(".remarkDiv").mouseout(function(){
					$(this).children("div").children("div").hide();
				});

				$(".myHref").mouseover(function(){
					$(this).children("span").css("color","red");
				});

				$(".myHref").mouseout(function(){
					$(this).children("span").css("color","#E6E6E6");
				});
			});

		</script>

	</head>
	<body>

		<!-- 修改市场活动备注的模态窗口 -->
		<div class="modal fade" id="editRemarkModal" role="dialog">
			<%-- 备注的id --%>
			<input type="hidden" id="remarkId">
			<div class="modal-dialog" role="document" style="width: 40%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">修改备注</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form">
							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">内容</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="noteContent" mame="notContent"></textarea>
								</div>
							</div>
							<%--id的隐藏域--%>
							<input type="hidden" id="id" name="id">
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 修改市场活动的模态窗口 -->
		<div class="modal fade" id="editActivityModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
					</div>
					<div class="modal-body">

						<form class="form-horizontal" role="form" id="editForm">

							<div class="form-group">
								<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-marketActivityOwner" name="owner">
										<c:forEach items="${userList}" var="user">
											<option value="${user.id}">${user.name}</option>
										</c:forEach>
									</select>
								</div>
								<label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-marketActivityName" name="name">
								</div>
							</div>

							<div class="form-group">
								<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-startTime" name="startDate">
								</div>
								<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-endTime" name="endDate">
								</div>
							</div>

							<div class="form-group">
								<label for="edit-cost" class="col-sm-2 control-label">成本</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-cost" name="cost">
									<%--隐藏域--%>
									<input type="hidden" name="id" id="id" value="${id}">
								</div>
							</div>

							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-describe" name="description"></textarea>
								</div>
							</div>

						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" id="updateActivityModal">更新</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 返回按钮 -->
		<div style="position: relative; top: 35px; left: 10px;">
			<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
		</div>

		<!-- 大标题 -->
		<div style="position: relative; left: 40px; top: -30px;">
			<div class="page-header" id="head">
			</div>
			<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
				<button type="button" class="btn btn-default" data-toggle="modal" onclick="showEditActivityDetailModal()"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
				<button type="button" class="btn btn-danger" onclick="deleteActivityDetail()"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>
		</div>

		<!-- 详细信息 -->
		<div style="position: relative; top: -70px;">
			<div style="position: relative; left: 40px; height: 30px;">
				<div style="width: 300px; color: gray;">所有者</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="owner"></b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="name"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>

			<div style="position: relative; left: 40px; height: 30px; top: 10px;">
				<div style="width: 300px; color: gray;">开始日期</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="startDate"></b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="endDate"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 20px;">
				<div style="width: 300px; color: gray;">成本</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="cost"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 30px;">
				<div style="width: 300px; color: gray;">创建者</div>
				<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="createBy"></b>&nbsp;&nbsp;<small style="font-size: 10px; color: gray;" id="createTime"></small></div>
				<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 40px;">
				<div style="width: 300px; color: gray;">修改者</div>
				<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy"></b>&nbsp;&nbsp;<small style="font-size: 10px; color: gray;" id="editTime"></small></div>
				<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 50px;">
				<div style="width: 300px; color: gray;">描述</div>
				<div style="width: 630px;position: relative; left: 200px; top: -20px;">
					<b id="description">

					</b>
				</div>
				<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
		</div>

		<!-- 备注 -->
		<div style="position: relative; top: 30px; left: 40px;">
			<div class="page-header">
				<h4>备注</h4>
			</div>
			<%--
			<!-- 备注1 -->
			<div class="remarkDiv" style="height: 60px;">
				<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
				<div style="position: relative; top: -40px; left: 40px;" >
					<h5>哎呦！</h5>
					<font color="gray">市场活动</font> <font color="gray">-</font> <b>发传单</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
					<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
						<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
					</div>
				</div>
			</div>
			--%>
			<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
				<form role="form" style="position: relative;top: 10px; left: 10px;">
					<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
					<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
						<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
						<button type="button" class="btn btn-primary" onclick="saveActivityRemark()">保存</button>
					</p>
				</form>
			</div>
		</div>
		<div style="height: 200px;"></div>
		<script>

			refresh();

			function refresh() {
				//异步查询市场活动详情页的数据
				$.get("workbench/activity/selectDetail",{
					//活动id
					"id" : "${id}"
				},function (data) {
					//data:activity
					var activity = data;
					$("#head").html("<h3>市场活动:" + activity.name + " <small>" + activity.startDate + "至" + activity.endDate + "</small></h3>");
					$("#owner").html(activity.owner);
					$("#name").html(activity.name);
					$("#startDate").html(activity.startDate);
					$("#endDate").html(activity.endDate);
					$("#cost").html(activity.cost);
					$("#createBy").html(activity.createBy);
					$("#createTime").html(activity.createTime);
					$("#editBy").html(activity.editBy);
					$("#editTime").html(activity.editTime);
					$("#description").html(activity.description);

					//删除备注div中的所有元素
					$(".remarkDiv").remove();

					//取出市场活动中的市场活动备注
					var activityRemarkList = activity.activityRemarkList;
					//遍历市场活动备注
					for (var i = 0; i < activityRemarkList.length; i++) {
						//第i个市场活动备注
						var remark = activityRemarkList[i];
						$("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
								"\t\t\t\t<img title=\"zhangsan\" src='"+ remark.img +"' style=\"width: 30px; height:30px;\">\n" +
								"\t\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
								"\t\t\t\t\t<h5 id='" + remark.id +"'>" + remark.noteContent +"</h5>\n" +
								"\t\t\t\t\t<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>"+ activity.name +"</b> <small style=\"color: gray;\"> "+ activity.createTime +" 由"+ activity.createBy +"</small>\n" +
								"\t\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
								"\t\t\t\t\t\t<a class=\"myHref\" onclick=\"updateActivityRemark('"+ remark.id +"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
								"\t\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
								"\t\t\t\t\t\t<a class=\"myHref\" onclick=\"deleteActivityRemark('"+ remark.id +"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
								"\t\t\t\t\t</div>\n" +
								"\t\t\t\t</div>\n" +
								"\t\t\t</div>");

						$(".remarkDiv").mouseover(function(){
							$(this).children("div").children("div").show();
						});

						$(".remarkDiv").mouseout(function(){
							$(this).children("div").children("div").hide();
						});

						$(".myHref").mouseover(function(){
							$(this).children("span").css("color","red");
						});

						$(".myHref").mouseout(function(){
							$(this).children("span").css("color","#E6E6E6");
						});
					}

				},"json");
			}

			//异步保存活动备注
			function saveActivityRemark() {
				$.get("workbench/activity/saveActivityRemark", {
					"noteContent": $("#remark").val(),
					"activityId" : "${id}"
				}, function (data) {
					//data:ResultVo
					if (data.resOK) {
						alert(data.message);

						//清空文本域
						$("#remark").val("");

						//刷新数据
						refresh();
					}
				}, "json");
			}

			//异步更新活动备注(准备)
			function updateActivityRemark(id) {
				//将noteContent的值设置到文本中
				var noteContent = $("#"+ id).text();
				$("#noteContent").val(noteContent);

				//将id存入隐藏域中
				$("#id").val(id);

				$("#editRemarkModal").modal('show');
			}

			//异步更新活动备注
			$("#updateRemarkBtn").click(function () {
				$.post("workbench/activity/updateActivityRemark", {
					"noteContent": $("#noteContent").val(),
					"id": $("#id").val()
				}, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);
						$("#editRemarkModal").modal('hide');
						refresh();
					}
				}, "json");
			});

			//异步删除活动备注
			function deleteActivityRemark(id) {
				$.post("workbench/activity/deleteActivityRemark", {
					"id": id
				}, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);
						refresh();
					}
				}, "json");
			}

			(function ($) {
				$.fn.datetimepicker.dates['zh-CN'] = {
					days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
					daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
					daysMin: ["日", "一", "二", "三", "四", "五", "六", "日"],
					months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
					monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
					today: "今天",
					suffix: [],
					meridiem: ["上午", "下午"]
				};
			}(jQuery));

			//异步通过id查询活动
			function showEditActivityDetailModal() {
				$.get("workbench/activity/selectActivityById", {
					"id": "${id}"
				}, function (data) {
						//data:Activity
						var activity = data;
						$("#edit-marketActivityOwner").val(activity.owner);
						$("#edit-marketActivityName").val(activity.name);
						$("#edit-startTime").val(activity.startDate);
						$("#edit-endTime").val(activity.endDate);
						$("#edit-cost").val(activity.cost);
						$("#edit-describe").val(activity.description);

						//展现模态框
						$("#editActivityModal").modal('show');

				}, "json");
			}

			//日历插件
			$("#edit-startTime").datetimepicker({
				language: "zh-CN",
				format: "yyyy-mm-dd",//显示格式
				minView: "month",//设置只显示到月份
				initialDate: new Date(),//初始化当前日期
				autoclose: true,//选中自动关闭
				todayBtn: true, //显示今日按钮
				clearBtn: true,
				pickerPosition: "bottom-left"
			});

			$("#edit-endTime").datetimepicker({
				language: "zh-CN",
				format: "yyyy-mm-dd",//显示格式
				minView: "month",//设置只显示到月份
				initialDate: new Date(),//初始化当前日期
				autoclose: true,//选中自动关闭
				todayBtn: true, //显示今日按钮
				clearBtn: true,
				pickerPosition: "bottom-left"
			});

			//异步更新市场活动
			$("#updateActivityModal").click(function () {
				$.post("workbench/activity/updateActivityModal", $("#editForm").serialize()
					/*"id": "",
					"owner": $("#edit-marketActivityOwner").val(),
					"name": $("#edit-marketActivityName").val(),
					"startDate": $("#edit-startTime").val(),
					"endDate": $("#edit-endTime").val(),
					"cost": $("#edit-cost").val(),
					"description": $("#edit-describe").val()*/
				, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						refresh();

						$("#editActivityModal").modal("hide");
					}
				}, "json");
			});

			//异步删除市场活动
			function deleteActivityDetail() {
				layer.alert('你确定删除这条活动吗？此操作不可逆！', {
					time: 0 //不自动关闭
					,btn: ['删除', '取消']
					,yes: function(index){
						layer.close(index);
						$.post("workbench/activity/deleteActivityDetail", {
							"id": "${id}"
						}, function (data) {
							//data:resultVo
						}, "json");

						//跳转到index.jsp
						location.href = "toView/workbench/activity/index";
					}
				});
			}

		</script>
	</body>
</html>