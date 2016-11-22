#include "time_manager.h"

Time_manager::Time_manager(QObject *parent) : QObject(parent)
{

}

/* Get current time & date */
QString Time_manager::get_time()
{
    QDateTime   *date = new QDateTime();
    QDateTime   curDate = date->currentDateTime();
    QString     date_string = curDate.toString(Qt::ISODate);
    QStringList time_par = date_string.split("T");
    QString     time = time_par.at(0)+" "+time_par.at(1);

    return time;
}
