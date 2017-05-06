package com.zhangfuwen;

import com.zhangfuwen.collector.*;
import com.zhangfuwen.models.Gateway;
import com.zhangfuwen.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Date;
import java.sql.Timestamp;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by dean on 4/18/17.
 */
@EnableScheduling
@Component
public class CollectorTask {
    public static Config config;
    //该值置空时即重新从数据库读取列表
    public static Iterable<Gateway> gateways=null;
    public static Lock gatewayLock;
    static {
        gatewayLock = new ReentrantLock();
        config = Config.getInstance();
    }

    @Autowired
    ThresholdInfoRepository thresholdInfoRepository;

    @Autowired
    GatewayRepository gatewayRepository;

    @Autowired
    ZigbeeNodeRepository zigbeeNodeRepository;
    @Autowired
    CoilOrSensorRepository coilOrSensorRepository;

    @Autowired
    WarningRepository warningRepository;

    @Scheduled(fixedRate = 1000)
    public void updateSensor() {

        System.out.println("scheduled");
        gatewayLock.lock();
        if(gateways==null) {
            gateways = gatewayRepository.findAll();
        }
        for (Gateway gateway : gateways) {
            if(gateway.lastCollected==null)
            {
                gateway.lastCollected = new Timestamp((new Date()).getTime());
            }
            if( (new Date()).getTime() - gateway.lastCollected.getTime() > gateway.getInterval()*1000  )
            {
                gateway.lastCollected = new Timestamp(((new Date()).getTime()));
            }
            else
            {
                continue;
            }
            if (!config.isDevMode()) {
                try {
                    gateway.init();
                } catch (IOException e) {
                    e.printStackTrace();
                    continue;
                }
            }

            try {
                gateway.collectAndPersist(config.isDevMode(),
                        zigbeeNodeRepository,
                        coilOrSensorRepository,
                        thresholdInfoRepository,
                        warningRepository);
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        gatewayLock.unlock();
    }
}