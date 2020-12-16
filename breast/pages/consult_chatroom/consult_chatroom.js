const app = getApp();
Page({
  // 初始页面数据
  data: {
    otherId: '', //对方的标识符
    id: '',
    oid: '', //咨询订单的标识符
    scrollTop: 0,
    consultOrder:{},
    InputBottom: 0,
    list: [],
    otherImg: '', //对方的头像
    img:'',  //自己得头像链接
    object:'',
    message:"", //消息内容
    userHeadPictureUrl: 'http://llllllllr.top/doctorRegister_1585797161.jpg',  //用户备用头像
  },
  // 监听页面加载
  onLoad: function (options) {
    var oImg = options.otherImg == undefined || options.otherImg == null ? this.data.userHeadPictureUrl : options.otherImg;
    console.log('参数：', options)
    this.setData({
      object:app.globalData.object,
      id: options.id,
      oid: options.oid,
      otherId: options.otherId,    
      otherImg: oImg,
      img:options.img
    })
    wx.showToast({
      title: '连接中',
      icon: 'loading'
    }),

      //获取之前聊天记录
    this.getAllWeChatItem();

    //监听服务器消息
    this.listenServerMessage();
  },

//获取之前聊天记录
  getAllWeChatItem(){
    var json_object = { "type":"getAllWeChatItemById","toUuid":this.data.otherId,"fromUuid":this.data.id,"oid":this.data.oid};
    var json_str = JSON.stringify(json_object);
    console.log('json_str'+json_str),
    wx.sendSocketMessage({
      data: json_str,
    })
  },

  listenServerMessage(){
    wx.onSocketMessage(msg => {
      console.log('收到消息为:', msg)
      //将 从 服务器 得到 的 消息数据 进行 解析 为 JSON
      var json_object = JSON.parse(msg.data);
      console.log('转化后的消息为:', json_object)

    //判断消息的类型
      var type = json_object.type;
      if (type != 'returnAllWeChatItemById')
        return ;
        var data = json_object.data;
      var newList = this.data.list;
      //将消息加入表中
      for (var i = 0; i < data.length; i++) {
        //格式化 日期 的格式
        var time = data[i].time;
        data[i].time = app.jsDateFormatter(new Date(time));
        newList.push(data[i]);
      }
      this.setData({
        list: newList
      });

      console.log('设置后的list：', this.data.list)

      this.rollingBottom()
    })

  },

//设置 消息内容
  handleMessage(e){
    console.log('消息内容:',e.detail.value)
    this.setData({
      message: e.detail.value
    })
  },

//设置 消息内容
  clearMessage(){
    this.setData({
      message:""
    })
  },

  // 发送内容
  //点击发送 消息 按钮
  send: function () {
    // 判断发送内容是否为空
    if (this.data.message.length != 0) {
      console.log('订单oid:',this.data.oid)
      //判断是 登录 用户 是 医生 还是 普通用户
      if(this.data.object == 'user')
        var msg = {
          fromUuid: this.data.id,
          toUuid: this.data.otherId,
          messageType: 0,                 // 消息类型  文字 图片
          messageContent: this.data.message,
          time: app.jsDateFormatter(new Date()),   //时间
          oid: this.data.oid  //咨询 所属 的 咨询订单
        }
        else
        var msg = {
          fromUuid: this.data.otherId,
          toUuid: this.data.id,
          messageType: 0,                 // 消息类型  文字 图片
          messageContent: this.data.message,
          time: app.jsDateFormatter(new Date()),   //时间
          oid: this.data.oid  //咨询 所属 的 咨询订单
        }

      //将 msg 对象 转化为 JSON 字符串
      var msgStr = JSON.stringify(msg);
      console.log(msgStr)
      wx.sendSocketMessage({
        data: msgStr,
      })
      // 将自己的 消息 放入 聊天列表
      console.log(this.data.list)
      var newList = this.data.list;
      newList.push(msg)

      this.setData({
        list: newList
      });
      console.log(this.data.list)
      this.rollingBottom()
    } else {
      // 弹出提示框
      wx.showToast({
        title: '消息不能为空哦~',
        icon: 'none',
        duration: 2000
      })
      return;
    }
    //发送 消息通知
    this.sendMessageNotice()
    this.clearMessage();
  },

  // 聊天内容始终显示在最低端
  rollingBottom(e) {
    wx.createSelectorQuery().selectAll('.list').boundingClientRect(rects => {
      rects.forEach(rect => {
        this.setData({
          scrollTop: rect.bottom
        })
      })
    }).exec()
  },

  //发送 消息 通知 医生有用户消息
  sendMessageNotice() {
    var accessToken = '';
    var that = this;
  
    var msg = { "touser": app.globalData.openId, "template_id": app.globalData.messageNoticeTmpId,
      "data":{
"name1": { "value": app.globalData.userInfor.userName }, "time3": { "value": app.jsDateFormatter(new Date()) }, "thing2": { "value": that.data.message }, "thing7": { "value": "请您在空闲时间尽快回复！"}
      }
    };
    var json_str = JSON.stringify(msg);
    console.log("json_str:",json_str);
//发送通知
    wx.request({
      url: app.globalData.serverUrl + '/wx/sendMessageNotice',
      method: 'POST',
      header: {
        'content-type': 'application/x-www-form-urlencoded' // 默认值
      },
      data:{
        message:json_str
      },
      success(res) {
        console.log('消息推送发送成功:', res)
      },
      fail(res) {
        console.log('消息推送发送失败:', res)
      }
    })
  },
  
  /*图片模块 */
  //上传图片的token
  getToken: function () {
    var that = this;
    wx.request({
      url: getApp().globalData.serverUrl + '/article/getToken',
      method: 'GET',
      data: {
        bucket: 'useravatarr'
      },
      success: function (res) {
        console.log(res)
        that.setData({
          imgToken: res.data
        })
      }
    })
  },
  //这里待修改，等提交再传云端
  ChooseImage() {
    var that = this;
    var qiniu_key = this.data.userid + "consult_" + Date.parse(new Date()) / 1000 + ".jpg";
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
            domain: 'http://q6le31s3c.bkt.clouddn.com/', // // bucket 域名，下载资源时用到。如果设置，会在 success callback 的 res 参数加上可以直接使用的 ImageURL 字段。否则需要自己拼接
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


})
