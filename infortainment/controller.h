#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>

class controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int carTemp READ carTemp WRITE setCarTemp NOTIFY carTempChanged FINAL)
public:
    explicit controller(QObject *parent = nullptr);

    int carTemp() const;
    void setCarTemp(int newCarTemp);
    Q_INVOKABLE void tempAdjust(const int & val);
signals:
    void carTempChanged();
private:
    int m_carTemp;
};

#endif // CONTROLLER_H
