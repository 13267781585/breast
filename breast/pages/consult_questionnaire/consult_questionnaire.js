var QiniuUploader = require('../../assert/js/qiniuUploader.js')
var showUtil = require('../../assert/util.js')
const app = getApp();
Page({
  data: {
    doctorUuid: '',//医生的标识符
    doctorName: '',//医生姓名
    doctorImg: '',//医生图片
    doctorId:-1,//医生id
    question: '',//所有问题
    name: '', //联系姓名
    phone: '',//联系人电话
    consultCost: 5, //咨询费用
    height: 20,
    focus: false,
    imgList: [],
    modalName: null,
    imgToken: '',
    imageURL: '',
    userId: -1,
    doctorOpenId: '',   //医生微信小程序标识符
    oid:''//查询订单id
  },
  onLoad: function (options) {
    //判断是否登录
    this.getImgToken();
    if (app.globalData.userInfor != null && app.globalData.userInfor.userId == null){
         showUtil.showToLogion();
    }
    //接受传参并设置
    console.log('----填写咨询问卷传递参数：----：', options)
    this.setData({
      doctorUuid: options.doctorUuid,
      doctorName: options.doctorName,
      doctorId:options.doctorId,
      doctorImg: JSON.parse(decodeURIComponent(options.doctorImg)),
      doctorOpenId: options.openId
    })
    //判断本地是否有问卷
    console.log('----判断本地是否有问卷：----')
    if(this.queryGlobalConsult(this.data.doctorId)){
      //如果返回为true则直接进入聊天页面
      console.log('----本地有咨询问卷：----')
      wx.navigateTo({
        url: '../consult_chatroom/consult_chatroom?otherId=' +this.data.doctorUuid + '&oid=' + this.data.oid + '&otherImg=' + encodeURIComponent(JSON.stringify(this.data.doctorImg))+ '&id=' + app.globalData.userInfor.uuid + '&img='
        +  encodeURIComponent(JSON.stringify(app.globalData.userInfor.imgUrl))
      })
    }
    //判断数据库是否有问卷
    console.log('----判断数据库是否有问卷：----')
    console.log(options.doctorId,getApp().globalData.userId);
    this.queryConsult(getApp().globalData.userId,options.doctorId);

    //等待填写问卷
    wx.showLoading({
      title: '加载中',
    })

  },

  onReady: function () {
    wx.hideLoading({
      complete: (res) => { },
    })
  },

  bindButtonTap: function () {
    this.setData({
      focus: true
    })
  },
  bindTextAreaBlur: function (e) {
    console.log(e.detail.value)
  },
  bindFormSubmit: function (e) {
    console.log(e.detail.value.textarea)
  },

  //设置值
  handlerQuestion(e) {
    console.log(e);
    this.setData({
      question: e.detail.value
    })
  },
  handlerName(e) {
    console.log(e);
    this.setData({
      name: e.detail.value
    })
  },
  handlerPhone(e) {
    var phoneTest = ' ';
    if (!(/^1[3456789]\d{9}$/.test(e.detail.value))) {
      this.showModal("请输入合理的手机号，以便接收消息");
    }
    console.log(e);
    this.setData({
      phone: e.detail.value
    })
  },

  onchange: function (e) {
    console.log('参数：', e)
    console.log('用户点击确定')

    //判断用户输入是否正确
    if (this.data.phone.length == 0 || this.data.question.length == 0) {
      this.showModal("请输入正确的电话号码和详细的病症！")
      return;
    }
    var now = new Date();
    var createTime = app.jsDateFormatter(now);
    var that = this;
    console.log('咨询订单参数：' + createTime + ' ' + this.data.doctorUuid )
    //创建 咨询订单
    console.log('----app.globalData.userInfor.user_id---',getApp().globalData.userId)
    wx.request({
      url: app.globalData.serverUrl + '/addConsultOrder',
      method: 'POST',
      header: {
        'content-type': 'application/x-www-form-urlencoded' // 默认值
      },
      data: {
        doctorId: this.data.doctorId,
        userId: getApp().globalData.userId,
        createTime: createTime,
        lastingTime: 60 * 60 * 24 * 1000,//先传 暂时没用
        contact: this.data.name,
        contactPhone: this.data.phone,
        symptomDescription: this.data.question,
        consultCost: this.data.consultCost,
        imgUrls: this.data.imgList.toString(),
        userOpenId: getApp().globalData.userInfor.openId,
        doctorOpenId: this.data.doctorOpenId,
      },
      success(res) {
        console.log('生成订单成功----->添加记录到全局 res:', res)
        //添加记录到全局
        that.addConsultToGlobal(createTime,res.data.data);
        console.log('本地记录--->订阅消息:',getApp().globalData.order_list)
        that.sendSubMessage()
        if (res.data.status == 1) {
          wx.navigateTo({
            url: '../consult_chatroom/consult_chatroom?otherId=' + that.data.doctorUuid + '&oid=' + res.data.data + '&otherImg=' + encodeURIComponent(JSON.stringify(that.data.doctorImg))+ '&id=' + app.globalData.userInfor.uuid + '&img='
            +  encodeURIComponent(JSON.stringify(app.globalData.userInfor.imgUrl)),
          })
          // wx.navigateTo({
          //   url: '../consult_chatroom/consult_chatroom?otherId=' + that.data.doctorUuid + '&oid=f6cc95117ca04e8287f83e1e9ef19f5e' + '&otherImg=' + that.data.doctorImg + '&id=' + app.globalData.userInfor.uuid + '&img='
          //     + app.globalData.userInfor.imgUrl,
          // })
        }
        else
          //弹出 错误消息 提示框
          that.showModal(res.data.msg)

      },
      fail(res) {
        console.log('生成订单失败:', res)
      }
    })

  },

  //显示模态框，errmsg-表单错误信息
  showModal(errmsg) {
    this.setData({
      modalContent: errmsg,
      modalName: "Modal"
    })
  },

  //隐藏模态框
  hideModal(e) {
    this.setData({
      modalName: null
    })
  },

  /*图片模块 */
  //上传图片的token
  getImgToken: function () {
    var that = this;
    wx.request({
      url: getApp().globalData.serverUrl + '/article/getToken',
      method: 'GET',
      data: {
        bucket: 'wdtc'
      },
      success: function (res) {
        console.log(res)
        that.setData({
          imgToken: res.data
        })
      }
    })
  },
  //选择图片并上传
  ChooseImage() {
    var that = this;
    var qiniu_key = this.data.userid + "_consult_" + Date.parse(new Date()) / 1000 + ".jpg";
    wx.chooseImage({
      count: 1, //默认9
      sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
      sourceType: ['album'], //从相册选择

      success: function (res) {
        var filePath = res.tempFilePaths[0];
        console.log(that.data.imgToken)
        // 交给七牛上传
        var img0 = 'imgList[0]'
        QiniuUploader.upload(filePath, (res) => {
          that.setData({
            'imageURL': res.imageURL,
            [img0]: res.imageURL
          });

          console.log('file url is: ' + res.imageURL);
        }, (error) => {
          console.log('error: ' + error);
        }, {
            region: 'SCN',
            domain: 'http://llllllllr.top/', // // bucket 域名，下载资源时用到。如果设置，会在 success callback 的 res 参数加上可以直接使用的 ImageURL 字段。否则需要自己拼接
            key: qiniu_key, // [非必须]自定义文件 key。如果不设置，默认为使用微信小程序 API 的临时文件名
            uptoken: that.data.imgToken, // 由其他程序生成七牛 uptoken
            uploadURL: 'https://up-z2.qiniup.com'
          }, (res) => {
            console.log('上传进度', res.progress)
            console.log('已经上传的数据长度', res.totalBytesSent)
            console.log('预期需要上传的数据总长度', res.totalBytesExpectedToSend)
            console.log("URLLL" + res.imageURL)
          }, () => {
            // 取消上传
          }, () => {
            // `before` 上传前执行的操作
          }, (err) => {
            // `complete` 上传接受后执行的操作(无论成功还是失败都执行)
            console.log("error")
          });

      }
    });
  },
  DelImg(e) {
    wx.showModal({
      title: '提示',
      content: '确定要删除吗？',
      cancelText: '取消',
      confirmText: '确定',
      confirmColor: "#d4237a",
      success: res => {
        if (res.confirm) {
          this.data.imgList.splice(e.currentTarget.dataset.index, 1);
          this.setData({
            imgList: this.data.imgList
          })
        }
      }
    })
  },
  //查询全局参数是否有记录 有记录则设置oid
  //同时要查询是否有效
  queryGlobalConsult:function(doctorId){
    var order_list=getApp().globalData.order_list;
    console.log('order_list:',order_list);
    if(order_list==null||""==order_list){
      return false;
    }else{
      order_list.forEach(item => {
        if(item.doctorId==doctorId){
          //查询订单是否有效
          if(this.queryConsuIsOpen(item.oid)){
            this.data.oid=item.oid;
            return true;
          }else{
            return false;
          }
        }
      });
      return false;
    }

  },
  //查询订单是否有效
  queryConsuIsOpen:async function(oid){
<<<<<<< HEAD
    var _this=this;
=======
>>>>>>> 40a984d6839b33b376eba7f726da846eb85dcd8b
    wx.request({
      url: app.globalData.serverUrl + '/isOpenConsult',
      method: 'GET',
      data: {
        oid:oid
      },
      success: function (res) {
        console.log('查询订单是否有效---->res:',res)
        if(res.data.msg=="consult_isClose"){
          console.log("----查询到无效----")
          return false;
        }
        if(res.data.msg=="consult_isOpen"){
          console.log("----查询到有效----")
<<<<<<< HEAD
          wx.navigateTo({
            url: '../consult_chatroom/consult_chatroom?otherId=' + _this.data.doctorUuid + '&oid=' + oid + '&otherImg=' + encodeURIComponent(JSON.stringify(_this.data.doctorImg))+ '&id=' + app.globalData.userInfor.uuid + '&img='
            +  encodeURIComponent(JSON.stringify(app.globalData.userInfor.imgUrl)),
          })
=======
          return true;
>>>>>>> 40a984d6839b33b376eba7f726da846eb85dcd8b
        }
        return false;
      }
    })

  },
  //添加记录到全局
  addConsultToGlobal:function(cr_time,consultId){
    var record={
      doctorId:this.data.doctorId,
      userId:app.globalData.userId,
      createTime: cr_time,
      contact: this.data.name,
      contactPhone: this.data.phone,
      symptomDescription: this.data.question,
      consultCost: this.data.consultCost,
      imgUrls: this.data.imgList.toString(),
      userOpenId: app.globalData.userInfor.openId,
      doctorOpenId: this.data.doctorOpenId,
      oid:consultId
    }
    var order_list_update=app.globalData.order_list;
    console.log('----历史咨询记录---->',order_list_update)
    order_list_update.push(record);
    app.globalData.order_list=order_list_update;
    console.log('----更新后的咨询记录---->',getApp().globalData.order_list);
  },

  sendSubMessage() {
    var tempId = app.globalData.sendToDoctortmpId;
    wx.requestSubscribeMessage({
      tmplIds: [tempId],
      success: function (res) {
        if (res[tempId] === 'accept') {
          wx.showToast({
            title: '订阅OK！',
          })
        }
        console.log('订阅消息成功', res)
        //成功
      },
      fail(err) {
        //失败
        console.error('订阅消息失败：', err);
      }
    })

  },  
  
<<<<<<< HEAD


=======
>>>>>>> 40a984d6839b33b376eba7f726da846eb85dcd8b
  //查询后台数据库是否有订单
  queryConsult:async function(user_id,doctor_id){
    var _this=this;
    wx.request({
      url: getApp().globalData.serverUrl + '/getConsultByUserIdAndDoctorId',
      method: 'GET',
      header: {
      'content-type': 'application/x-www-form-urlencoded' // 默认值
    },
    data:{
      userId:user_id,
      doctorId:doctor_id,
    },
    success(res){
      if(res.data.status == 1){
        console.log('----查询到后台咨询记录----:', res)
        //开始查询订单是否有效
<<<<<<< HEAD
        _this.queryConsuIsOpen(res.data.data.oid);
  
=======
        // var flag=_this.queryConsuIsOpen(res.data.data.oid);
        _this.queryConsuIsOpen(res.data.data.oid);
        console.log("订单有效")
        wx.navigateTo({
          url: '../consult_chatroom/consult_chatroom?otherId=' + _this.data.doctorUuid + '&oid=' + res.data.data.oid + '&otherImg=' + encodeURIComponent(JSON.stringify(_this.data.doctorImg))+ '&id=' + app.globalData.userInfor.uuid + '&img='
          +  encodeURIComponent(JSON.stringify(app.globalData.userInfor.imgUrl)),
        })
          
>>>>>>> 40a984d6839b33b376eba7f726da846eb85dcd8b
        // //出现异步请求问题
        // if(flag){
        //   console.log("订单有效")
        //   wx.navigateTo({
        //     url: '../consult_chatroom/consult_chatroom?otherId=' + _this.data.doctorUuid + '&oid=' + res.data.data.oid + '&otherImg=' + encodeURIComponent(JSON.stringify(_this.data.doctorImg))+ '&id=' + app.globalData.userInfor.uuid + '&img='
        //     +  encodeURIComponent(JSON.stringify(app.globalData.userInfor.imgUrl)),
        //   })
        // }else{
<<<<<<< HEAD
        console.log("无效则不进入聊天页面")
=======
          console.log("无效则不进入聊天页面")
>>>>>>> 40a984d6839b33b376eba7f726da846eb85dcd8b
        // }
    
      }else{
        console.log('----没有查询到咨询记录----:', res)
      }
    },
      fail(res) {
        console.log('----查询失败----', res)
      }
    })
}
})