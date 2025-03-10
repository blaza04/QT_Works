#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Signalclass.h"
#include "Slotclass.h"
#include "Handler.h"
#include "System.h"
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
    engine.loadFromModule("second", "Main");
    Signalclass sigobj;
    // classname object =  new classname;
    Slotclass sigslot;
    Handler newhandler;

    QObject::connect(&sigobj,&Signalclass::signalfun,&sigslot,&Slotclass::slotfun);
    QObject::connect(&sigobj,&Signalclass::signalfun,&sigslot,&Slotclass::newsignal);
    QObject::connect(&sigobj,&Signalclass::signalfun,&sigslot,&Slotclass::newsignal);
    QObject::connect(&sigslot,&Slotclass::sig,&sigslot,&Slotclass::newsignal);
    sigobj.signalfun();
    emit sigslot.sig();

    QQmlContext *newcontext(engine.rootContext());

    System mysystem ;
    //engine.rootContext()->setContextProperty("system", &mysystem);
    newcontext->setContextProperty("system",&mysystem);


    return app.exec();

}
