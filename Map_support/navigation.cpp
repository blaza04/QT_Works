#include "navigation.h"
#include <QDebug>

Navigation::Navigation(QObject *parent)
    : QObject{parent}


{

    QGeoServiceProvider *provider = new QGeoServiceProvider("osm");
    geocoder = provider->geocodingManager();
}

void Navigation::serachLocation(QString query)
{
    qInfo()<<"search method invoked" ;
    if(!geocoder){
        qInfo()<<"error with geocoder";
        return ;
    }
    QGeoCodeReply *replay =geocoder->geocode(query);
    connect(replay,&QGeoCodeReply::finished,this,[=](){
        if(replay->error() == QGeoCodeReply::NoError && !replay->locations().isEmpty()){
            m_SearchLocation = replay->locations().first().coordinate();
            emit SearchLocationChanged();
            qInfo()<<m_SearchLocation;
        } else {
            qWarning()<< " error with geocode " <<replay->error() ;
        }
        replay->deleteLater();
    });

}


QGeoCoordinate Navigation::SearchLocation() const
{
    return m_SearchLocation;
}

void Navigation::setSearchLocation(const QGeoCoordinate &newSearchLocation)
{
    if (m_SearchLocation == newSearchLocation)
        return;
    m_SearchLocation = newSearchLocation;
    emit SearchLocationChanged();
}

QGeoCoordinate Navigation::CurrentLocation() const
{
    return QGeoCoordinate(8.54671867722126,76.87960068638984);
}
