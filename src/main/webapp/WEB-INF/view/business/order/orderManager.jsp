<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>鲜花销售管理页面</title>
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

<!-- 表单开始 -->
<div style="display: none" id="checkFormHide">
    <blockquote class="layui-elem-quote" style="border-left:0px;">
        <h2>订单列表</h2>
        <hr style="background-color: #009688;">
        <form class="layui-form layui-form-pane" method="post" lay-filter="checkFrom" id="checkFrom">

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">订单编号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="orderId" id="orderId" autocomplete="off" readonly="readonly"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">鲜花名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="flowerId" id="flowerId" style="display: none">
                        <input type="text" name="flowerName" id="flowerName" autocomplete="off" readonly="readonly"
                               class="layui-input"
                               placeholder="请输入鲜花名称">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">鲜花价格</label>
                    <div class="layui-input-inline">
                        <input type="text" name="flowerPrice" id="flowerPrice" readonly="readonly" autocomplete="off"
                               class="layui-input"
                               placeholder="请输入鲜花价格">
                    </div>
                </div>

            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">客户号码</label>
                <div class="layui-input-block">
                    <input type="text" name="custPhone" id="custPhone" autocomplete="off" lay-verify="required|number|userPhone"
                           class="layui-input"
                           placeholder="请输入客户的手机号码">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">客户姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="custName" id="custName" readonly="readonly" autocomplete="off"
                           class="layui-input"
                           placeholder="请输入客户的姓名">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">购买数量</label>
                <div class="layui-input-block">
                    <input type="text" name="salesOrderNumber" id="salesOrderNumber" autocomplete="off"
                           lay-verify="required|number"
                           class="layui-input" placeholder="请输入购买鲜花的数量">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">预付金额</label>
                <div class="layui-input-block">
                    <input type="text" name="salesOrderAmount" id="salesOrderAmount" autocomplete="off"
                           readonly="readonly"
                           lay-verify="required|number"
                           class="layui-input" placeholder="请输入鲜花的总金额">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">操作人员</label>
                <div class="layui-input-block">
                    <input type="text" name="operName" id="operName" readonly="readonly" autocomplete="off"
                           lay-verify="required"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注说明</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入订单的详细描述" lay-verify="required" name="salesOrderInfo"
                              class="layui-textarea"></textarea>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <div class="layui-input-label">
                        <button type="button" class="layui-btn layui-icon layui-icon-ok-circle layui-btn-normal"
                                lay-filter="doSubmit" lay-submit="" id="doSubmit">&nbsp;确认
                        </button>
                    </div>
                </div>
                <div class="layui-inline">
                    <div class="layui-input-label">
                        <button type="button" class="layui-btn layui-icon layui-icon-close-fill layui-btn-normal"
                                id="cancel">&nbsp;取消
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </blockquote>
</div>
<!-- 表单结束 -->

<!-- 数据表格开始 -->
<div id="tableFlowerId" style="display: block">
    <table class="layui-hide" id="flowerTable" lay-filter="flowerTable"></table>
</div>

<!-- 数据表格内部操作按钮开始 -->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="buy">出售</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="view">浏览</a>
</script>
<!-- 数据表格内部操作按钮结束 -->


<!-- 表格内嵌效果开始 -->
<script type="text/html" id="switchTpl">
    <input type="checkbox" name="Unfold" value="{{d.flowerState}}" lay-skin="switch" lay-text="已上架|未上架" {{
           d.flowerState==1?'checked':''}}>
</script>
<!-- 表格内嵌效果开始 -->


<!-- 查看大图弹出层开始 -->
<div style="display: none" id="viewLargerImage">
    <img alt="鲜花详情图" width="604" height="418" id="viewImage">
</div>
<!-- 查看大图弹出层结束 -->


