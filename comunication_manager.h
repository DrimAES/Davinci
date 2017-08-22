#ifndef COMUNICATION_MANAGER_H
#define COMUNICATION_MANAGER_H

#include <QObject>
#include <QDebug>
#include <QtCore/qsocketnotifier.h>
#include "backlight_manager.h"
#include "qtsocketcan.h"
#include <QTimer>
#include <linux/can.h>

#define ON_AUTO_BRIGHTNESS true
#define OFF_AUTO_BRIGHTNESS false

#define MAX_LIGHT_DATA 5000
#define MAX_BRIGHTNESS 11
#define LOW_BRIGHTNESS 1



class Comunication_manager : public QObject
{
    Q_OBJECT
public:
    explicit Comunication_manager(QObject *parent = 0);
    Q_INVOKABLE void set_auto_brightness(bool flag);
    Q_INVOKABLE void set_is_control_backlight(int flag);
    Q_INVOKABLE int get_is_control_backlight();
    bool auto_brightness_flag;

    Backlight_manager backlight_manger;
    QtSocketCan *qsock_can;
    QSocketNotifier *notifier;
    int is_control_backlight=0;

signals:


private:
    void init_socketcan();

public slots:
    void slot_get_can_data(struct can_frame frame_rd, int recv_byte);

signals:
    void changeBritness(char value);
};

#endif // COMUNICATION_MANAGER_H
