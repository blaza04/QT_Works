#include "Signalclass.h"
#include <QDebug>

//Signalclass::Signalclass() {}

void Signalclass::mytest()
{
    emit signalfun();
}

bool Signalclass::Button() const
{
    return m_Button;
}

void Signalclass::print(){
    qInfo()<<"testing helooo" ;

}


Q_INVOKABLE void Signalclass::setbutton(bool newButton)
{
    if (m_Button == newButton)
        return;
    m_Button = newButton;
    emit ButtonChanged();
}
