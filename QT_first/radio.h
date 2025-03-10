#ifndef RADIO_H
#define RADIO_H
#include <QObject>
#include <QMap>
#include <QString>
#include <QStringList>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QDebug>


class radio: public QObject
{
     Q_OBJECT
     Q_PROPERTY(QStringList myList READ myList WRITE setMyList NOTIFY myListChanged FINAL)
     Q_PROPERTY(QString fm READ fm WRITE setFm NOTIFY fmChanged FINAL)
public:
    radio();
    QStringList myList() const;
    void setMyList(const QStringList &newMyList);




    QString fm() const;
    void setFm(const QString &newFm);

    Q_INVOKABLE void changeList();

signals:

    void myListChanged();

    void fmChanged();

public slots:

private:
    QStringList mylist;

    QStringList m_myList;
    QString m_fm;


};

#endif // RADIO_H
