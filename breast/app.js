//app.js
const url_pre = 'http://api.tszh.wiwcc.com';
App({
  onLaunch: function () {
    wx.getSystemInfo({
      success: e => {
        this.globalData.StatusBar = e.statusBarHeight;
        let capsule = wx.getMenuButtonBoundingClientRect();
		if (capsule) {
		 	this.globalData.Custom = capsule;
			this.globalData.CustomBar = capsule.bottom + capsule.top - e.statusBarHeight;
		} else {
			this.globalData.CustomBar = e.statusBarHeight + 50;
		}
      }
    })
  },
  onShow(){
    //查询是否存有 token => 登录
    this.tokenSign()
    //加载 微信小程序 唯一标识符
    this.getOpenId()
      //请求医生列表
    this.getDoctorList()
  },

  onHide(){
    this.closeSocket()
  },

//当小程序从前台进入后台，关闭websocket
  closeSocket(){
    console.log('关闭websocket连接')

    wx.closeSocket();
  },

  globalData: {
    // serverWssUrl: 'wss://mombabyai.cn/websocket/', 
    // serverUrl: 'https://mombabyai.cn',
    serverWssUrl: 'ws://localhost:8088/websocket', 
    serverUrl: 'http://localhost:8088',
    salt : "fdsfvxnmcvnew68sa5d54ds",
    userId:-1, //表示登录用户的id 无论是医生还是普通用户
    object:'',  //登录的用户群体：1.医生 2.普通用户
    userInfor:null,   //记录用户的信息
    doctorList:[],       //医生列表
    consultOrderList:[],  //医生端存放 咨询订单
    //不同账号需要更改 密匙 否则 获取 openid将出错
    APP_ID: 'wxfbebd90d9bf59e52',
    APP_SECRET: '939f54b21647f5d6bf05feb58ece72bf',
    openId:'',//微信小程序用户标识符
    messageNoticeTmpId:'ZUBuHw56XW-d-loTKSOO5OJiLRcR4Moj87U7QN0iweA',
  },

  //清除记录的隐私数据=》 用于 用户退出登录时调用
  clearPrivacyData(){
    this.globalData.userId = -1;
    this.globalData.object = '',
    this.globalData.userInfor = null
  },

  connectServerByWs(){
    //判断是 普通用户 还是 医生 在线
    console.log('登录用户信息',this.globalData.userInfor)
    wx.connectSocket({
      // 本地服务器地址
      url: this.globalData.serverWssUrl + '/' + this.globalData.userInfor.uuid
    })
   
    // 连接成功
    wx.onSocketOpen(function () {
      console.log('连接成功');
    })
  },

//从服务端获取医生信息
  getDoctorList(){
    var that = this;

    wx.request({
      url: this.globalData.serverUrl + '/doctor/getAllDoctor',
      method: 'GET',
      success(res) {
        that.globalData.doctorList = res.data.data
        console.log('成功获取医生信息：', that.globalData.doctorList);
      },
      fail(res) {
        console.log('获取医生信息失败！')
      }
    })
  },

  //根据 咨询订单id 查询  返回订单具体信息
  findConsultOrderById(n) {
    console.log('app consultOrderList:', this.globalData.consultOrderList)

    for (var i = 0; i < this.globalData.consultOrderList.length; i++)
      if (this.globalData.consultOrderList[i].id == n) {
        console.log('app.js :', this.globalData.consultOrderList[i])
        return this.globalData.consultOrderList[i];
      }
  },

  //医生结束订单时 修改订单的状态
  updateConsultOrderStatusById(id,status){
    console.log('id status:',id,status)
    for (var i = 0; i < this.globalData.consultOrderList.length; i++)
      if (this.globalData.consultOrderList[i].id == id) {
        console.log('app.js :', this.globalData.consultOrderList[i])
        this.globalData.consultOrderList[i].status = status;
      }
  },

  //根据 医生的id 查询 doctorList 返回医生具体信息
  findDoctorById(n){
    console.log('app doctorList:',this.globalData.doctorList)

    for (var i = 0; i < this.globalData.doctorList.length; i++)
      if (this.globalData.doctorList[i].id == n) {
        console.log('app.js :', this.globalData.doctorList[i])
        return this.globalData.doctorList[i];
      }
  },

  // js 格式化 date 对象，输出格式为 yyyy-MM-dd HH:mm:ss 字符串
  jsDateFormatter(dateInput) {  // dateInput 是一个 js 的 Date 对象
    var year = dateInput.getFullYear();
    var month = dateInput.getMonth() + 1;
    var theDate = dateInput.getDate();

    var hour = dateInput.getHours();
    var minute = dateInput.getMinutes();
    var second = dateInput.getSeconds();

    if(month < 10) {
      month = '0' + month;
    }

        if(theDate < 10) {
      theDate = '0' + theDate;
    }

        if(hour < 10) {
      hour = '0' + hour;
    }

        if(minute < 10) {
      minute = '0' + minute;
    }

        if(second < 10) {
      second = '0' + second;
    }

        return year + "-" + month + "-" + theDate + " " + hour + ":" + minute + ":" + second;
  },
 

  //判断是否存在 token  若有则自动登录
  tokenSign(){
    var that = this;
    //分别获取 用户的token  和 医生的token
    var doctorToken = wx.getStorageSync('doctorToken');
    var doctorTokenDate = wx.getStorageSync('doctorTokenDate');
    var userToken = wx.getStorageSync('userToken');
    var userTokenDate = wx.getStorageSync('userTokenDate');

    //当前时间
    var now = (new Date()).getTime();
    console.log(doctorToken + ' ' + doctorTokenDate + ' ' + userToken + ' ' + userTokenDate + ' ' + now);

    if(doctorToken != '' && doctorToken != null){
      console.log('doctorToken 不为空！');
      //判断token 是否 过期
      if(doctorTokenDate - now > 0){
        wx.request({
          url: this.globalData.serverUrl + '/doctor/tokenSign',
          method:"POST",
          header: {
            'content-type': 'application/x-www-form-urlencoded' // 默认值
          },
          data:{
            doctor_token:doctorToken,
          },
          success:function(res){
            //设置 返回 的用户数据
            that.globalData.object = 'doctor';
            that.globalData.userInfor = res.data.data;
            that.globalData.userId = res.data.data.id;
            console.log('doctorToken 登录成功', that.globalData.userInfor);
            //连接websocket
            that.connectServerByWs();
            //当成功连接ws后跳转到消息列表页面
            wx.onSocketOpen(function(){
              console.log('连接成功，跳转消息列表页面')
              wx.navigateTo({
                url: '/pages/doctor_message_list/doctor_message_list',
              })
            })
          },
          fail:function(res){
            console.log('token 登录失败')
          }
        })
      }else{
        //token 过期了 将该值去除
        console.log('doctorToken 过期了 去除!')
        wx.removeStorageSync('doctorToken');
        wx.removeStorageSync('doctorTokenDate');
      }
    }else
      if (userToken != '' && userToken != null) {
        console.log('userToken 不为空！');
        //token没有过期
        if (userTokenDate - now > 0) {
          wx.request({
            url: this.globalData.serverUrl + '/user/tokenSign',
            method: "POST",
            header: {
              'content-type': 'application/x-www-form-urlencoded' // 默认值
            },
            data: {
              user_token: userToken,
            },
            success: function (res) {
              //设置 返回 的用户数据
              that.globalData.object = 'user';
              that.globalData.userInfor = res.data.data;
              that.globalData.userId = res.data.data.userId;
              console.log('userToken 登录成功', that.globalData.userInfor);
              //连接websocket
              that.connectServerByWs()
            },
            fail: function (res) {
              console.log('token 登录失败')
            }
          })
        } else {
          //token 过期了 将该值去除
          console.log('userToken 过期了 去除!')
          wx.removeStorageSync('userToken');
          wx.removeStorageSync('userTokenDate');
        }
      }
  
  },
  //获取  微信小程序 中 用户的唯一标识符
    getOpenId(){
      var code = '';
      var that = this;
      wx.login({
        success(res) {
          console.log('参数：', res)
          console.log('wx.login code:',res.code)
          code = res.code;
            wx.request({
              url: that.globalData.serverUrl + '/wx/getOpenId',
              method: 'GET',
              data: {
                code: code
              },
              success(res) {
                console.log('success:', res)
                that.globalData.openId=res.data.data;
                console.log('app global openid:',that.globalData.openId)
              },
              fail(res) {
                console.log('fail:', res)
              }
            })
        }
      })
      
    },

})