#ifndef QTSOCKETCAN_H
#define QTSOCKETCAN_H

#include <QDebug>
#include <QObject>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <linux/can.h>
#include <linux/can/raw.h>
#include <unistd.h>

#define BACKEND_NAME "can0"

#define LIGHT_CAN_ID 0x55
#define SPEED_CAN_ID 0xAA

#define CAN_D_H_IDX 6
#define CAN_D_L_IDX 7

class QtSocketCan : public QObject
{
    Q_OBJECT
public:
    QtSocketCan();
    int connect_cansocket(char *backend_name);
    void disconnect_cansocket(int can_socket);

public slots:
    void slot_read_socketcan(int can_sock);
signals:
    void sig_send_can_data(struct can_frame, int recv_byte);
    void sig_send_can_id(int id);

};

#endif // QTSOCKETCAN_H
