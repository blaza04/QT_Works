#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QGraphicsView>
#include <QGraphicsScene>
#include <QGraphicsRectItem>
#include <QGraphicsTextItem>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QGraphicsView view;
    QGraphicsScene scene;
    QGraphicsRectItem *rect = new QGraphicsRectItem;
    QGraphicsTextItem *text = new QGraphicsTextItem;

    rect = scene.addRect(10,10,100,100);
    text = scene.addText("Hi Hello");
    text->setPos(30,50);
    scene.setBackgroundBrush(Qt::green);
    view.setScene(&scene);
    QGraphicsRectItem *rect2 = scene.addRect(20,20,80,80);
    rect2->setTransformOriginPoint(rect2->rect().center());
    rect2->setRotation(45);

     QGraphicsRectItem *rect3 = scene.addRect(50,50,80,80);

    QTransform transform;
     transform.translate(10,100);
     transform.rotate(50);

     rect3->setTransform(transform);
     view.scale(2,2);
    Cust view.show();


    return app.exec();
}
