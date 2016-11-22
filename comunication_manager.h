#ifndef COMUNICATION_MANAGER_H
#define COMUNICATION_MANAGER_H

#include <QObject>
#include <QDebug>
#include "src/qextserialport.h"
#include "backlight_manager.h"

#define ON_AUTO_BRIGHTNESS true
#define OFF_AUTO_BRIGHTNESS false



class Comunication_manager : public QObject
{
    Q_OBJECT
public:
    explicit Comunication_manager(QObject *parent = 0);
    void init_serial_port(QString port_name);
    Q_INVOKABLE void set_auto_brightness(bool flag);

    bool auto_brightness_flag;

    Backlight_manager backlight_manger;


signals:


private:
     QextSerialPort *serial_port;

public slots:
    void slotGetData();

signals:
    void changeBritness(char value);
};

#endif // COMUNICATION_MANAGER_H
