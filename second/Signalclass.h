#ifndef SIGNALCLASS_H
#define SIGNALCLASS_H
#include <QObject>
#include<QDebug>
class Signalclass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool Button READ Button WRITE setbutton NOTIFY ButtonChanged FINAL)
public:
    //Signalclass();
    void mytest();
    bool Button() const;
    void print();
public slots:
    void setbutton(bool newButton);

signals:
    void signalfun();
    void newsignal();
    void ButtonChanged();
private:
    bool m_Button;
};
#endif // SIGNALCLASS_H
