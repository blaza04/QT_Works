#include "controller.h"
#include <QDebug>

controller::controller(QObject *parent)
    : QObject{parent},m_carTemp(70)
{}

int controller::carTemp() const
{
    return m_carTemp;
}

void controller::setCarTemp(int newCarTemp)
{
    if (m_carTemp == newCarTemp)
        return;
    m_carTemp = newCarTemp;
    emit carTempChanged();
}

void controller::tempAdjust(const int &val)
{
    int newTemp = m_carTemp + val ;
    setCarTemp(newTemp);
}
