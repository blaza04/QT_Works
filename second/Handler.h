#ifndef HANDLER_H
#define HANDLER_H

#include <QObject>

class Handler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool button READ button WRITE setButton NOTIFY buttonChanged FINAL)

public:
    explicit Handler(QObject *parent = nullptr);

    bool button() const;

public slots:
    void setButton(bool newButton); // Correct case (setButton)

signals:
    void buttonChanged();

private:
    bool m_button = false;
};

#endif // HANDLER_H
