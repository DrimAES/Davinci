#ifndef BACKLIGHT_MANAGER_H
#define BACKLIGHT_MANAGER_H

#include <QObject>
#include <QFile>
#include <QDebug>

class Backlight_manager : public QObject
{
    Q_OBJECT
public:
    explicit Backlight_manager(QObject *parent = 0);
    QFile *backlight_port;

    void init_backlight_port();
    Q_INVOKABLE void change_backlight(int val);

signals:

public slots:
};

#endif // BACKLIGHT_MANAGER_H
