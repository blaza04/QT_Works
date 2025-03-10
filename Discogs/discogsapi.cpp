#include "discogsapi.h"
#include <QDebug>

DiscogsApi::DiscogsApi(QObject *parent) : QObject(parent) {
    networkManager = new QNetworkAccessManager(this);
}

void DiscogsApi::fetchReleases(const QString &language) {

    QString url = QString("https://api.discogs.com/database/search?q=%1&type=release&sort=year&order=desc")
    .arg(QUrl::toPercentEncoding(language));

    QNetworkRequest request((QUrl(url)));
    request.setRawHeader("Authorization", QString("Discogs token=%1").arg(accessToken).toUtf8());

    QNetworkReply *reply = networkManager->get(request);
    connect(reply, &QNetworkReply::finished, this, &DiscogsApi::onReplyFinished);
    qInfo()<<"okay for now" ;
}

void DiscogsApi::onReplyFinished() {
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender()); // Get the sender
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray resposne = reply->readAll();
        QJsonDocument doc = QJsonDocument::fromJson(resposne);
        QJsonObject jsonobj = doc.object();
        qInfo()<<doc;
        QJsonArray releases = jsonobj.value("results").toArray(); // Ensure QJsonObject is fully defined
        emit releasesFetched(releases);
    } else {
        emit errorOccurred(reply->errorString());
    }
    reply->deleteLater();

}
