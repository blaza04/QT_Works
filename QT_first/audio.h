#ifndef AUDIO_H
#define AUDIO_H

#include <QObject>
#include <QMap>
#include <QString>
#include <QStringList>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class audio : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList myList READ myList WRITE setMyList NOTIFY myListChanged FINAL)
    Q_PROPERTY(QString fm READ fm WRITE setFm NOTIFY fmChanged FINAL)
    Q_PROPERTY(QStringList preset READ preset WRITE setPreset NOTIFY presetChanged FINAL)
public:
    explicit audio(QObject *parent = nullptr);
    QStringList myList() const;
    void setMyList(const QStringList &newMyList);




    QString fm() const;
    void setFm(const QString &newFm);

    Q_INVOKABLE void changeListForward();
    Q_INVOKABLE void changeListBackward();
    Q_INVOKABLE void playFm();
    Q_INVOKABLE void stopFm();
    Q_INVOKABLE void savePreset();
    Q_INVOKABLE void loadPreset(int index);
    Q_INVOKABLE void loadPresetFromList(int index);
    Q_INVOKABLE void removePreset(int index);

    void fetchdata();

    QStringList preset() const;
    void setPreset(const QStringList &newPreset);

signals:
    void myListChanged();

    void fmChanged();

    void presetChanged();

private:

    QStringList m_myList;
    QString m_fm;

    int currentIndex;
    int index ;

    QMap<QString,QString>fmdata;

    QMediaPlayer *m_player;
    QAudioOutput *output = new QAudioOutput;
    QStringList m_preset;

    QNetworkAccessManager *networkManager;
};

#endif // AUDIO_H
