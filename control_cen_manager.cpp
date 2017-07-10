#include "control_cen_manager.h"

Control_cen_manager::Control_cen_manager(QObject *parent) : QObject(parent)
{

}

void Control_cen_manager::start_auto_brightness()
{
    qDebug()<<"[Control_cen_manager] Start_auto_brightness";
    comuni_manager.set_auto_brightness(true);
}

void Control_cen_manager::stop_auto_brightness()
{
    qDebug()<<"[Control_cen_manager] Stop_auto_brightness";
    comuni_manager.set_auto_brightness(false);
}

