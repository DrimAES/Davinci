#include "comunication_manager.h"

Comunication_manager::Comunication_manager(QObject *parent) : QObject(parent)
{
    init_serial_port("/dev/ttymxc2");
}

void Comunication_manager::init_serial_port(QString port_name)
{
    /*
     * # Set serial port for i.MX6 #
     * Port name    : /dev/ttymxc2
     * BaudRate     : 9600
     * ParityType   : None
     * Data bit     : 8Bit
     * Stop bit     : 1bit
    */
    serial_port = new QextSerialPort(QLatin1String("/dev/ttymxc2"), QextSerialPort::EventDriven);
    serial_port->setBaudRate(BAUD9600);
    serial_port->setFlowControl(FLOW_OFF);
    serial_port->setParity(PAR_NONE);
    serial_port->setDataBits(DATA_8);
    serial_port->setStopBits(STOP_1);
    //set timeouts to 500 ms
    serial_port->setTimeout(10);

    /* Try to open Serial port */
}

void Comunication_manager::set_auto_brightness(bool flag)
{
    if(flag == ON_AUTO_BRIGHTNESS)
    {
        /* If fail to open serial port */
        if(!serial_port->open(QIODevice::ReadWrite))
        {
            qDebug()<<"Fail to open port";
        }

        qDebug()<<"Start auto brightness";
        connect(serial_port,SIGNAL(readyRead()),this,SLOT(slotGetData()));
    }

    else
    {
        qDebug()<<"Stop auto brightness";
        disconnect(serial_port,SIGNAL(readyRead()),this,SLOT(slotGetData()));

        serial_port->close();
    }
}

void Comunication_manager::slotGetData()
{
    QByteArray data = serial_port->readAll();
    QString volt_str(data);


    float volt_num;
    int raw_num;
    unsigned char lcd_britness;

    /* Paring number part */
    /* Data type example : ADC Result: 1.2744 V -> Parsing 1.2744 */
    volt_str = volt_str.mid(12,6);

    /* string to float */
    volt_num = volt_str.toFloat();

    /* voltage to raw data */
    raw_num = (volt_num *1024)/5;

    lcd_britness = (unsigned char)(raw_num/145);
    lcd_britness = 8 - lcd_britness;

    backlight_manger.change_backlight((int)lcd_britness);
}
