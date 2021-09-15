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
	
		<!-- 删除联系人的模态窗口 -->
		<div class="modal fade" id="removeContactsModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 30%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">删除联系人</h4>
					</div>
					<div class="modal-body">
						<p>您确定要删除该联系人吗？</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">删除</button>
					</div>
				</div>
			</div>
		</div>
	
		<!-- 删除交易的模态窗口 -->
		<div class="modal fade" id="removeTransactionModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 30%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title">删除交易</h4>
					</div>
					<div class="modal-body">
						<p>您确定要删除该交易吗？</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">删除</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 创建联系人的模态窗口 -->
		<div class="modal fade" id="createContactsModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel1">创建联系人</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form">
						
							<div class="form-group">
								<label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-contactsOwner">
									  <option>zhangsan</option>
									  <option>lisi</option>
									  <option>wangwu</option>
									</select>
								</div>
								<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-clueSource">
									  <option></option>
									  <option>广告</option>
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
								<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-surname">
								</div>
								<label for="create-call" class="col-sm-2 control-label">称呼</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-call">
									  <option></option>
									  <option>先生</option>
									  <option>夫人</option>
									  <option>女士</option>
									  <option>博士</option>
									  <option>教授</option>
									</select>
								</div>
								
							</div>
							
							<div class="form-group">
								<label for="create-job" class="col-sm-2 control-label">职位</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-job">
								</div>
								<label for="create-mphone" class="col-sm-2 control-label">手机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-mphone">
								</div>
							</div>
							
							<div class="form-group" style="position: relative;">
								<label for="create-email" class="col-sm-2 control-label">邮箱</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-email">
								</div>
								<label for="create-birth" class="col-sm-2 control-label">生日</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-birth">
								</div>
							</div>
							
							<div class="form-group" style="position: relative;">
								<label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
								</div>
							</div>
							
							<div class="form-group" style="position: relative;">
								<label for="create-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-describe"></textarea>
								</div>
							</div>
							
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
	
							<div style="position: relative;top: 15px;">
								<div class="form-group">
									<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" id="edit-contactSummary">这个线索即将被转换</textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
									<div class="col-sm-10" style="width: 300px;">
										<input type="text" class="form-control" id="edit-nextContactTime" value="2017-05-01">
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
						<button type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 修改客户的模态窗口 -->
		<div class="modal fade" id="editCustomerModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 85%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改客户</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form">
	
							<div class="form-group">
								<label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-customerOwner">
										<c:forEach items="${userList}" var="user">
											<option value="${user.id}">${user.name}</option>
										</c:forEach>
									</select>
								</div>
								<label for="edit-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-customerName">
								</div>
							</div>
	
							<div class="form-group">
								<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-website">
								</div>
								<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-phone">
								</div>
							</div>
	
							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-describe"></textarea>
								</div>
							</div>
	
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
	
							<div style="position: relative;top: 15px;">
								<div class="form-group">
									<label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="3" id="create-contactSummary1"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
									<div class="col-sm-10" style="width: 300px;">
										<input type="text" class="form-control" id="create-nextContactTime2">
									</div>
								</div>
							</div>
	
							<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
	
							<div style="position: relative;top: 20px;">
								<div class="form-group">
									<label for="edit-address" class="col-sm-2 control-label">详细地址</label>
									<div class="col-sm-10" style="width: 81%;">
										<textarea class="form-control" rows="1" id="edit-address"></textarea>
									</div>
								</div>
							</div>
						</form>
	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateCustomer()">更新</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 修改客户备注的模态窗口 -->
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
							<input type="hidden" id="id" />
							<div class="form-group">
								<label for="edit-describe" class="col-sm-2 control-label">内容</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="noteContent"></textarea>
								</div>
							</div>
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
			<div class="page-header" id="head">
			</div>
			<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
				<button type="button" class="btn btn-default" data-toggle="modal" onclick="showEditCustomerDetailModal()"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
				<button type="button" class="btn btn-danger" onclick="deleteCustomer()"><span class="glyphicon glyphicon-minus"></span> 删除</button>
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
				<div style="width: 300px; color: gray;">公司网站</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="website"></b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="phone"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 20px;">
				<div style="width: 300px; color: gray;">创建者</div>
				<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="createBy"></b><small style="font-size: 10px; color: gray;" id="createTime"></small></div>
				<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 30px;">
				<div style="width: 300px; color: gray;">修改者</div>
				<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy"></b><small style="font-size: 10px; color: gray;" id="editTime"></small></div>
				<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 40px;">
				<div style="width: 300px; color: gray;">联系纪要</div>
				<div style="width: 630px;position: relative; left: 200px; top: -20px;">
					<b id="contactSummary">

					</b>
				</div>
				<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 50px;">
				<div style="width: 300px; color: gray;">下次联系时间</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="nextContactTime"></b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
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
				<div style="width: 300px; color: gray;">详细地址</div>
				<div style="width: 630px;position: relative; left: 200px; top: -20px;">
					<b id="address">

					</b>
				</div>
				<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
			</div>
		</div>
		
		<!-- 备注 -->
		<div style="position: relative; top: 10px; left: 40px;">
			<div class="page-header">
				<h4>备注</h4>
			</div>
		<%--
			<!-- 备注1 -->
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
						<button type="button" class="btn btn-primary" onclick="saveCustomerRemark()">保存</button>
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
					<table id="activityTable2" class="table table-hover" style="width: 900px;">
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
								<td><a href="javascript:void(0);" data-toggle="modal" data-target="#removeTransactionModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div>
					<a href="../transaction/save.html" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建交易</a>
				</div>
			</div>
		</div>
		
		<!-- 联系人 -->
		<div>
			<div style="position: relative; top: 20px; left: 40px;">
				<div class="page-header">
					<h4>联系人</h4>
				</div>
				<div style="position: relative;top: 0px;">
					<table id="activityTable" class="table table-hover" style="width: 900px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td>名称</td>
								<td>邮箱</td>
								<td>手机</td>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><a href="../contacts/detail.html" style="text-decoration: none;">李四</a></td>
								<td>lisi@bjpowernode.com</td>
								<td>13543645364</td>
								<td><a href="javascript:void(0);" data-toggle="modal" data-target="#removeContactsModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div>
					<a href="javascript:void(0);" data-toggle="modal" data-target="#createContactsModal" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建联系人</a>
				</div>
			</div>
		</div>
		
		<div style="height: 200px;"></div>
		<script>

			refresh();

			//刷新客户备注
			function refresh() {
				//异步通过id查询客户备注
				$.get("workbench/customer/queryDetail", {
					'id': '${id}'
				}, function (data) {
					//data:customer
					var customer = data;
					//赋值
					$("#head").html("<h3>" + customer.name + " <small><a href=\""+ 'https://' +customer.website +"\" target=\"_blank\">"+ customer.website +"</a></small></h3>")
					$("#owner").text(customer.owner);
					$("#name").text(customer.name);
					$("#website").text(customer.website);
					$("#phone").text(customer.phone);
					$("#createBy").text(customer.createBy);
					$("#createTime").text(customer.createTime);
					$("#editBy").text(customer.editBy);
					$("#editTime").text(customer.editTime);
					$("#contactSummary").text(customer.contactSummary);
					$("#nextContactTime").text(customer.nextContactTime);
					$("#description").text(customer.description);
					$("#address").text(customer.address);

					//清空
					$(".remarkDiv").remove();
					//备注
					var customerRemarks = customer.customerRemarkList;
					for (var i = 0; i < customerRemarks.length; i++) {
						var remark = customerRemarks[i];
						$("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
								"\t\t\t\t<img title=\"zhangsan\" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">\n" +
								"\t\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
								"\t\t\t\t\t<h5 id='"+ remark.id +"'>" + remark.noteContent + "</h5>\n" +
								"\t\t\t\t\t<font color=\"gray\">客户</font> <font color=\"gray\">-</font> <b>" + customer.name + "</b> <small style=\"color: gray;\"> " + customer.createTime + " 由" + customer.createBy + "</small>\n" +
								"\t\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
								"\t\t\t\t\t\t<a class=\"myHref\" onclick=\"showUpdateCustomerRemark('"+ remark.id +"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
								"\t\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
								"\t\t\t\t\t\t<a class=\"myHref\" onclick=\"deleteCustomerRemark('"+ remark.id +"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
								"\t\t\t\t\t</div>\n" +
								"\t\t\t\t</div>\n" +
								"\t\t\t</div>")
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

				}, "json");
			}

			//异步保存客户备注
			function saveCustomerRemark() {
				$.post("workbench/customer/saveCustomerRemark", {
					"noteContent": $("#remark").val(),
					"customerId": "${id}"
				}, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						//清空文本框
						$("#remark").val("");

						//刷新客户
						refresh();
					}
				}, "json");
			}

			//弹出更新客户模态框
			function showUpdateCustomerRemark(id) {
				//设置模态框文本内容
				var noteContent =  $("#" + id).text();
				$("#noteContent").val(noteContent);

				//设置模态框中id的值
				$("#id").val(id);

				//打开模态框
				$("#editRemarkModal").modal("show");
			}

			//异步更新客户备注
			$("#updateRemarkBtn").click(function () {
				$.post("workbench/customer/updateCustomerRemark",{
					"noteContent": $("#noteContent").val(),
					"id": $("#id").val()
				},function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						refresh();

						//隐藏模态框
						$("#editRemarkModal").modal("hide");
					}
				},"json")
			});

			//异步删除客户备注
			function deleteCustomerRemark(id) {
				$.post("workbench/customer/deleteCustomerRemark", {
					"id": id
				}, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						refresh();
					}
				}, "json");
			}

			//打开编辑模态框
			function showEditCustomerDetailModal() {
				//通过id查询customer
				$.get("workbench/customer/showEditCustomerDetailModal", {
					"id": "${id}"
				}, function (data) {
					//data:customer
					var customer = data;
					$("#edit-customerOwner").val(customer.owner);
					$("#edit-customerName").val(customer.name);
					$("#edit-website").val(customer.website);
					$("#edit-phone").val(customer.phone);
					$("#edit-describe").val(customer.description);
					$("#create-contactSummary1").val(customer.contactSummary);
					$("#create-nextContactTime2").val(customer.nextContactTime);
					$("#edit-address").val(customer.address);

					//展示模态框
					$("#editCustomerModal").modal("show");

				}, "json");
			}

			//异步更新客户
			function updateCustomer() {
				$.post("workbench/customer/updateCustomer", {
					"id": "${id}",
					"owner": $("#edit-customerOwner").val(),
					"name": $("#edit-customerName").val(),
					"website": $("#edit-website").val(),
					"phone": $("#edit-phone").val(),
					"description": $("#edit-describe").val(),
					"contactSummary": $("#create-contactSummary1").val(),
					"nextContactTime2": $("#create-nextContactTime2").val(),
					"address": $("#edit-address").val()
				}, function (data) {
					//data:resultVo
					if (data.resOK) {
						alert(data.message);

						refresh();
					}
				}, "json");
			}

			//异步删除客户
			function deleteCustomer() {
				layer.alert('你确定删除这条客户信息吗？此操作不可逆！', {
					time: 0 //不自动关闭
					,btn: ['删除', '取消']
					,yes: function(index){
						layer.close(index);

						$.post("workbench/customer/deleteCustomer", {
							"id": "${id}"
						}, function (data) {
							//data:resultVo
						}, "json");

						//跳转到index.jsp
						location.href = "toView/workbench/customer/index";
					}
				});
			}


		</script>
	</body>
</html>