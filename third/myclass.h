#ifndef MYCLASS_H
#define MYCLASS_H

#include <QObject>
#include <QDebug>

class myclass : public QObject {
    Q_OBJECT

public:
    explicit myclass(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void myFunction() {
        qDebug() << "Button clicked! Function called.";
    }
};

#endif // MYCLASS_H
