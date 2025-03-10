#ifndef DISCOGSAPI_H
#define DISCOGSAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

class DiscogsApi : public QObject {
    Q_OBJECT
public:
    explicit DiscogsApi(QObject *parent = nullptr);
    Q_INVOKABLE void fetchReleases(const QString &language);

signals:
    void releasesFetched(const QJsonArray &releases);
    void errorOccurred(const QString &error);

private slots:
    void onReplyFinished();

private:
    QNetworkAccessManager *networkManager;
    QString accessToken = "kidfPjWayOkpnamsWmTyxyvJSyHRHUNgFKWUtPGv"; // Replace with your actual access token
};

#endif // DISCOGSAPI_H
