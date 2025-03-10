#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "myclass.h"
#include <QQmlContext>

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
    engine.loadFromModule("third", "Main");


    myclass MyClass ;
    QQmlContext *context(engine.rootContext());
    context->setContextProperty("myClass", &MyClass);
    //engine.rootContext()->setContextProperty("myClass", &MyClass);
    return app.exec();
}
