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

		<!-- 解除联系人和市场活动关联的模态窗口 -->
		<div class="modal fade" id="unbundActivityModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 30%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">解除关联</h4>
					</div>
					<div class="modal-body">
						<p>您确定要解除该关联关系吗？</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">解除</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 联系人和市场活动关联的模态窗口 -->
		<div class="modal fade" id="bundActivityModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 80%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">关联市场活动</h4>
					</div>
					<div class="modal-body">
						<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
							<form class="form-inline" role="form">
							  <div class="form-group has-feedback">
								<input type="text" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
								<span class="glyphicon glyphicon-search form-control-feedback"></span>
							  </div>
							</form>
						</div>
						<table id="activityTable2" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
							<thead>
								<tr style="color: #B3B3B3;">
									<td><input type="checkbox"/></td>
									<td>名称</td>
									<td>开始日期</td>
									<td>结束日期</td>
									<td>所有者</td>
									<td></td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="checkbox"/></td>
									<td>发传单</td>
									<td>2020-10-10</td>
									<td>2020-10-20</td>
									<td>zhangsan</td>
								</tr>
								<tr>
									<td><input type="checkbox"/></td>
									<td>发传单</td>
									<td>2020-10-10</td>
									<td>2020-10-20</td>
									<td>zhangsan</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">关联</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 修改联系人的模态窗口 -->
		<div class="modal fade" id="editContactsModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改联系人</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form">

							<div class="form-group">
								<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-contactsOwner">
									  <option selected>zhangsan</option>
									  <option>lisi</option>
									  <option>wangwu</option>
									</select>
								</div>
								<label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-clueSource">
									  <option></option>
									  <option selected>广告</option>
									  <option>推销电话</option>
									  <option>员工介绍</option>
									  <option>外部介绍</option>
									  <option>在线商场</option>
									  <option>合作伙伴</option>
									  <option>公开媒介</option>
									  <option>销售邮件</option>
									  <option>合作伙伴研讨会</option>
									  <option>内部研讨会</option>
									  <option>交易会</option>
									  <option>web下载</option>
									  <option>web调研</option>
									  <option>聊天</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-surname" value="李四">
								</div>
								<label for="edit-call" class="col-sm-2 control-label">称呼</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-call">
									  <option></option>
									  <option selected>先生</option>
									  <option>夫人</option>
									  <option>女士</option>
									  <option>博士</option>
									  <option>教授</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label for="edit-job" class="col-sm-2 control-label">职位</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-job" value="CTO">
								</div>
								<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-mphone" value="12345678901">
								</div>
							</div>

							<div class="form-group">
								<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
								</div>
								<label for="edit-birth" class="col-sm-2 control-label">生日</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-birth">
								</div>
							</div>

							<div class="form-group">
								<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建" value="动力节点">
								</div>
							</div>

							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-describe">这是一条线索的描述信息</textarea>
								</div>
							</div>

							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

							<div style="position: relative;top: 15px;">
								<div class="form-group">
									<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
									<div class="col-sm-10" style="width: 300px;">
										<input type="text" class="form-control" id="create-nextContactTime">
									</div>
								</div>
							</div>

							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

							<div style="position: relative;top: 20px;">
								<div class="form-group">
									<label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="1" id="edit-address1">北京大兴区大族企业湾</textarea>
									</div>
								</div>
							</div>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 修改联系人备注的模态窗口 -->
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
									<textarea class="form-control" rows="3" id="noteContent" name="noteContent"></textarea>
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

		<!-- 返回按钮 -->
		<div style="position: relative; top: 35px; left: 10px;">
			<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
		</div>

		<!-- 大标题 -->
		<div style="position: relative; left: 40px; top: -30px;">
			<div class="page-header" id="divTestId">
			</div>
			<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
				<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editContactsModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
				<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>
		</div>

		<!-- 详细信息 -->
		<div style="position: relative; top: -70px;">
			<div style="position: relative; left: 40px; height: 30px;">
				<div style="width: 300px; color: gray;">所有者</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="owner"></b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">来源</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="source"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 10px;">
				<div style="width: 300px; color: gray;">客户名称</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="customerId1"></b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">姓名</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="fullname1"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 20px;">
				<div style="width: 300px; color: gray;">邮箱</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="email"></b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="mphone"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 30px;">
				<div style="width: 300px; color: gray;">职位</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="job"></b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">生日</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="birth"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 40px;">
				<div style="width: 300px; color: gray;">创建者</div>
				<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="createBy"></b><small style="font-size: 10px; color: gray;" id="createTime"></small></div>
				<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 50px;">
				<div style="width: 300px; color: gray;">修改者</div>
				<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy"></b><small style="font-size: 10px; color: gray;" id="editTime"></small></div>
				<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 60px;">
				<div style="width: 300px; color: gray;">描述</div>
				<div style="width: 630px;position: relative; left: 200px; top: -20px;">
					<b id="description">

					</b>
				</div>
				<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 70px;">
				<div style="width: 300px; color: gray;">联系纪要</div>
				<div style="width: 630px;position: relative; left: 200px; top: -20px;">
					<b id="contactSummary">

					</b>
				</div>
				<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 80px;">
				<div style="width: 300px; color: gray;">下次联系时间</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="nextContactTime"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 90px;">
				<div style="width: 300px; color: gray;">详细地址</div>
				<div style="width: 630px;position: relative; left: 200px; top: -20px;">
					<b id="address">

					</b>
				</div>
				<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
		</div>
		<!-- 备注 -->
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>备注</h4>
			</div>

			<%--<!-- 备注1 -->
			<div class="remarkDiv" style="height: 60px;">
				<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
				<div style="position: relative; top: -40px; left: 40px;" >
					<h5>哎呦！</h5>
					<font color="gray">联系人</font> <font color="gray">-</font> <b>李四先生-北京动力节点</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
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
						<button type="button" onclick="saveContactsRemark()" class="btn btn-primary">保存</button>
					</p>
				</form>
			</div>
		</div>

		<!-- 交易 -->
		<div>
			<div style="position: relative; top: 20px; left: 40px;">
				<div class="page-header">
					<h4>交易</h4>
				</div>
				<div style="position: relative;top: 0px;">
					<table id="activityTable3" class="table table-hover" style="width: 900px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td>名称</td>
								<td>金额</td>
								<td>阶段</td>
								<td>可能性</td>
								<td>预计成交日期</td>
								<td>类型</td>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><a href="../transaction/detail.html" style="text-decoration: none;">动力节点-交易01</a></td>
								<td>5,000</td>
								<td>谈判/复审</td>
								<td>90</td>
								<td>2017-02-07</td>
								<td>新业务</td>
								<td><a href="javascript:void(0);" data-toggle="modal" data-target="#unbundModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div>
					<a href="../transaction/save.html" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建交易</a>
				</div>
			</div>
		</div>

		<!-- 市场活动 -->
		<div>
			<div style="position: relative; top: 60px; left: 40px;">
				<div class="page-header">
					<h4>市场活动</h4>
				</div>
				<div style="position: relative;top: 0px;">
					<table id="activityTable" class="table table-hover" style="width: 900px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><a href="../activity/detail.html" style="text-decoration: none;">发传单</a></td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
								<td><a href="javascript:void(0);" data-toggle="modal" data-target="#unbundActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div>
					<a href="javascript:void(0);" data-toggle="modal" data-target="#bundActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
				</div>
			</div>
		</div>


		<div style="height: 200px;"></div>

		<script>

			refresh();

			//刷新
			function refresh() {
				//查询联系人详情页数据
				$.get("workbench/contacts/queryDetail",{'id':'${id}'},function (data) {
					//data:contacts
					var contacts = data;
					$("#owner").text(contacts.owner);
					$("#source").text(contacts.source);
					$("#customerId1").text(contacts.customerId);
					$("#fullname1").text(contacts.fullname);
					$("#divTestId").html("<h3 >"+contacts.fullname+"<small>"+contacts.customerId+"</small></h3>");
					$("#email").text(contacts.email);
					$("#mphone").text(contacts.mphone);
					$("#job").text(contacts.job);
					$("#birth").text(contacts.birth);
					$("#createBy").text(contacts.createBy);
					$("#createTime").text(contacts.createTime);
					$("#editBy").text(contacts.editBy);
					$("#editTime").text(contacts.editTime);
					$("#description").text(contacts.description);
					$("#contactSummary").text(contacts.contactSummary);
					$("#nextContactTime").text(contacts.nextContactTime);
					$("#address").text(contacts.address);

					//清空
					$(".remarkDiv").remove();

					//取出联系人的备注集合
					var contactsRemarks = contacts.contactsRemarkList;
					for(var i = 0; i <contactsRemarks.length; i++){
						var remark = contactsRemarks[i];
						$('#remarkDiv').before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
								"\t\t\t\t<img title=\"zhangsan\" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">\n" +
								"\t\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
								"\t\t\t\t\t<h5 id='"+ remark.id +"'>"+ remark.noteContent +"</h5>\n" +
								"\t\t\t\t\t<font color=\"gray\">联系人</font> <font color=\"gray\">-</font> <b>"+ contacts.fullname + '-' + contacts.customerId +"</b> <small style=\"color: gray;\"> " + contacts.createTime + " 由 " + contacts.createBy + "</small>\n" +
								"\t\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
								"\t\t\t\t\t\t<a class=\"myHref\" onclick=\"showEditContactsRemarkModel('"+ remark.id +"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
								"\t\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
								"\t\t\t\t\t\t<a class=\"myHref\" onclick=\"deleteContactsRemarkModel('"+ remark.id +"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
								"\t\t\t\t\t</div>\n" +
								"\t\t\t\t</div>\n" +
								"\t\t\t</div>");
					}

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

				},'json');
			}

			//保存联系人备注
			function saveContactsRemark() {
				$.post("workbench/contacts/saveContactsRemark", {
					"noteContent": $("#remark").val(),
					"contactsId": "${id}"
				}, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						$("#remark").val("");

						refresh();
					}
				}, "json");
			}

			//弹出修改模态框
			function showEditContactsRemarkModel(id) {
				//保存noteContent
				var noteContent = $("#" + id).text();
				$("#noteContent").val(noteContent);

				//保存id
				$("#id").val(id);

				$("#editRemarkModal").modal("show");
			}

			//更新联系人备注
			$("#updateRemarkBtn").click(function () {
				$.post("workbench/contacts/editContactsRemark", {
					"noteContent": $("#noteContent").val(),
					"id": $("#id").val()
				}, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						$("#editRemarkModal").modal("hide");

						refresh();
					}
				}, "json");
			})

			//删除联系人备注
			function deleteContactsRemarkModel(id) {
				$.post("workbench/contacts/deleteContactsRemarkModel", {
					"id": id
				}, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						refresh();
					}
				}, "json");
			}

		</script>
	</body>
</html>