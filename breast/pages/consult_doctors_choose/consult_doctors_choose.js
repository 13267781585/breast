// pages/doctors_choose/index.js
var showUtil = require('../../assert/util.js')
const app = getApp();
Page({
  data: {
    showfilter: false, //是否显示下拉筛选
    doctorList: [], //医生列表
    scrolltop: null, //滚动位置
    page: 0,  //分页
    openId: '',
  },
  onLoad: function () { //加载数据渲染页面
    console.log('----进入onload----')
    this.fetchDoctorData();
  },

  onShow:function(options){
    this.onLoad();
    console.log('----进入onshow----')
    if ("doctor" == app.globalData.object) {
      //自定义组件还得给tabBar 添加选中效果
      if (typeof this.getTabBar === 'function' && this.getTabBar()) {
        this.getTabBar().setData({
          selected: 0 //tabBar的下标  doctor tabBar[消息，我的]
        })
      }
    }else{
      //自定义组件还得给tabBar 添加选中效果
      if (typeof this.getTabBar === 'function' && this.getTabBar()) {
        this.getTabBar().setData({
          selected: 2 //tabBar的下标 user tabBar[科普频道，测试，咨询，我的]
        })
      }
    }

    if (app.globalData.userId < 0){
      console.log('userId', app.globalData.userId);
      showUtil.showToLogion();
    }

    var that = this;
    var serverUrl = app.globalData.serverUrl;
    wx.request({
      url: serverUrl + '/score/get?userid=' + app.globalData.userId,
      success: function (res) {
        var score = res.data.data;
        if(score<10){
          that.showToTest();
        }
      }
    })
    
  },

  showToTest:function() {
    wx.showModal({
      title: '提示',
      content: '积分不足！',
      confirmColor: "#d4237a",
      confirmText: '获取积分',
      success(res) {
        if (res.confirm) {
          wx.switchTab({
            url: '../testIndex/testIndex',
          })
          return true;
        } else if (res.cancel) {
          console.log('用户点击取消');
          return false;
        }
      }
    })
  },
  fetchDoctorData: function () {  //获取医生列表
    let _this = this;
    wx.showToast({
      title: '加载中',
      icon: 'loading'
    })

    var newList = app.globalData.doctorList;
    //查询是否已经加载过医生的信息
    if(newList == null || newList.length == 0){
      wx.request({
        url: app.globalData.serverUrl + '/doctor/getAllDoctor',
        method: 'GET',
        success(res) {
          _this.setData({
            doctorList: res.data.data
          })
          console.log('成功获取医生信息：', _this.data.doctorList);
          app.globalData.doctorList = _this.data.doctorList;
          console.log('设置全局医生信息:', app.globalData.doctorList);
        },
        fail(res) {
          console.log('获取医生信息失败！')
        }
      })
    }else{
      this.setData({
        //已经加载过，直接赋值
        doctorList:newList
      })
    }

  },

  to_consultque(e) {
    var index = e.currentTarget.dataset.index;
    var item = this.data.doctorList[index];
    //获取参数
    var doctorUuid = item.uuid;
    var doctorName = item.name;
    var doctorId = item.id;
    var doctorImg = item.imgUrl;
    var openId = item.openId;
    if (app.globalData.userId < 0)
      showUtil.showToLogion()
    else
      wx.navigateTo({
        url: '../consult_questionnaire/consult_questionnaire?doctorUuid=' + doctorUuid + '&doctorName=' + doctorName + '&doctorImg=' + encodeURIComponent(JSON.stringify(doctorImg)) + '&openId=' + openId + '&doctorId=' + doctorId,
      })
  },


//ornNL5BEStOvVApFPROGzx76jfas
  openid: function () {
    var that = this;
    wx.login({
      success: function (res) {
        if (res.code) {
          //获取openId
          wx.request({
            url: 'https://api.weixin.qq.com/sns/jscode2session',
            data: {
              //小程序唯一标识
              appid: 'wxcb08e1f414685d6c',
              //小程序的 app secret
              secret: '889c82d0d898a3d83f176a5e9b44d697',
              grant_type: 'authorization_code',
              js_code: res.code
            },
            method: 'GET',
            header: { 'content-type': 'application/json' },
            success: function (openIdRes) {
              console.info("登录成功返回的openId：" + openIdRes.data.openid);
              that.setData({
                openId: openIdRes.data.openid
              })
             // that.send()
              // 判断openId是否获取成功
              if (openIdRes.data.openid != null & openIdRes.data.openid != undefined) {
                // 有一点需要注意 询问用户 是否授权 那提示 是这API发出的
                wx.getUserInfo({
                  success: function (data) {
                    // 自定义操作
                    // 绑定数据，渲染页面
                    that.setData({

                    });
                  },
                  fail: function (failData) {
                    console.info("用户拒绝授权");
                  }
                });
              } else {
                console.info("获取用户openId失败");
              }
            },
            fail: function (error) {
              console.info("获取用户openId失败");
              console.info(error);
            }
          })
        }
      }
    });
  },
 

})
