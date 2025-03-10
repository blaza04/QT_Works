#include "Slotclass.h"
#include<QDebug>

Slotclass::Slotclass() {
    emit sig();
}

void Slotclass::slotfun()
{
    qInfo()<<"hello signal emitted! ! ! ! ! ";
}
void Slotclass::newsignal()
{
    qInfo()<<"hello from new slot signal ! ! ! !!";
}

void Slotclass::my()
{
    qInfo() << "hello i am new " ;
}

void Slotclass::sigslot()
{
    qInfo() << "help" ;
}
