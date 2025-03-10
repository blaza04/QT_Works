#ifndef CLICKER_H
#define CLICKER_H

#include <QObject>

class Clicker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool button READ button WRITE setButton NOTIFY buttonChanged FINAL)
public:
    explicit Clicker(QObject *parent = nullptr);
    Clicker(bool button);

    bool button() const;

public slots :
    void setButton(bool newButton);

signals:
    void buttonChanged();
private:
    bool m_button;
};

#endif // CLICKER_H


// #ifndef CLICKER_H
// #define CLICKER_H

// #include <QObject>

// class Clicker : public QObject {
//     Q_OBJECT
//     Q_PROPERTY(bool button READ button WRITE setButton NOTIFY buttonChanged)

// public:
//     explicit Clicker(QObject *parent = nullptr); // Constructor with parent
//     explicit Clicker(bool button, QObject *parent = nullptr); // Constructor with initial button value

//     bool button() const; // Getter for button
//     void setButton(bool newButton); // Setter for button

// signals:
//     void buttonChanged(); // Signal emitted when button changes

// private:
//     bool m_button; // Member variable to hold button state
// };

// #endif // CLICKER_H
