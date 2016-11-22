#ifndef TIME_MANAGER_H
#define TIME_MANAGER_H

#include <QObject>
#include <QDateTime>

class Time_manager : public QObject
{
    Q_OBJECT
public:
    explicit Time_manager(QObject *parent = 0);

    Q_INVOKABLE QString get_time();

signals:

public slots:
};

#endif // TIME_MANAGER_H
