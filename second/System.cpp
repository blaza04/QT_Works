#include "System.h"
#include<qdebug.h>

System::System(QObject *parent)
    : QObject{parent},m_button(false)
{}

bool System::button() const
{
    return m_button;
}

void System::newprint()
{
    qInfo() << " new print command:" ;
}

void System::setButton(bool newButton)
{
    qInfo()<<"setButton" ;
    if (m_button == newButton)
        return;
    m_button = newButton;
    emit buttonChanged();
}



