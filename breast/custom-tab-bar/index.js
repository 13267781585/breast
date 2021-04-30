const app=getApp();
Component({
  data: {
    selected: 0,
    color: "#7A7E83",
    selectedColor: "#3cc51f",
    "tabBarList": []
  },
  lifetimes:{
    attached() {
      this.setData({
        tabBarList:app.globalData.tabBarList
      })
    },
  },
 
  methods: {
    switchTab(e) {
      const data = e.currentTarget.dataset
      const url = data.path
      wx.switchTab({url})
      this.setData({
        selected: data.index
      })
    }
  }
})