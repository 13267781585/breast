// pages/testButtom/testButtom.js
const app=getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },
  tab1: function() {
     app.globalData.tabBarList =[
      {
        "pagePath": "/pages/doctors_message_list/doctors_message_list",
        "text": "消息",
        "iconPath": "/images/icon/zx1.png",
        "selectedIconPath": "/images/icon/wd2.png"
      },
      {
        "pagePath": "/pages/user/user",
        "text": "我的",
        "iconPath": "/images/icon/wd1.png",
        "selectedIconPath": "/images/icon/wd2.png"
      }
    ]
    wx.switchTab({
      url: '../doctors_message_list/doctors_message_list',
     })
    console.log(app.globalData.tabBarList)
    },
  tab2: function() {
     app.globalData.tabBarList = [
      {
        "pagePath": "/pages/doctors_message_list/doctors_message_list",
        "text": "消息",
        "iconPath": "/images/icon/zx1.png",
        "selectedIconPath": "/images/icon/wd2.png"
      }
    ]
    },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})