var app = getApp();
Page({
  data: {
    tid:0,
    currentIndex: 0,
    title: "",
    type: 0,
    options: [],
    resData: [],
    userId:-1,
    answer: '',
  },
  onLoad: function (options) {
    var id = options.id;
    console.log(id)
    this.getQuestion(id)
    this.setData({
      tid:id,
      userId:app.globalData.userId
    })
  },

  //获取问卷题目
  getQuestion: function (id) {
    var that = this;
    var serverUrl = app.globalData.serverUrl;
    wx.request({
      url: serverUrl + '/question/getQustions',
      method: 'GET',
      data: {
        tid: id
      },
      success: function (res) {
        console.log('问卷：',res.data.data)
        that.setData({
          resData: res.data.data,
          currentIndex: 0
        })
        that.initData();
      }
    })
  },

  initData: function () {
    //返回题目数组
    var questionList = this.data.resData;
    //index--第几题
    var index = this.data.currentIndex;
    console.log(index)
    //清空数据
    this.setData({
      options:[]
    })
    //选项
    var optionList = new Array();
    optionList = questionList[index].qOpstions.split('|');
    //选项处理

    for (var i = 0; i < optionList.length; i++) {
      var opStr = "options[" + i + "].option";
      var selectStr = "options[" + i + "].selected";
      this.setData({
        [opStr]: optionList[i],
        [selectStr]: -1
      })
      console.log(this.data.options)
    }
    this.setData({
      title: questionList[index].qContent,
      type: questionList[index].qType,
      answer: questionList[index].qAnswer
    })

    
  },
  selectOp: function (event) {
    console.log(event)
    var idx = event.currentTarget.dataset.index;
    var before_select = this.data.options[idx].selected;
    var str = "options[" + idx + "].selected";
    this.setData({
      [str]: before_select * (-1)
    })
  },
  nextOp: function () {
    var that = this;
    var serverUrl = app.globalData.serverUrl;
    console.log(this.data.currentIndex+"----"+this.data.resData.length)
   // console.log(this.data.resData.length)
    //如果已经是最后一题
    if (this.data.currentIndex == this.data.resData.length - 1) {
        if(that.data.userId!=-1){
          wx.request({
            url: serverUrl + '/score/update',
            data: {
              userid: that.data.userId,
              score: 10
            },
            success: function (res) {
              wx.showToast({
                title: '积分+10!',
              })
              wx.switchTab({
                url: '../testIndex/testIndex',
              })
              return;
            }
          })
        }else{
          wx.switchTab({
            url: '../testIndex/testIndex',
          })
        }
      
    } 
    else{    
      var options = this.data.options;
      var str="";
      var count =0;
      for(var i=0;i<options.length;i++)
      {
         if(options[i].selected == 1)
         {
           str  += options[i].option + "|";
           count ++;
         }
            
      }
      //没选
      if(count == 0)
      {
        wx.showToast({
          title: '请做出选择',
          icon:"none"
        })
        return;
      }
      else if(count > 1 && this.data.type== 1)
      {
        wx.showToast({
          title: '单选题只能做一个选择',
          icon:'none'
        })
        return;
      }
      else if(count ==1 && this.data.type == 2)
      {
        wx.showToast({
          title: '多选题至少做出两个选择',
          icon:'none'
        })
        return;
      }
      wx.showToast({
        title: '正确答案：' + this.data.answer,
      })
      //存到数据库
      wx.request({
        url: serverUrl+ '/user/insertAnswers',
        method:"GET",
        data:{
          userid: that.data.userId,
          tid:this.data.tid,
          answers:str
        },
        success:function(res){
           console.log(res)
        }
  
      }) 

      var oldIdx = this.data.currentIndex;
       this.setData({
         currentIndex:oldIdx+1
       })
       this.initData();
    }
   
  },
})

