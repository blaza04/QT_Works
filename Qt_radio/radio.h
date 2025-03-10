#ifndef RADIO_H
#define RADIO_H

#include <QObject>
#include <QStringList>
#include <QDebug>

class radio : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float fm READ fm WRITE setFm NOTIFY fmChanged FINAL);
    Q_PROPERTY(int vol READ vol WRITE setvol NOTIFY volChanged FINAL);
    Q_PROPERTY(bool power READ power WRITE setPower NOTIFY powerChanged FINAL)
    Q_PROPERTY(QStringList preset READ preset WRITE setPreset NOTIFY presetChanged FINAL)
public:
    explicit radio(QObject *parent = nullptr);

    float fm() const;
    void setFm(float newFm);

    int vol() const;
    void setvol(int newVol);

    bool power() const;
    void setPower(bool newPower);
    float roundToDecimalPlaces(float value, int decimalPlaces) const;

    Q_INVOKABLE void volumeAdjust(const int &val);
    Q_INVOKABLE void setfm(const float &val);
    Q_INVOKABLE void savePreset();
    Q_INVOKABLE void loadPreset(int index);
    Q_INVOKABLE void removePreset(int index);

    QStringList preset() const;
    void setPreset(const QStringList &newPreset);

signals:
    void fmChanged();
    void volChanged();

    void powerChanged();

    void presetChanged();

private:
    float m_fm;
    int m_vol;
    bool m_power;
    QStringList m_preset;
    QStringList datalist ;
};

#endif // RADIO_H
