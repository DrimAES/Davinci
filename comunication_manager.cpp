#include "comunication_manager.h"

Comunication_manager::Comunication_manager(QObject *parent) : QObject(parent)
{
    init_socketcan();
}

void Comunication_manager::set_auto_brightness(bool flag)
{
    if(flag == ON_AUTO_BRIGHTNESS)
    {
        qDebug()<<"[Comunication_manager] Start auto brightness";
        connect(notifier, SIGNAL(activated(int)), qsock_can, SLOT(slot_read_socketcan(int)));
        is_control_backlight = 1;
    }

    else
    {
        qDebug()<<"[Comunication_manager] Stop auto brightness";
        disconnect(notifier, SIGNAL(activated(int)), qsock_can, SLOT(slot_read_socketcan(int)));
        is_control_backlight = 0;
    }
}

void Comunication_manager::set_is_control_backlight(int flag)
{
    is_control_backlight = flag;
    qDebug() << "Set is control backlight";
    qDebug() << flag;
}

int Comunication_manager::get_is_control_backlight()
{
    return is_control_backlight;
}

void Comunication_manager::init_socketcan()
{
    qsock_can = new QtSocketCan();
    int sock_can = qsock_can->connect_cansocket(BACKEND_NAME);

    notifier = new QSocketNotifier(sock_can, QSocketNotifier::Read, this);
    connect(qsock_can, SIGNAL(sig_send_can_data(can_frame, int)), this, SLOT(slot_get_can_data(can_frame, int)));
}


void Comunication_manager::slot_get_can_data(struct can_frame frame_rd, int recv_byte)
{
    // frame[0] ~ frame[3] : can high_data [ ex.0xABCD -> 0xA:frame[0], 0xD:frame[3]
    // frame[4] ~ frame[7] : can low_data
    uint light_data;
    static int is_changed = 0;
    static int tmp_thres  = -1;

    canid_t can_id = frame_rd.can_id;

    if(can_id == LIGHT_CAN_ID)
    {
        light_data = frame_rd.data[CAN_D_H_IDX] << 8 | frame_rd.data[CAN_D_L_IDX];

        /* Backlight value range : 1 ~ 11 */
        int backlight_val = light_data / (MAX_LIGHT_DATA/MAX_BRIGHTNESS);
        int threshold     = (light_data < 1000);

        /*
        if(tmp_thres == -1)
            tmp_thres = threshold;
        else
        {
            if(tmp_thres != threshold)
                is_changed = 1;

            tmp_thres = threshold;
        }

        if(is_changed)
        {
            backlight_manger.change_backlight(threshold);
            is_changed = 0;
        }
        */


        if(backlight_val == 0)
            backlight_val = 1;
        else if(backlight_val >11)
            backlight_val = 11;

        if(is_control_backlight)
            backlight_manger.change_backlight(backlight_val);
    }
}





