#include "system.h"
#include <QDateTime>

System::System(QObject *parent)
    : QObject{parent},m_lock(false) , m_profile( "Adin" )
{

    timerTimeout = new QTimer(this);
    timerTimeout->setInterval(500);
    timerTimeout->setSingleShot(true);
    connect(timerTimeout , &QTimer::timeout,this,&System::currentTimerTimeout);

    currentTimerTimeout();
}

bool System::lock() const
{
    return m_lock;
}

void System::setLock(bool newLock)
{
    if (m_lock == newLock)
        return;
    m_lock = newLock;
    emit lockChanged();
}

void System::currentTimerTimeout()
{
    QDateTime datetime;
    QString currentTime = datetime.currentDateTime().toString("hh:m ap");
    setCurrentTime(currentTime);
    timerTimeout->start();
}

QString System::profile() const
{
    return m_profile;
}

void System::setProfile(const QString &newProfile)
{
    if (m_profile == newProfile)
        return;
    m_profile = newProfile;
    emit profileChanged();
}

int System::temperature() const
{
    return m_temperature;
}

void System::settemperature(int newTemperature)
{
    if (m_temperature == newTemperature)
        return;
    m_temperature = newTemperature;
    emit temperatureChanged();
}

QString System::currentTime() const
{
    return m_currentTime;
}

void System::setCurrentTime(const QString &newCurrentTime)
{
    if (m_currentTime == newCurrentTime)
        return;
    m_currentTime = newCurrentTime;
    emit currentTimeChanged();
}



void System::setTemperature(int newTemperature)
{
    if (m_temperature == newTemperature)
        return;
    m_temperature = newTemperature;
    emit temperatureChanged();
}
