#include "audio.h"

audio::audio(QObject *parent)
    : QObject{parent}
{

    networkManager = new QNetworkAccessManager(this);
    m_preset = QStringList({" "," "," "," "," "," "}) ;

    currentIndex =0;
    index =0;
    m_player = new QMediaPlayer(this);
    m_player->setAudioOutput(output);
    fetchdata();
}
QStringList audio::myList() const
{
    return m_myList;
}

void audio::setMyList(const QStringList &newMyList)
{
    if (m_myList == newMyList)
        return;
    m_myList = newMyList;
    emit myListChanged();
}

QString audio::fm() const
{
    return m_fm;
}

void audio::setFm(const QString &newFm)
{
    if (m_fm == newFm)
        return;
    m_fm = newFm;
    emit fmChanged();
}

void audio::changeListBackward()
{
    qInfo()<<"change" ;
    if(currentIndex == 0){
        return;
    } else {
        currentIndex = (currentIndex -1) % m_myList.size();
        setFm(m_myList[currentIndex]);
    }
}
void audio::changeListForward()
{
    qInfo()<<"change";
    if(m_myList.isEmpty()){         //change here
        return ;
    }
    currentIndex = (currentIndex + 1) % fmdata.size();
    setFm(m_myList[currentIndex]);
}

void audio::playFm()
{
   if(fmdata.contains(m_fm)){
        qInfo()<<"in player";
        QString Url = fmdata.value(m_fm," ");
        m_player->stop();
        m_player->setSource(Url);
        m_player->play();
    }
}
void audio::stopFm()
{
    m_player->stop();
}

QStringList audio::preset() const
{
    return m_preset;
}

void audio::setPreset(const QStringList &newPreset)
{
    if (m_preset == newPreset)
        return;
    m_preset = newPreset;
    emit presetChanged();
}

void audio::savePreset()
{
    QString fq = m_fm;
    int indexVal = m_preset.indexOf(" ");
    if(!m_preset.contains(fq)){
        if(indexVal != -1){
            m_preset[indexVal] = fq;
            emit presetChanged();
        }
    }
}

void audio::loadPreset(int index)
{
        QString fq = m_preset.at(index);
        if(fq != " "){
            m_fm = fq;
            emit fmChanged();

        }
}
void audio::loadPresetFromList(int index)
{

    QString fq = m_myList.at(index);
    if(fq != " "){
        m_fm = fq;
        emit fmChanged();

    }
}


void audio::removePreset(int index)
{
    if(index >=0 && index < m_preset.size()){
        m_preset[index] = " ";
        emit presetChanged();
    }
}

void audio::fetchdata()
{

    QString url =QString("http://de1.api.radio-browser.info/json/stations/bylanguage/malayalam");//QString("http://de1.api.radio-browser.info/json/stations/bycountry/India");
    QNetworkRequest request((QUrl(url)));
    connect(networkManager, &QNetworkAccessManager::finished, this, [&](QNetworkReply *reply) {

        if (reply->error() == QNetworkReply::NoError) {

            qInfo()<<"marking no network error" ;

            QByteArray jsonData = reply->readAll();
            QJsonDocument doc = QJsonDocument::fromJson(jsonData);
            if (doc.isArray()) {

                QJsonArray items = doc.array()   ;  //["items"].toArray();

               // qInfo()<<items;   //print the json format data

                fmdata.clear();

                for (const QJsonValue &value : items) {
                    qInfo()<<"items" ;
                    QJsonObject obj = value.toObject();
                    QString title = obj["name"].toString();
                    QString streamLink = obj["url"].toString();
                    QString streamUrl =QString(streamLink);
                    fmdata[title] = streamUrl;
                }
                m_myList = fmdata.keys(); // all the names of station will go into this qStringList

                emit fmChanged();
            }
        } else {
            qWarning() << "Error fetching songs:" << reply->errorString();
             m_myList = fmdata.keys();
        }
    });
    networkManager->get(request);
}
