

var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
      testList:[],
      userInfo:[],
      userId:-1,
      score:0,
  },

  onLoad: function (options) {
    this.getTests();
  },

  onShow:function(options){
    //自定义组件还得给tabBar 添加选中效果
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({
        selected:1 //tabBar的下标 user tabBar[科普频道，测试，咨询，我的]
      })
    }
    //获取用户的userid
    this.checkUserId();
  },

  getTests:function(){
      var serverUrl = app.globalData.serverUrl;
      var that = this;
      wx.request({
        url: serverUrl + "/test/getTestList",
        method:"GET",
        success:function(res){
            console.log(res.data.data)
             that.setData({
               testList:res.data.data
             })
        }
      })
  },
  chageToOp:function(event)
  {
    var index  = event.currentTarget.dataset.index;
    console.log(index);
    var id = this.data.testList[index].id;
    console.log("id--"+id);
    wx.navigateTo({
      url: '../question/question?id=' + id + '&userId=' + this.data.userId,
    })
  },
  //检查用户是否登录
  checkUserId: function () {
    var userId = app.globalData.userId;
    this.setData({
      userId:userId
    })
    if(userId < 0)
      wx.showToast({
        title: '要登录才能获取积分',
        icon: 'none'
      })
  },
  //获取积分
  getScore(){
    var that =this;
    var serverUrl = app.globalData.serverUrl;
    wx.request({
      url:serverUrl + '/score/get',
      data:{
        userId: that.data.userId
      },
      success:function(res){
          console.log("积分----");
          console.log(res)   
          that.setData({
            score:res.data.data
          })
          }   
    })
  }
})