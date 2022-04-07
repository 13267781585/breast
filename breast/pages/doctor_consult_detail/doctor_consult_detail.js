// pages/userDetail/userDetail.js
const app = getApp();
Page({
  data: {
    consultOrder:null, //订单
  },
  onLoad: function (options) {
    var that = this;
   console.log('订单详情参数:',options)
   //得到咨询订单 id 并去 app globalData 搜索 订单详细信息
    //var order = app.findConsultOrderById(options.consultOrderId);
    wx.request({
      url: app.globalData.serverUrl + '/getByOid',
      method: "GET",
      header: {
        'content-type': 'application/x-www-form-urlencoded' // 默认值
      },
      data: {
        oid: options.consultOrderId,
      },
      success: function (res) {
        console.log('获取订单信息成功', res.data.data)
        var order = res.data.data;
        that.setData({
          consultOrder: order
        })
        wx.setNavigationBarTitle({
          title: "订单详情"
        })
      },
      fail: function (res) {
        console.log('获取订单信息失败！')
      }
    })
    
  },

  toChat: function () {
    //跳转到聊天页面
    wx.navigateTo({
      url: '../consult_chatroom/consult_chatroom?userId=' + this.data.consultOrder.userId + '&doctorId=' + this.data.consultOrder.doctorId + '&oid=' + this.data.consultOrder.oid,
    })
  },
  onOver: function () {
    var that = this;
    //修改订单的状态
    wx.request({
      method:'GET',
      url:app.globalData.serverUrl + '/updateConsultOrderStatusById',
      data:{
        status:1,
        id:that.data.consultOrder.id
      },
      success(res){
        console.log('修改订单状态成功',res)
        //因为订单的状态发生变化 存储在app.js 中的数据也要变化
        app.updateConsultOrderStatusById(that.data.consultOrder.id,1)
       
      },
      fail(res){
        console.log('修改订单状态失败', res)
      },
      complete(res){
        if(app.globalData.object=='doctor'){
          wx.navigateTo({
            url: '../doctor_myconsult/doctor_myconsult'
          })
        }
      }
      
    })
    
  },
})
