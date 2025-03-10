#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "navigation.h"

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
    QQmlContext *context (engine.rootContext());
    Navigation nav;
    context->setContextProperty("nav",&nav);

    engine.loadFromModule("Map_support", "Main");

    return app.exec();
}
