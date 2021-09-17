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
		
		
		<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
		<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
		
		<script type="text/javascript">
			$(function(){
				$("#isCreateTransaction").click(function(){
					if(this.checked){
						$("#create-transaction2").show(200);
					}else{
						$("#create-transaction2").hide(200);
					}
				});
			});
		</script>
	
	</head>
	<body>
		
		<!-- 搜索市场活动的模态窗口 -->
		<div class="modal fade" id="searchActivityModal" role="dialog" >
			<div class="modal-dialog" role="document" style="width: 90%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">搜索市场活动</h4>
					</div>
					<div class="modal-body">
						<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
							  <div class="form-group has-feedback">
								<input type="text" id="press" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
								<span class="glyphicon glyphicon-search form-control-feedback"></span>
							  </div>
						</div>
						<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
							<thead>
								<tr style="color: #B3B3B3;">
									<td></td>
									<td>名称</td>
									<td>开始日期</td>
									<td>结束日期</td>
									<td>所有者</td>
									<td></td>
								</tr>
							</thead>
							<tbody id="activityModelTbody">
								<%--<tr>
									<td><input type="radio" name="activity"/></td>
									<td>发传单</td>
									<td>2020-10-10</td>
									<td>2020-10-20</td>
									<td>zhangsan</td>
								</tr>--%>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" onclick="bind()" class="btn btn-primary" data-dismiss="modal">关联</button>
					</div>
				</div>
			</div>
		</div>
	
		<div id="title" class="page-header" style="position: relative; left: 20px;">
			<h4>转换线索 <small id="small"></small></h4>
		</div>
		<div id="create-customer" style="position: relative; left: 40px; height: 35px;">

		</div>
		<div id="create-contact" style="position: relative; left: 40px; height: 35px;">

		</div>
		<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
			<input type="checkbox" id="isCreateTransaction" value="0"/>
			为客户创建交易
		</div>
		<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >
		
			<form>
			  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
				<label for="amountOfMoney">金额</label>
				<input type="text" class="form-control" id="amountOfMoney">
			  </div>
			  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
				<label for="tradeName">交易名称</label>
				<input type="text" class="form-control" id="tradeName">
			  </div>
			  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
				<label for="expectedClosingDate">预计成交日期</label>
				<input type="text" class="form-control" id="expectedClosingDate">
			  </div>
			  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
				<label for="stage">阶段</label>
				<select id="stage"  class="form-control">
					<option></option>
					<c:forEach items="${map['stage']}" var="stage">
						<option value="${stage.value}">${stage.text}</option>
					</c:forEach>
				</select>
			  </div>
			  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
				  <%--市场活动的隐藏域--%>
				  <input type="hidden" id="activityId">
				<label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#searchActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
				<input type="text" class="form-control" id="activity" placeholder="点击上面搜索" readonly>
			  </div>
			</form>
			
		</div>
		
		<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
			记录的所有者：<br>
			<b id="b"></b>
		</div>
		<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
			<input class="btn btn-primary" type="button" onclick="convert()" value="转换">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="btn btn-default" type="button" value="取消">
		</div>
	</body>
	<script>

		//通过id查询clue
		$.get("workbench/clue/selectClueById", {
			"id": "${id}"
		}, function (data) {
			//data:clue
			var clue = data;
			$("#small").text(clue.fullname + clue.appellation + "-" + clue.company);
			$("#create-customer").text("新建客户：" + clue.company);
			$("#create-contact").text("新建联系人：" + clue.fullname + clue.appellation);
			$("#b").text(clue.owner);

		}, "json");

		//线索转换
		function convert() {
			$.post("workbench/clue/convert", {
				"id": "${id}",
				"isCreateTransaction": $("#isCreateTransaction").val(),
				"money": $("#amountOfMoney").val(),
				"name": $("#tradeName").val(),
				"expectedDate": $("#expectedClosingDate").val(),
				"stage": $("#stage").val(),
				"activityId": $("#activityId").val()
			}, function (data) {
				//data:resultVo
				if (data.resOK) {
					alert(data.message);
				}
			}, "json");
		}

		//按压展现线索关联的活动
		$("#press").keypress(function (event) {
			if (event.keyCode == 13) {
				$.get("workbench/clue/selectBindActivity", {
					"id": "${id}",
					"name": $(this).val()
				}, function (data) {
					//清空
					$("#activityModelTbody").html("");
					//data:List<Activity>
					var activityList = data;
					for (var i = 0; i < activityList.length; i++) {
						var activity = activityList[i];
						$("#activityModelTbody").append("<tr>\n" +
								"\t\t\t\t\t\t\t\t\t<td><input type=\"radio\" class='son' value='"+ activity.id +"' name=\"activity\"/></td>\n" +
								"\t\t\t\t\t\t\t\t\t<td>" + activity.name + "</td>\n" +
								"\t\t\t\t\t\t\t\t\t<td>" + activity.startDate + "</td>\n" +
								"\t\t\t\t\t\t\t\t\t<td>" + activity.endDate + "</td>\n" +
								"\t\t\t\t\t\t\t\t\t<td>" + activity.owner + "</td>\n" +
								"\t\t\t\t\t\t\t\t</tr>");
					}
				}, "json");

			}
		});

		//判断是否有交易
		$("#isCreateTransaction").click(function () {
			if ($(this).prop("checked")) {
				//有交易
				$(this).val("1");
			} else {
				$(this).val("0");
			}
		});

		//点击关联按钮
		function bind() {
			var checkedSon = $($(".son:checked")[0]);

			//给市场活动源文本框赋值
			var name = checkedSon.parent().next().text();
			$("#activity").val(name);

			//给市场活动id赋值
			$("#activityId").val(checkedSon.val());
		}

	</script>
</html>