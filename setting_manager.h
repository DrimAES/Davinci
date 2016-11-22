#ifndef SETTING_MANAGER_H
#define SETTING_MANAGER_H

#include <QObject>
#include <QFileInfoList>
#include <QDir>
#include <QDebug>
#include <QProcess>
#include <QFile>
#include <QTextStream>

class Setting_manager : public QObject
{
    Q_OBJECT
public:
    explicit Setting_manager(QObject *parent = 0);
    QFileInfoList res_list;
    QStringList res_name_list;

    Q_INVOKABLE void get_res_list();
    Q_INVOKABLE int get_res_cnt();
    Q_INVOKABLE QString get_res_name(int idx);
    Q_INVOKABLE QString get_background_name();
    Q_INVOKABLE void set_background_name(QString back_name);

    //bookmark
    Q_INVOKABLE QString get_bookmark_name(QString index);
    Q_INVOKABLE void set_bookmark_name(QString index, QString appname);
    Q_INVOKABLE void del_bookmark_name(QString index);


signals:

public slots:
};

#endif // SETTING_MANAGER_H
