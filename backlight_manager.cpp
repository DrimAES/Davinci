#include "backlight_manager.h"

Backlight_manager::Backlight_manager(QObject *parent) : QObject(parent)
{
    init_backlight_port();
}


/*
 * AGL for i.MX6 : can use backlight driver
 * AGL for QEMU  : can't use backlight driver
 */

void Backlight_manager::init_backlight_port()
{

    backlight_port = new QFile();
    backlight_port->setFileName("/sys/class/backlight/backlight/brightness");

    if(!backlight_port->open(QIODevice::WriteOnly | QIODevice::Text
                   | QIODevice::Truncate))
    {
        qDebug()<<"Fail to open backlight port";
    }
}

/* Backlight value range : 1 ~ 7 */
void Backlight_manager::change_backlight(int val)
{
    int backlight_value = val;
    QString tmp;
    QString backlight_val_str = tmp.setNum(backlight_value);
    QByteArray backlight  = backlight_val_str.toLocal8Bit();

    QTextStream out(backlight_port);
    out << backlight.data();
}
