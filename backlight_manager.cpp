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
    /*
     * # Set serial port for backlight #
     * Port name    : /sys/class/backlight/backlight.17/brightness
     * BaudRate     : 9600
     * ParityType   : None
     * Data bit     : 8Bit
     * Stop bit     : 1bit
    */
    backlight_port = new QextSerialPort(QLatin1String("/sys/class/backlight/backlight/brightness"), QextSerialPort::EventDriven);
    backlight_port->setBaudRate(BAUD9600);
    backlight_port->setFlowControl(FLOW_OFF);
    backlight_port->setParity(PAR_NONE);
    backlight_port->setDataBits(DATA_8);
    backlight_port->setStopBits(STOP_1);
    //set timeouts to 500 ms
    backlight_port->setTimeout(10);


    if(!backlight_port->open(QIODevice::ReadWrite | QIODevice::Truncate))
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

    backlight_port->write(backlight.data());
}
