#ifndef APP_MANAGER_H
#define APP_MANAGER_H

#include <QObject>
#include <QFileInfoList>
#include <QDir>
#include <QDebug>
#include <QProcess>

#include <QThread>

#define MAX_SCREEN_CNT          5
#define MAX_APP_CNT_PER_SCREEN  8


struct app_list_info
{
    QStringList app_list;
    int cnt;
    int id;
};


class App_manager : public QObject
{
    Q_OBJECT
public:
    explicit App_manager(QObject *parent = 0);

    QFileInfoList excuteable_app_list;
    app_list_info list[5];
    int screen_cnt=0;
    int is_running=0;



    Q_INVOKABLE void get_app_list();
    Q_INVOKABLE void start_app(QString app_name, int type_run);
    Q_INVOKABLE QString get_app_name(int screen_id, int icon_id);
    Q_INVOKABLE int get_app_cnt(int screen_id);
    Q_INVOKABLE int get_screen_cnt();
    Q_INVOKABLE QString get_res_file(QString name);
    Q_INVOKABLE void delete_app(QString name);
    Q_INVOKABLE void refresh_dir();
    Q_INVOKABLE int check_is_running();
    Q_INVOKABLE void send_fake_signal();


    void init_list();


signals:
    void finished_app();

public slots:
};

#endif // APP_MANAGER_H
