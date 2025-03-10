#include "radio.h"


radio::radio()
{
    m_myList = QStringList({"ClubFM","Mirchi","RedFM","RadioMalayalam","FM"});
    m_fm="hello";


}

QStringList radio::myList() const
{
    return m_myList;
}

void radio::setMyList(const QStringList &newMyList)
{
    if (m_myList == newMyList)
        return;
    m_myList = newMyList;
    emit myListChanged();
}

QString radio::fm() const
{
    return m_fm;
}

void radio::setFm(const QString &newFm)
{
    if (m_fm == newFm)
        return;
    m_fm = newFm;
    emit fmChanged();
}

void radio::changeList()
{
    qInfo()<<"change" ;

}
