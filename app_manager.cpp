#include "app_manager.h"
#include <QList>

App_manager::App_manager(QObject *parent) : QObject(parent)
{
    get_app_list();
}

void App_manager::get_app_list()
{
    QDir dir("/opt");

    int remain_app_cnt;

    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Name | QDir::Reversed);



    init_list();

    excuteable_app_list = dir.entryInfoList();
    screen_cnt = 0;

    for (int i = 1; i <= excuteable_app_list.size(); i++)
    {

        QFileInfo appInfo = excuteable_app_list.at(i-1);
        list[screen_cnt].app_list.append(appInfo.fileName());

        if(( i % (MAX_APP_CNT_PER_SCREEN) ) == 0 )
        {
            list[screen_cnt].cnt = MAX_APP_CNT_PER_SCREEN;
            screen_cnt+=1;
        }
    }

    remain_app_cnt = excuteable_app_list.size()-(MAX_APP_CNT_PER_SCREEN*(screen_cnt));
    if(remain_app_cnt!=0)
        list[screen_cnt].cnt = remain_app_cnt;
}

void App_manager::start_app(QString app_name)
{

     /* For eglfs */
     QString program = "/opt/" + app_name + " -platform eglfs";
     QByteArray prog_name = program.toLocal8Bit();

     system(prog_name.data());


     /* For wayland */
     /*QString program = "/opt/"+app_name;
     QStringList commandAndParameters;
     commandAndParameters << "";

     QProcess *myprocess = new QProcess(this);
     myprocess->start(program);
     */
}

QString App_manager::get_app_name(int screen_id, int icon_id)
{
    return list[screen_id].app_list.at(icon_id);
}

int App_manager::get_app_cnt(int screen_id)
{
    return list[screen_id].cnt;
}

int App_manager::get_screen_cnt()
{ 
    return screen_cnt+1;
}

QString App_manager::get_res_file(QString name)
{

    QDir dir("/opt/res");
    QString app_name = name + ".png";
    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Size | QDir::Reversed);

    QFileInfoList res_list = dir.entryInfoList();

    for( int i=0 ; i<res_list.size() ; i++ )
    {
        QFileInfo info = res_list.at(i);
            if(app_name == info.fileName())
            {
                QString res_dir = "file://opt/res/"+name+".png";

                return res_dir;
            }
    }

    return "file://opt/res/no_image.png";
}

void App_manager::delete_app(QString name)
{
    QString program = "rm /opt/" + name;
    QByteArray prog_name = program.toLocal8Bit();


    system(prog_name.data());
}

void App_manager::refresh_dir()
{
    get_app_list();
}

void App_manager::init_list()
{
    for(int i=0;i<MAX_SCREEN_CNT;i++)
    {
        list[i].app_list.clear();
        list[i].cnt = 0;
        list[i].id  = 0;
    }
}
