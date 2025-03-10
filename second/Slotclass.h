#ifndef SLOTCLASS_H
#define SLOTCLASS_H
#include<QObject>
class Slotclass : public QObject
{
    Q_OBJECT
public:
    Slotclass();
signals:
    void sig();
public slots :
    void slotfun();
    void newsignal();
    void my();
    void sigslot();
};

#endif // SLOTCLASS_H
