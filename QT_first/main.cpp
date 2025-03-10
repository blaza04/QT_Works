#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QAudioFormat>
#include <QQmlContext>
#include "audio.h"

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
    engine.loadFromModule("QT_first", "Main");

    QQmlContext *context(engine.rootContext());
    audio radio;
    context->setContextProperty("radio",&radio);

    QMediaPlayer* mediaPlayer = new QMediaPlayer;
    QAudioOutput *audio=  new QAudioOutput();




    return app.exec();
}
