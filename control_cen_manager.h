#ifndef CONTROL_CEN_MANAGER_H
#define CONTROL_CEN_MANAGER_H

#include <QObject>
#include "comunication_manager.h"
#include "backlight_manager.h"

class Control_cen_manager : public QObject
{
    Q_OBJECT
public:
    explicit Control_cen_manager(QObject *parent = 0);
    Comunication_manager comuni_manager;

    Q_INVOKABLE void start_auto_brightness();
    Q_INVOKABLE void stop_auto_brightness();

signals:

public slots:
};

#endif // CONTROL_CEN_MANAGER_H
