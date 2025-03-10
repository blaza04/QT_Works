#ifndef SYSTEM_H
#define SYSTEM_H

#include <QObject>
#include<qdebug.h>

class System : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool button READ button WRITE setButton NOTIFY buttonChanged FINAL)
public:
    explicit System(QObject *parent = nullptr);
    bool button() const;
    Q_INVOKABLE void print()
    {
        qInfo()<<"print function" ;
    }
    void newprint();


public slots:
    void setButton(bool newButton);

signals:
    void buttonChanged();
private:
    bool m_button;
};

#endif // SYSTEM_H
