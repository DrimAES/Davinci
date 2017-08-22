#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>

#include <QObject>
#include "app_manager.h"
#include "time_manager.h"
#include "setting_manager.h"
#include "backlight_manager.h"
#include "control_cen_manager.h"
#include "comunication_manager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QScopedPointer<App_manager> app_manager(new App_manager);
    QScopedPointer<Time_manager> time_manager(new Time_manager);
    QScopedPointer<Setting_manager> set_manager(new Setting_manager);
    QScopedPointer<Backlight_manager> back_manager(new Backlight_manager);
    QScopedPointer<Control_cen_manager> con_cen_manager(new Control_cen_manager);
    QScopedPointer<Comunication_manager> comunication_manager(new Comunication_manager);


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/Main_screen.qml")));
    engine.rootContext()->setContextProperty("app_manager",app_manager.data());
    engine.rootContext()->setContextProperty("time_manager",time_manager.data());
    engine.rootContext()->setContextProperty("set_manager",set_manager.data());
    engine.rootContext()->setContextProperty("back_manager",back_manager.data());
    engine.rootContext()->setContextProperty("con_cen_manager",con_cen_manager.data());
    engine.rootContext()->setContextProperty("comunication_manager",comunication_manager.data());


    return app.exec();
}
