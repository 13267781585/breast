var showUtil = require('../../assert/util.js')
const app = getApp();
Page({
  data: {
    messageList:[],   //消息数组
    object: null,
    uuid:''
  },

  onLoad(){
    this.setData({
      object:app.globalData.object,
      uuid:app.globalData.userInfor.uuid
    })
  },

  onShow(){
      this.selectMessageList();
      this.listenServerMessage();
  },

  //请求医生消息列表
  selectMessageList(){
    var json_object = { "type": "selectDoctorMessageList","doctorUuid":this.data.uuid,"uuid":this.data.uuid};
    var json_str = JSON.stringify(json_object);
    console.log('请求医生消息列表str:',json_str);
    wx.sendSocketMessage({
      data: json_str,
    })
  },

  //跳转聊天页面
  to_chatroom(option){
    console.log(option)
    var otherId = option.currentTarget.id;
    var data_list = this.data.messageList;
    var target = null;
    for(var i = 0; i < data_list.length; i++){
      if (data_list[i].user.uuid == otherId)
        target = data_list[i];
    }
    var id = this.data.uuid;
    var otherImg = target.user.imgUrl;
    var oid = target.weChatMessageItem.oid;
    var img = app.globalData.userInfor.imgUrl;
    wx.navigateTo({
      url: '../consult_chatroom/consult_chatroom?otherId=' + otherId + '&oid=' + oid + '&otherImg=' + otherImg + '&id=' + id + '&img=' + img,
    })
  },

  //监听服务器消息
  listenServerMessage() {
    wx.onSocketMessage(msg => {
      console.log('收到消息为:', msg)
      //将 从 服务器 得到 的 消息数据 进行 解析 为 JSON
      var json_object = JSON.parse(msg.data);
      console.log('转化后的消息为:', json_object)

      //判断消息的类型
      var type = json_object.type;

      if (type == 'returnDoctorMessageList')   //接收医生消息列表
      {
        var doctorUuid = json_object.doctorUuid;
        if(doctorUuid == this.data.uuid){
          var data = json_object.data;
          console.log('收到消息列表为:', data)
          this.setData({
            messageList: data
          });
        } 
      } else
        if (type == 'acceptWeChatItemFromOther') {         //对方给我发送消息
        var toUuid = json_object.toUuid;
        var fromUuid = json_object.fromUuid;
          //判断是否是这个订单的聊天
          if (this.data.uuid != toUuid)
            return;
          var data = json_object.data;
          var data_list = this.data.messageList;
          //搜索接收到消息的是否在消息列表
          var i = 0;
          for(; i < data_list.length; i++){
            if(data_list[i].user.uuid == fromUuid){
              data_list[i].weChatMessageItem = data;
              data_list[i].unReadTextNum++;
              this.setData({
                messageList:data_list
              })
            }
            console.log('更新后的messageList', this.data.messageList)
          }
        //如果接收到的消息用户不在消息列表,重新获取消息列表
        if( i == data_list.length)
          this.selectMessageList();
        }
      console.log('设置后的messageList：', this.data.messageList)
    })

  },
  
})
