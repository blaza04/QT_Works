#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "clicker.h"
#include<QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("first", "Main");


    Clicker newclicker   ;
    //= new Clicker;
    QQmlContext *context = (engine.rootContext());
    context->setContextProperty("clicker",&newclicker);
    //engine.rootContext()->setContextProperty("clicker", &newclicker);




    return app.exec();
}
