<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>订单销售管理页面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${Path}/static/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${Path}/static/css/public.css" media="all"/>
</head>
<body style="margin: 10px">

<!-- 搜索条件开始 -->
<blockquote class="layui-elem-quote">
    <i class="layui-icon layui-red">&#xe615;</i>
    查询条件
</blockquote>

<form class="layui-form layui-form-pane" method="post" id="searchFrom">

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">订单编号</label>
            <div class="layui-input-inline">
                <input type="text" name="orderId" autocomplete="off" class="layui-input" placeholder="请输入查询的订单编号">
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-inline">
                <input type="text" name="custPhone" autocomplete="off" class="layui-input" placeholder="请输入查询的手机号">
            </div>
        </div>

        <div class="layui-inline">
            <div class="layui-input-label">
                <button type="button" class="layui-btn layui-icon layui-icon-search" id="doSearch">&nbsp;查询</button>
                <button type="reset" class="layui-btn layui-icon layui-btn-danger layui-icon-refresh">&nbsp;重置</button>
            </div>
        </div>
    </div>
</form>
<!-- 搜索条件结束 -->


<!-- 数据表格开始 -->
<table class="layui-hide" id="orderTable" lay-filter="orderTable"></table>


<!-- 数据表格内部操作按钮 -->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
</script>
<!-- 数据表格结束 -->

<!-- 修改的弹出层开始 -->
<div style="display: none" id="addAndEditModel">

    <form class="layui-form layui-form-pane" action="" lay-filter="addAndEditOrderFrame" id="addAndEditOrderFrame"
          style="margin: 20px">
        <blockquote class="layui-elem-quote">
            <i class="layui-icon layui-blue">&#xe609;</i>
            订单记录管理
        </blockquote>

        <div class="layui-form-item">
            <label class="layui-form-label">订单编号</label>
            <div class="layui-input-block">
                <input type="text" name="orderId" lay-verify="required" readonly="readonly" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">客户ID</label>
            <div class="layui-input-block">
                <input type="text" name="custId" autocomplete="off" readonly="readonly" lay-verify="required" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">手机号码</label>
            <div class="layui-input-block">
                <input type="text" name="custPhone" autocomplete="off" class="layui-input" placeholder="请输入手机号码">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">鲜花ID</label>
            <div class="layui-input-block">
                <input type="text" name="flowerId" autocomplete="off" readonly="readonly" lay-verify="required" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">销售金额</label>
            <div class="layui-input-block">
                <input type="text" name="salesOrderAmount" autocomplete="off" lay-verify="required" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">操作员</label>
            <div class="layui-input-block">
                <input type="text" name="operName" autocomplete="off" readonly="readonly" lay-verify="required" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">备注说明</label>
            <div class="layui-input-block">
                    <textarea placeholder="请输入订单的详细描述" lay-verify="required" name="salesOrderInfo"
                              class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item" align="center">
            <div class="layui-input-label">
                <button type="button" class="layui-btn layui-icon layui-icon-ok-circle  layui-btn-radius" lay-submit=""
                        lay-filter="toEditAndAddSubmit" id="toEditAndAddSubmit">&nbsp;提交
                </button>
                <button type="reset"
                        class="layui-btn layui-icon layui-btn-danger layui-icon-refresh   layui-btn-radius">&nbsp;重置
                </button>
            </div>
        </div>

    </form>
</div>
<!-- 修改的弹出层结束 -->


<script src="${Path}/static/layui/layui.js" charset="utf-8"></script>
<script>
    var tableIns;
    layui.use(['table', 'layer', 'form', 'jquery', 'laydate'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var laydate = layui.laydate;


        // 渲染表格数据
        tableIns = table.render({
            elem: '#orderTable'
            , url: '${Path}/order/loadOrderInfo'
            , height: 'full-190'
            , cellMinWidth: 100
            , page: true
            , text: {
                none: "暂无相关数据"
            }
            , title: '订单数据表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'orderId', title: '订单编号', fixed: "left", align: "center"}
                , {field: 'createTime', title: '创建时间',width:180,align: "center"}
                , {field: 'customerName', title: '客户姓名', align: "center"}
                , {field: 'custPhone', title: '手机号', align: "center"}
                , {field: 'flowerName', title: '鲜花名称', align: "center"}
                , {field: 'salesOrderAmount', title: '销售金额', align: "center"}
                , {field: 'salesOrderInfo', title: '备注说明', align: "center"}
                , {field: 'operName', title: '操作人', align: "center"}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', align: "center"}
            ]]
        });

        //给查询按钮添加单击事件
        $("#doSearch").click(function () {
            //获取表单提交的数据序列
            var parameter = $("#searchFrom").serialize();
            tableIns.reload({
                url: "${Path}/order/loadOrderInfo?" + parameter,
                page: {curr: 1}
            });
        });


        //监听行工具删除和修改按钮事件
        table.on('tool(orderTable)', function (obj) {
            var orderData = obj.data;
            if (obj.event === 'delete') {
                layer.confirm('确定删除【' + orderData.orderId + '】的信息吗？', {icon: 3, title: '提示:'}, function () {
                    $.post("${Path}/order/deleteOrderInfo?", {orderId: orderData.orderId}, function (returnValue) {
                        if (returnValue.code == 200) {
                            layer.msg(returnValue.msg, {
                                icon: 6
                            });
                            //刷新表格
                            tableIns.reload();
                        } else {
                            layer.msg(returnValue.msg, {
                                icon: 5
                            });
                        }
                    });
                });
            } else if (obj.event === 'edit') {
                OpenUpdateModel(orderData);
            }
        });


        //打开修改订单信息模态框
        var maxIndex;
        var url;
        function OpenUpdateModel(data) {
            maxIndex = layer.open({
                type: 1,
                title: "修改订单信息",
                content: $('#addAndEditModel'),
                area: ["700px", "520px"],
                anim: 5,                 //动画效果
                skin: "layui-layer-molv", //皮肤
                closeBtn: 2,
                success: function (index) {
                    //给表单复制
                    form.val("addAndEditOrderFrame", data);
                    url = "${Path}/order/updateOrderInfo";
                }
            });
        }

        //保存修改的订单数据
        form.on('submit(toEditAndAddSubmit)', function (data) {
            //序列化表单数据
            var params = $("#addAndEditOrderFrame").serialize();
            $.post(url, params, function (obj) {
                //弹出成功或失败的提示信息
                layer.msg(obj.msg, {
                    icon: 6
                });
                //关闭弹出层
                layer.close(maxIndex);
                //刷新表格
                tableIns.reload();
            });
        });
    });


</script>

</body>
</html>