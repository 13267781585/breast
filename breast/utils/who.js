function setOption(custumOpt, baseLine, data, type,monthDiff,height,weight) {

   var len = baseLine.length;
  var start = 0;
  var end = 0;
  var title;
  if(monthDiff <= 12){
    start = 0;
    end = 13;
  } else if (monthDiff >12 && monthDiff <=36){
    start = 13;
    end=37;
  }else {
    start = 37;
    end = 61
  }
  var xyOpt = {
    xmin: start,
    xmax: end-1,
    ymin: Math.floor((baseLine[0].data[start][1])/5)*5,
    ymax: Math.ceil(baseLine[len-1].data[end-1][1]/5)*5,
  }
  var nameOpt = {
    xName: '年龄(月)',
    yName: '体重(千克)',
    nameLocation: 'middle',
    nameGap: 25,
    nameTextStyle: {
      fontSize: 14,
      color:'black'
    }
  };
  if (type == 'weight') {
    nameOpt.yName = '体重(千克)';
    title='体重生长曲线'
  } else if (type == 'height') {
    nameOpt.yName = '身长/身高(厘米)';
    title='身高生长曲线'
  }
  // var curveBgColor = '#404A59';
  var curveBgColor ="white"

  var seriesData = new Array();
  var legendData = new Array();
  var data1 = baseLine[2];
  var data2 = baseLine[3];
  var data11 = baseLine[0];
  var data22 = baseLine[1];

  //还原数据
  var l = data1.data.length;
  for (var j = 0; j < l; j++) {
      data1.data[j][1] = data11.data[j][1];         
      data2.data[j][1] = data22.data[j][1];
  }
  
  console.log(data1)
  console.log(data2)

  var normalPos30 = data1.data[0][1];  //30%出生正常值
  var normalPos80 = data2.data[0][1];  //80%出生正常值
  var pos80 = 0;    //判断80%发展是在正常水平之上还是之下
  var pos30 = 0;    //判断30%发展是在正常水平之上还是之下
  var whparamter = 10;
  var differ30 = 0;   //和30%正常值的差值
  var differ80 = 0;  //和80%正常值的差值
  var weightUncertain = 1.5; //体重未来不确定因素比值
  var heightUncertain = 1;
  var advice = '';

  if(type=='weight'){
    advice += '宝宝体重';
    if(Math.abs(normalPos80-weight)<0.5){
      advice += '正常，无需更改饮食计划！！！';
    } else if(normalPos80 - weight > 0){
      advice += '低于正常值，建议调整饮食计划，增加饮食分量！！！';
    }else {
      advice += '高于正常值，建议调整饮食计划，少食多餐，减少饮食分量！！！';
    }
  }else{
    advice += '宝宝身高';
    if (normalPos80 - height > 1) {
      advice += '低于正常值，建议调整饮食计划，适量增加营养！！！';
    } else if (Math.abs(normalPos80 - height) < 1) {
      advice += '正常，无需更改饮食计划！！！';
    }else{
      advice += '高于正常值，无需调整饮食计划！！！';
    }
  }

  if (type == 'height'){
    pos80 = height > normalPos80 ? 1 : 0;
    pos30 = height > normalPos30 ? 1 : 0;
    differ30 = Math.abs(height-normalPos30);
    differ80 = Math.abs(height-normalPos80);
  }else{
    pos80 = weight > normalPos80 ? 1 : 0;
    pos30 = weight > normalPos30 ? 1 : 0;
    differ30 = Math.abs(weight - normalPos30);
    differ80 = Math.abs(weight - normalPos80);
  }

  console.log('80%正常值：', normalPos80);
  console.log('30%正常值：', normalPos30);
  console.log('体重：', weight);
  console.log('身高：', height);
  console.log('pos80:',pos80);
  console.log('pos30',pos30);
  
  if (type == 'weight') {
    for (var j = 0; j < l; j++) {
      if(pos30===1){
        data1.data[j][1] += (Math.random() / weightUncertain + differ30 * differ30 / normalPos30);         //用随机数表示未来不确定因素
      }else{
        data1.data[j][1] -= (Math.random() / weightUncertain + differ30 * differ30 / normalPos30);
      }
    }
    for (var j = 0; j < l; j++) {
      if (pos80 === 1) {
        data2.data[j][1] += (Math.random() / weightUncertain + differ80 * differ80 / normalPos80);
      } else {
        data2.data[j][1] -= (Math.random() / weightUncertain + differ80 * differ80 / normalPos80);
      }
    }
  } else if (type == 'height') {
    for (var j = 0; j < l; j++) {
      if(pos30===1){
        data1.data[j][1] += (Math.random() + heightUncertain + differ80 * differ80 / normalPos80);
      }else{
        data1.data[j][1] -= (Math.random() + heightUncertain + differ80 * differ80 / normalPos80);
      }
    }
    for (var j = 0; j < l; j++) {
      if (pos80 === 1) {
        data2.data[j][1] += (Math.random() + heightUncertain + differ30 * differ30 / normalPos30);
      } else {
        data2.data[j][1] -= (Math.random() + heightUncertain + differ30 * differ30 / normalPos30);
      }
    }
  }

  console.log(data1)
  console.log(data2)

  for (var i = 0; i < len; i++) {
    legendData.push(baseLine[i].key);
    seriesData.push(
      {
        name: baseLine[i].key,
        type: 'line',
        smooth: true,
        data: baseLine[i].data.slice(start, end),
        symbolSize: 5,
        symbol: 'circle'
      }
    )
  };
  if (data.length > 0) {
    seriesData.push(
      {
        name: custumOpt.babyName,
        type: 'line',
        showSymbol: true,
        symbolSize: function (val) {
          if (val[2] == '' && val[0] == 0)
            return 0;
          else
            return 12;
        },
        clipOverflow: true,
        itemStyle: {
          normal: {
            color: "blue",
            lineStyle: {
              normal: {
                color: 'blue',
                width: 1
              }
            }
          }
        },
        data: data
      }
    )
  }
  return {
    "message":advice,
    "data": {
      textStyle: {
        // color: '#fff'
        color: 'black'
      },
      backgroundColor: curveBgColor,
      animation: true,
      animationDuration: 1000,
      title: {
        text: title,
        left: 'center',
        top: '6%',
        textStyle: {
          // color: '#fff',
          color: 'black',
          fontSize: '12px'
        },
      },
      legend: {
        X: 300,
        bottom: '7%',
        textStyle: {
          // color: '#ffd285',
          color: 'black'
        },
        data: legendData
      },
      tooltip: {
        show: true,
      },
      grid: {
        left: '6%',
        right: '6%',
        bottom: '25%',
        containLabel: true,
        show: true,

      },

      xAxis: [
        {
          type: 'value',
          min: xyOpt.xmin,
          max: xyOpt.xmax,
          boundaryGap: false,
          name: nameOpt.xName,
          nameLocation: nameOpt.nameLocation,
          nameGap: nameOpt.nameGap,
          nameTextStyle: nameOpt.nameTextStyle,
          "axisTick": {
            "show": false
          },
          axisLabel: {
            textStyle: {
              // color: '#fff'
              color: 'black'
            },
            z: 1
          },
        },
      ],
      yAxis: [
        {
          type: 'value',
          min: xyOpt.ymin,
          max: xyOpt.ymax,
          name: nameOpt.yName,
          nameLocation: nameOpt.nameLocation,
          nameGap: nameOpt.nameGap,
          nameTextStyle: nameOpt.nameTextStyle,
          "axisLine": {
            lineStyle: {
              // color: '#fff'
              color: 'black'
            }
          },
          splitLine: {
            show: true,
            lineStyle: {
              // color: '#fff'
              color: 'black'
            }
          },
          "axisTick": {
            "show": false
          },
          axisLabel: {
            textStyle: {
              // color: '#fff'
              color: 'black'
            },
          },

          z: 2
        },

      ],
      series: seriesData
    }

  };
}



module.exports = {
  setOption: setOption
}