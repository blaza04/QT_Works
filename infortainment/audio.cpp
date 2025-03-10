#include "audio.h"
#include <QDebug>
audio::audio(QObject *parent)
    : QObject{parent},m_audiolevel(0)
{}

int audio::audiolevel() const
{
    return m_audiolevel;
}

void audio::setAudiolevel(int newAudiolevel)
{
    if (m_audiolevel == newAudiolevel)
        return;
    m_audiolevel = newAudiolevel;
    emit audiolevelChanged();
}

void audio::volumeAdjust(const int &val)
{
    qInfo() << " hello " ;
    int newVol = m_audiolevel + val ;
    if(newVol <= 0){
        newVol = 0;
    } if(newVol >=3){
        newVol =3;
    }
    setAudiolevel(newVol);
}

