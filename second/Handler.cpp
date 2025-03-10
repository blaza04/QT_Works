#include "Handler.h"
#include<QObject>

Handler::Handler(QObject *parent)
    : QObject{parent},m_button(false)
{}

bool Handler::button() const
{
    return m_button;
}

void Handler::setButton(bool newButton)
{
    if (m_button == newButton)
        return;
    m_button = newButton;
    emit buttonChanged();
}
