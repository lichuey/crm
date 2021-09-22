<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
    <head>
        <base href="<%=basePath%>">
        <title>交易统计图表</title>
        <script src="jquery/ECharts/echarts.min.js"></script>
        <script src="jquery/jquery-1.11.1-min.js"></script>
    </head>
    <body>
        <!-- 为 ECharts 准备一个定义了宽高的 DOM -->
        <div id="main" style="width: 800px;height:400px;"></div>
        <div id="main1" style="width: 800px;height:400px;"></div>
    </body>
    <script>
        //柱状图
        $.get("workbench/chart/transaction/queryBarVo", function (data) {

            var myChart = echarts.init(document.getElementById('main'));
            var option = {
                title: {
                    text: '交易统计柱状图',
                    left: 'center'
                },
                xAxis: {
                    type: 'category',
                    data: data.across
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        data: data.vertical,
                        type: 'bar',
                        showBackground: true,
                        backgroundStyle: {
                            color: 'rgba(220, 220, 220, 0.8)'
                        }
                    }
                ]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }, "json");

        //饼状图
        $.get("workbench/chart/transaction/queryPieVo", function (data) {

            var myChart = echarts.init(document.getElementById('main1'));
            var option = {
                title: {
                    text: 'Referer of a Website',
                    subtext: 'Fake Data',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                series: [
                    {
                        name: 'Access From',
                        type: 'pie',
                        radius: '50%',
                        data: data,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }, "json");
    </script>
</html>
