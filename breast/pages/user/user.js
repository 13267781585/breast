const app = getApp();
Page({

  data: {
    userId:-1
  },

  onShow: function (options) {
    this.onLoad();
    // console.log('onload')
    console.log('onShow',app.globalData.userId,app.globalData.object)
    if ("doctor" == app.globalData.object) {
      //自定义组件还得给tabBar 添加选中效果
      if (typeof this.getTabBar === 'function' && this.getTabBar()) {
        this.getTabBar().setData({
          selected: 1 //tabBar的下标  doctor tabBar[消息，我的]
        })
      }
    }else{
      //自定义组件还得给tabBar 添加选中效果
      if (typeof this.getTabBar === 'function' && this.getTabBar()) {
        this.getTabBar().setData({
          selected: 3 //tabBar的下标 user tabBar[科普频道，测试，咨询，我的]
        })
      }
    }

      this.setData({
        userId:app.globalData.userId
      })
  },

  //退出登录 清除存储在本地的信息
  logOut(){
    wx.removeStorageSync('userToken');
    wx.removeStorageSync('userTokenDate');
    wx.removeStorageSync('doctorToken');
    wx.removeStorageSync('doctorTokenDate');
    app.clearPrivacyData();
    this.setData({
      userId:-1
    })
    //断开websocket连接
    app.setUserTabBar();
    app.closeSocket()
    console.log('执行reLaunch',getApp().globalData.tabBarList);
    
    wx.reLaunch({
      url: '/pages/user/user',
    })
  },

  logIn:function(){
    wx.navigateTo({
      url: '../signIndex/signIndex',
    })
  },

  chagetoLogin:function(){
    wx.navigateTo({
      url: '../signIndex/signIndex',
    })
  },
  changeToBabyLine:function(){
       wx.navigateTo({
         url: '../lineIndex/lineIndex',
       })
  },
  changeToques:function(){
    //判断登录用户是 普通用户 还是 医生 
    var object = app.globalData.object;
    if(object == 'user')
      wx.navigateTo({
        url: '../myconsult/myconsult',
      })
     else
      if (object == 'doctor')
        wx.navigateTo({
          url: '../doctor_myconsult/doctor_myconsult',
        })
        else
        wx.showModal({
          title: '提示',
          content: '请先登录',
          confirmColor: "#d4237a",
          confirmText: '去登录',
          success(res) {
            if (res.confirm) {
              wx.navigateTo({
                url: '../signIndex/signIndex',
              })
            } else if (res.cancel) {
              console.log('用户点击取消')
            }
          }
        })
  },
  changeTocoll:function()
  {
    var that = this;
    var serverUrl = app.globalData.serverUrl;
    console.log(serverUrl)
    var cookie = wx.getStorageSync('userToken');
    console.log(cookie)
    if(cookie )
    {
      wx.request({
        header:{
          cookie:cookie
        },
        url:serverUrl+ '/user/check',
        method:'GET',
        success:function(res){
          console.log(res)
          //认证成功，得到userId
          if(res.data.data )
          {
              wx.navigateTo({
                url: '../mycoll/mycoll?userid='+res.data.data,
              })
          }
        }
      })
    }
    else{
      wx.showModal({
        title: '提示',
        content: '请先登录',
        confirmColor:"#d4237a",
        confirmText	:'去登录',
        success (res) {
          if (res.confirm) {
            wx.navigateTo({
              url: '../signIndex/signIndex',
            })
          } else if (res.cancel) {
            console.log('用户点击取消')
          }
        }
      })
    }
  }

})