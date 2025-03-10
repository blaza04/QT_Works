#ifndef NAVIGATION_H
#define NAVIGATION_H

#include <QObject>
#include <QMap>
#include <QtLocation>
#include <QtPositioning>
#include <QGeoCodeReply>
#include <QAbstractListModel>
#include <QWidget>

class Navigation : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QGeoCoordinate SearchLocation READ SearchLocation WRITE setSearchLocation NOTIFY SearchLocationChanged FINAL)
    Q_PROPERTY(QGeoCoordinate CurrentLocation READ CurrentLocation NOTIFY CurrentLocationChanged FINAL)
public:
    explicit Navigation(QObject *parent = nullptr);

    Q_INVOKABLE void serachLocation(QString query);

    QGeoCoordinate SearchLocation() const;
    void setSearchLocation(const QGeoCoordinate &newSearchLocation);

    QGeoCoordinate CurrentLocation() const;

signals:
    void SearchLocationChanged();
    void CurrentLocationChanged();

private:
    QGeoCoordinate m_SearchLocation,currentLocation;
    QGeoCodingManager *geocoder;

    QGeoCoordinate m_CurrentLocation;
};

#endif // NAVIGATION_H
