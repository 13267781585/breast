package lllr.test.breast.service.impl;

import lllr.test.breast.common.ServerResponse;
import lllr.test.breast.dao.mapper.ConsultOrderMapper;
import lllr.test.breast.dataObject.consult.ConsultOrder;
import lllr.test.breast.service.inter.ConsultOrderService;
import lllr.test.breast.util.ComUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ConsultOrderServiceImpl implements ConsultOrderService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ConsultOrderServiceImpl.class);

    @Autowired
    private ConsultOrderMapper consultOrderMapper;


    @Override
    public ServerResponse<String> AddConsultOrder(ConsultOrder consultOrder) {
        int inNum = consultOrderMapper.insert(consultOrder);
        if( inNum == 1 )
        {
            String oid = consultOrder.getOid();
            return ServerResponse.createBysuccessData(oid);
        }
        return  ServerResponse.createByError();

    }

    @Override
    public ServerResponse<List<ConsultOrder>> selectConsultOrderByUserId(Integer userId) {
        List<ConsultOrder> orderLists = consultOrderMapper.selectConsultOrderAndDoctorByUserId(userId);
        LOGGER.info("selectConsultOrderByUserId： " + orderLists);
        return ServerResponse.createBysuccessData(orderLists);
    }

    @Override
    public ServerResponse<List<ConsultOrder>> selectConsultOrderByDoctorId(Integer doctorId) {
        List<ConsultOrder> orderLists = consultOrderMapper.selectConsultOrderAndUserByDoctorId(doctorId);
        return ServerResponse.createBysuccessData(orderLists);
    }

    @Override
    public ServerResponse<ConsultOrder> selectByOid(String oid) {
        if(oid == null)
            return ServerResponse.createByErrorMsg("订单参数错误");
        return ServerResponse.createBysuccessData(consultOrderMapper.getByOid(oid));
    }

    @Override
    public ServerResponse updateConsultOrderStatusById(Integer id, Integer status) {
        return consultOrderMapper.updateConsultOrderStatusById(id,status) == 1 ? ServerResponse.createBysuccess() : ServerResponse.createByError();
    }

    @Override
    public ServerResponse<ConsultOrder> selectConsultByUserIdAndDoctorId(Integer userId, Integer doctorId) {
        List<ConsultOrder> resultConsultOrder=consultOrderMapper.selectConsultByUserIdAndDoctorId(userId,doctorId);
        if(resultConsultOrder==null||resultConsultOrder.size()<=0){
            return ServerResponse.createByErrorMsg("没有查到咨询订单");
        }
        return ServerResponse.createBysuccessData(resultConsultOrder.get(resultConsultOrder.size()-1));
    }

    @Override
    public ServerResponse<String> getConsultStatus(String oid) {
        ConsultOrder consultOrder=consultOrderMapper.getByOid(oid);
        //判断是否有效
        Date createTime = consultOrder.getCreateTime();
        Integer lastingTime = consultOrder.getLastingTime();

        //Long currentTime=new Date().getTime();
        Long createTime_long=createTime.getTime();
        Long lastingTime_long=(long)lastingTime;
        Long currentTime=System.currentTimeMillis();

        if(currentTime-createTime_long>lastingTime_long){
            return ServerResponse.createByErrorMsg("consult_isClose");
        }else {
            return ServerResponse.createBysuccessMsg("consult_isOpen");
        }
    }

    @Override
    public ServerResponse<ConsultOrder> updateConsultOrder(ConsultOrder consultOrder) {
        Integer id = consultOrder.getId();
        Integer userId = consultOrder.getUserId();
        Integer doctorId = consultOrder.getDoctorId();
        String oid = consultOrder.getOid();
        ConsultOrder dataObject = null;
        //通过id或者oid查询订单
        if(id != null)
            dataObject = consultOrderMapper.selectById(id);
        else if(oid != null)
            dataObject = consultOrderMapper.getByOid(oid);

        //校验订单是否存在
        if(dataObject == null || !ComUtils.isStrEqual(oid,dataObject.getOid())
                || !dataObject.getUserId().equals(userId) || !dataObject.getDoctorId().equals(doctorId))
            return ServerResponse.createByError();

        int num = 0;
        if(id != null)
            num = consultOrderMapper.updateByPrimaryKeySelective(consultOrder);
        else
            if(!ComUtils.isEmpty(oid))
                num = consultOrderMapper.updateByOid(consultOrder);

        if(id != null)
            dataObject = consultOrderMapper.selectById(id);
        else if(!ComUtils.isEmpty(oid))
            dataObject = consultOrderMapper.getByOid(oid);

        return num == 1 ? ServerResponse.createBysuccessData(dataObject) : ServerResponse.createByError();

    }


}
