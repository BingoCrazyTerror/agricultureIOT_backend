package com.zhangfuwen.info;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by dean on 4/8/17.
 */
@Entity
@Table(name="t_warning")
public class Warning {
    public static final int WARN_TYPE_UPPER_LIMIT=0;
    public static final int WARN_TYPE_LOWER_LIMIT=1;
    public static final int WARN_STATUS_NEW=1;
    public static final int WARN_STATUS_OUTDATED=0;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name="threshold_id")
    Long thresholdId;

    @Column(name="warn_type")
    int type;

    @Column(name="warn_status")
    int status;

    @Column(name="created")
    Timestamp created;

    @Column(name="closed")
    Timestamp closed;

    @Column(name="readout_id")
    Long readoutId;

    public Warning(Long thresholdId, int type, int status, Long readoutId) {
        this.thresholdId = thresholdId;
        this.type = type;
        this.status = status;
        this.created = this.getCreated();
        this.readoutId = readoutId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getThresholdId() {
        return thresholdId;
    }

    public void setThresholdId(Long thresholdId) {
        this.thresholdId = thresholdId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public Timestamp getClosed() {
        return closed;
    }

    public void setClosed(Timestamp closed) {
        this.closed = closed;
    }

    public Long getReadoutId() {
        return readoutId;
    }

    public void setReadoutId(Long readoutId) {
        this.readoutId = readoutId;
    }
}
