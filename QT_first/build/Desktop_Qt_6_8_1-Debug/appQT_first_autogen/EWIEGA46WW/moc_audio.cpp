/****************************************************************************
** Meta object code from reading C++ file 'audio.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../audio.h"
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'audio.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN5audioE_t {};
} // unnamed namespace


#ifdef QT_MOC_HAS_STRINGDATA
static constexpr auto qt_meta_stringdata_ZN5audioE = QtMocHelpers::stringData(
    "audio",
    "myListChanged",
    "",
    "fmChanged",
    "presetChanged",
    "changeListForward",
    "changeListBackward",
    "playFm",
    "stopFm",
    "savePreset",
    "loadPreset",
    "index",
    "loadPresetFromList",
    "removePreset",
    "myList",
    "fm",
    "preset"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA

Q_CONSTINIT static const uint qt_meta_data_ZN5audioE[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       3,   97, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   80,    2, 0x06,    4 /* Public */,
       3,    0,   81,    2, 0x06,    5 /* Public */,
       4,    0,   82,    2, 0x06,    6 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       5,    0,   83,    2, 0x02,    7 /* Public */,
       6,    0,   84,    2, 0x02,    8 /* Public */,
       7,    0,   85,    2, 0x02,    9 /* Public */,
       8,    0,   86,    2, 0x02,   10 /* Public */,
       9,    0,   87,    2, 0x02,   11 /* Public */,
      10,    1,   88,    2, 0x02,   12 /* Public */,
      12,    1,   91,    2, 0x02,   14 /* Public */,
      13,    1,   94,    2, 0x02,   16 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   11,
    QMetaType::Void, QMetaType::Int,   11,
    QMetaType::Void, QMetaType::Int,   11,

 // properties: name, type, flags, notifyId, revision
      14, QMetaType::QStringList, 0x00015903, uint(0), 0,
      15, QMetaType::QString, 0x00015903, uint(1), 0,
      16, QMetaType::QStringList, 0x00015903, uint(2), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject audio::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ZN5audioE.offsetsAndSizes,
    qt_meta_data_ZN5audioE,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_tag_ZN5audioE_t,
        // property 'myList'
        QtPrivate::TypeAndForceComplete<QStringList, std::true_type>,
        // property 'fm'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'preset'
        QtPrivate::TypeAndForceComplete<QStringList, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<audio, std::true_type>,
        // method 'myListChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'fmChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'presetChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'changeListForward'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'changeListBackward'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'playFm'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'stopFm'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'savePreset'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'loadPreset'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'loadPresetFromList'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'removePreset'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>
    >,
    nullptr
} };

void audio::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<audio *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->myListChanged(); break;
        case 1: _t->fmChanged(); break;
        case 2: _t->presetChanged(); break;
        case 3: _t->changeListForward(); break;
        case 4: _t->changeListBackward(); break;
        case 5: _t->playFm(); break;
        case 6: _t->stopFm(); break;
        case 7: _t->savePreset(); break;
        case 8: _t->loadPreset((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 9: _t->loadPresetFromList((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 10: _t->removePreset((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _q_method_type = void (audio::*)();
            if (_q_method_type _q_method = &audio::myListChanged; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _q_method_type = void (audio::*)();
            if (_q_method_type _q_method = &audio::fmChanged; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _q_method_type = void (audio::*)();
            if (_q_method_type _q_method = &audio::presetChanged; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QStringList*>(_v) = _t->myList(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->fm(); break;
        case 2: *reinterpret_cast< QStringList*>(_v) = _t->preset(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setMyList(*reinterpret_cast< QStringList*>(_v)); break;
        case 1: _t->setFm(*reinterpret_cast< QString*>(_v)); break;
        case 2: _t->setPreset(*reinterpret_cast< QStringList*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *audio::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *audio::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ZN5audioE.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int audio::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 11;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void audio::myListChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void audio::fmChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void audio::presetChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
