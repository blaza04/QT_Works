#include "clicker.h"

Clicker::Clicker(QObject *parent)
    : QObject{parent},m_button(false)
{}

bool Clicker::button() const
{
    return m_button;
}

void Clicker::setButton(bool newButton)
{
    if (m_button == newButton)
        return;
    m_button = newButton;
    emit buttonChanged();
}



// #include "clicker.h"

// Clicker::Clicker(QObject *parent)
//     : QObject{parent}, m_button(false) // Initialize with false
// {}

// Clicker::Clicker(bool button, QObject *parent)
//     : QObject{parent}, m_button(button) // Initialize with given value
// {}

// bool Clicker::button() const
// {
//     return m_button; // Return current button state
// }

// void Clicker::setButton(bool newButton)
// {
//     if (m_button == newButton)
//         return; // No change, do nothing
//     m_button = newButton; // Update button state
//     emit buttonChanged(); // Emit signal to notify change
// }