<script src="${Path}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    var tableIns;
    layui.use(['table', 'layer', 'form', 'jquery', 'upload'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var upload = layui.upload;

        // 渲染表格数据
        tableIns = table.render({
            elem: '#flowerTable'
            , url: '${Path}/flower/loadFlowerDataByAll'
            , height: 'full-50'
            , cellMinWidth: 100
            , page: true
            , text: {
                none: "暂无相关数据"
            }
            , title: '鲜花数据表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'flowerId', title: 'ID', fixed: 'left', align: "center"}
                , {field: 'flowerName', title: '名称', align: "center"}
                , {field: 'flowerType', title: '类型', align: "center"}
                , {field: 'flowerNumber', title: '数量', align: "center"}
                , {field: 'flowerSellPrice', title: '出售价格', align: "center"}
                , {field: 'flowerState', title: '是否上架', align: "center", width: 105, templet: "#switchTpl"}
                , {
                    field: 'flowerImageAddress', title: '缩略图', align: "center", templet: function (d) {
                        return "<img width=40 height=30 src=${Path}/file/showImgFileInformation?path=" + d.flowerImageAddress + "/>";
                    }
                }
                , {field: 'createTime', title: '创建时间',width:180,align: "center"}
                , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 180, align: "center"}
            ]]
        });

        // 保存订单数据
        form.on("submit(doSubmit)",function () {
            // 序列化表单数据
            var params = $("#checkFrom").serialize();
            // 发送请求保存订单数据
            $.post("${Path}/order/addOrderData",params,function (value) {
                if (value.code == 200){
                    // 显示鲜花的数据表格
                    $("#tableFlowerId").css("display", "block");
                    // 隐藏订单列表
                    $("#checkFormHide").css("display", "none");
                    layer.msg(value.msg,{icon:6});
                }
            });
        });


        //监听行工具购买和浏览按钮事件
        table.on('tool(flowerTable)', function (obj) {
            var flowerData = obj.data;  //获取到单击行的数据
            var layEvent = obj.event;
            if (layEvent === 'buy') {
                BuyFlowerFun(flowerData);
            } else if (layEvent === 'view') {
                OpenViewModel(flowerData);
            }
        });

        // 购买数量输入框添加事件
        $("#salesOrderNumber").change(function () {
            if ($(this).val() !== '') {
                var amount = $("#flowerPrice").val() * $(this).val();
                $("#salesOrderAmount").val(amount);
            }
        });

        // 客户手机号的输入框事件
        $("#custPhone").change(function () {
            if ($(this).val() !== ''){
                $.post("${Path}/customer/getCustomerNameByPhone", {custPhone: $(this).val()}, function (data) {
                    if (data !== null){
                        $("#custName").val(data.custName);
                    }
                });
            }
        });

        // 取消按钮的单击事件
        $("#cancel").on("click", function () {
            // 显示鲜花的数据表格
            $("#tableFlowerId").css("display", "block");
            // 隐藏订单列表
            $("#checkFormHide").css("display", "none");
        });

        // 购买按钮的单击事件
        function BuyFlowerFun(flowerData) {
            // 清空表单的数据
            $("#checkFrom")[0].reset();
            // 隐藏鲜花的数据表格
            $("#tableFlowerId").css("display", "none");
            // 显示订单列表
            $("#checkFormHide").css("display", "block");
            // 初始化订单列表
            initOrderFormData(flowerData);
        }

        // 初始化订单列表
        function initOrderFormData(flowerData) {
            // 发送请求获取到订单列表数据
            $.post("${Path}/order/loadOrderFormData", {flowerId: flowerData.flowerId}, function (map) {
                // 给订单输入框赋值
                $("#orderId").val(map.orderNumber);
                // 给操作员输入框赋值
                $("#operName").val(map.userName);
                $("#flowerName").val(flowerData.flowerName);
                $("#flowerPrice").val(flowerData.flowerSellPrice);
                $("#flowerId").val(flowerData.flowerId);
            });
        }

        //点击查看大图
        function OpenViewModel(flowerData) {
            maxIndex = layer.open({
                type: 1,
                title: "【" + flowerData.flowerName + "】大图",
                content: $('#viewLargerImage'),
                area: ["604px", "460px"],
                anim: 5,                 //动画效果
                skin: "layui-layer-lan", //皮肤
                closeBtn: 2,
                success: function (index) {
                    $("#viewImage").attr("src", "${Path}/file/showImgFileInformation?path=" + flowerData.flowerImageAddress);
                }
            });
        }

        //表单验证
        form.verify({
            userPhone: function(value){
                var formData = new FormData();
                formData.append("custPhone", value);
                var message = '';
                $.ajax({
                    url: "${Path}/order/checkCustPhone",
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    processData: false,
                    contentType: false,
                    dataType: "json",
                    success: function (data) {
                        if (data){
                            message = "请输入正确的客户手机号码";
                        }
                    }
                });
                if (message !== ''){
                    return message;
                }
            }
        });

    });

</script>

</body>
</html>