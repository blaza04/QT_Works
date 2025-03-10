#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "discogsapi.h"
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
    engine.loadFromModule("Discogs", "Main");

    QQmlContext *context (engine.rootContext());
    DiscogsApi api;

    context->setContextProperty("DiscogsApi",&api);


    return app.exec();
}
