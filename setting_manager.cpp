#include "setting_manager.h"

Setting_manager::Setting_manager(QObject *parent) : QObject(parent)
{
    get_res_list();
}

void Setting_manager::get_res_list()
{
    QDir dir("/opt/background");

    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Size | QDir::Reversed);

    res_list = dir.entryInfoList();
    for( int i=0 ; i<res_list.size() ; i++ )
    {
        QFileInfo info = res_list.at(i);
        res_name_list.append(info.fileName());
    }
}

int Setting_manager::get_res_cnt()
{
    return res_list.count();
}

QString Setting_manager::get_res_name(int idx)
{
    return res_name_list.at(idx);
}



QString Setting_manager::get_background_name()
{
    QFile file("/opt/background/set_txt/back_setting.txt");
    if (!file.open(QIODevice::ReadWrite | QIODevice::Text))
        return "error";

    QTextStream in_out(&file);
    QString text_data = in_out.readAll();

    /* Check back_setting.txt file */
    /* If there is it , text content return */
    if( text_data.length() > 1 )
    {
        file.close();
        return text_data;
    }

    /* It no there, write 'background.png' to text file and return */
    else
    {
        text_data = "background.png";
        in_out << text_data;
        qDebug()<<"get_background_name"+text_data;

        file.close();
        return text_data;
    }
}

void Setting_manager::set_background_name(QString back_name)
{
    QFile file("/opt/background/set_txt/back_setting.txt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return;

    qDebug()<<"Set background nam"+back_name;
    QTextStream in(&file);
    in << back_name;

    file.close();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
//bookmark
////////////////////////////////////////////////////////////////////////////////////////////////////////
//string app_name
//string res_path_name
/*
 * [1]/[2]/[3]/[4]/[5]
 * ex)
 * 1aaa/2bbb/3ccc/4ddd/5eee
  */
//index rull : 0 or 1 or 2 or 3 or 4
QString Setting_manager::get_bookmark_name(QString index)
{
    /*
     * QString x = "sticky question";
        QString y = "sti";
        x.indexOf(y);               // returns 0
        x.indexOf(y, 1);            // returns 10
        x.indexOf(y, 10);           // returns 10
        x.indexOf(y, 11);           // returns -1
     *
    */

    int nStartIndex = 0;
    int nEndIndex = 0;
    int nAppname = 0;
    QString strAppname = "NULL";
    QString text_data;


    QFile file("/opt/bookmark/bookmark.config");
    if (!file.open(QIODevice::ReadWrite | QIODevice::Text))
    {
        /*
        if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
            return "error";;
        text_data = "0/1/2/3/4/";
        QTextStream in(&file);
        in << text_data;

        file.close();
        */
        //return "error";

        strAppname = "NULL";
        return strAppname;

    }

    QTextStream in_out(&file);
    text_data = in_out.readAll();

    nStartIndex = text_data.indexOf(index);

    nEndIndex = text_data.indexOf("/", nStartIndex);
    nStartIndex = nStartIndex + 1;
    nAppname = nEndIndex - nStartIndex;


    if( nStartIndex == nEndIndex )
    {
        //no bookmark
        qDebug()<<"[sykang] no bookmark";
        strAppname = "NULL";
    }
    else
    {
        strAppname = text_data.mid(nStartIndex, nAppname);
    }


    file.close();

    qDebug()<<"[sykang] get_bookmark_name : " + strAppname;

    return strAppname;

}

//index rull : 0 or 1 or 2 or 3 or 4
void Setting_manager::set_bookmark_name(QString index, QString appname)
{
    int nAddIndex = 0;

    QFile Resdfile("/opt/bookmark/bookmark.config");
    if (!Resdfile.open(QIODevice::ReadWrite | QIODevice::Text))
        return;

    QTextStream in_out(&Resdfile);
    QString text_data = in_out.readAll();

    qDebug()<<"[sykang] read index : " + index;
    qDebug()<<"[sykang] read appname : " + appname;
    qDebug()<<"[sykang] read data : " + text_data;

    //find index
    nAddIndex = text_data.indexOf(index);
    qDebug()<<"[sykang] read nAddIndex : " + nAddIndex;
    nAddIndex = nAddIndex + 1;//reason : 1
    qDebug()<<"[sykang] read nAddIndex : " + nAddIndex;


    //insert
    text_data.insert(nAddIndex, appname);

    qDebug()<<"[sykang] read data : " + text_data;


    Resdfile.close();

    //write file
    QFile Writefile("/opt/bookmark/bookmark.config");
    if (!Writefile.open(QIODevice::WriteOnly | QIODevice::Text))
        return;

    QTextStream in(&Writefile);
    in << text_data;

    Writefile.close();

}

//index rull : 0 or 1 or 2 or 3 or 4
void Setting_manager::del_bookmark_name(QString index)
{
    int nDelStartIndex = 0;
    int nDelEndIndex = 0;
    int nDelLength = 0;

    QFile Resdfile("/opt/bookmark/bookmark.config");
    if (!Resdfile.open(QIODevice::ReadWrite | QIODevice::Text))
        return;

    QTextStream in_out(&Resdfile);
    QString text_data = in_out.readAll();

    qDebug()<<"[sykang] read index : " + index;
    qDebug()<<"[sykang] read data : " + text_data;

    //find index
    nDelStartIndex = text_data.indexOf(index);
    nDelEndIndex = text_data.indexOf("/", nDelStartIndex);
    nDelStartIndex = nDelStartIndex + 1;//reason : 1
    nDelLength = nDelEndIndex - nDelStartIndex;


    //del
    text_data.remove(nDelStartIndex, nDelLength);

    qDebug()<<"[sykang] read data : " + text_data;


    Resdfile.close();

    qDebug()<<text_data;

    //write file
    QFile Writefile("/opt/bookmark/bookmark.config");
    if (!Writefile.open(QIODevice::WriteOnly | QIODevice::Text))
        return;

    QTextStream in(&Writefile);
    in << text_data;

    Writefile.close();

}
