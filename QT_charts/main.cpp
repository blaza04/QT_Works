#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QtCharts/QtCharts>
#include <QtCharts/QBarSet>
#include <QtCharts/QBarSeries>
#include <QtCharts/QChartView>
#include <QtCharts/QBarCategoryAxis>
#include <QtCharts/QValueAxis>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QChart *chart = new QChart();

    QBarSeries *newSeries = new QBarSeries();

    QBarSet *set1 = new QBarSet("deepak");
    //*set1<<10<<20<<30 ;
    set1->append(5);
    set1->append(10);
    set1->append(12);
    set1->append(12);
    set1->append(23);
    QBarSet *set2 = new QBarSet("adin");
     //*set2<<10<<20<<30 ;
    set2->append(10);
    set2->append(20);
    set2->append(30);
    set2->append(10);
    set2->append(20);


    newSeries->append(set1);
    newSeries->append(set2);

    QChart *myChart = new QChart();
    myChart->addSeries(newSeries);
    myChart->setTitle("charts");
    myChart->setAnimationOptions(QChart::SeriesAnimations);

    QBarCategoryAxis *axisX = new QBarCategoryAxis();
    axisX->append("mark1");
    axisX->append("mark2");
    axisX->append("mark3");
    axisX->append("mark4");


    myChart->setAxisX(axisX,newSeries);

    QValueAxis *values = new QValueAxis();
    values->setTitleText("charts");

    myChart->setAxisY(values,newSeries);

    QChartView *view = new QChartView(myChart);
    view->setRenderHint(QPainter::Antialiasing);

    QPieSeries *pieSeries = new QPieSeries();
    pieSeries->append("c",20);
    pieSeries->append("c++",10);
    pieSeries->append("Android",20);
    pieSeries->append("linux",15);
    pieSeries->append("automotive",15);
    pieSeries->append("qt",20);

    QPieSlice *slice = pieSeries->slices().at(0);
    slice->setBrush(Qt::red);
    slice->setExploded(true);
    slice->setLabelVisible(true);
    QPieSlice *slice1 = pieSeries->slices().at(4);
    slice1->setBrush(Qt::black);
    slice1->setExploded(true);
    slice1->setLabelVisible(true);


    QChart *myChart1 = new QChart();
    myChart1->addSeries(pieSeries);
    myChart1->setTitle("charts");
    myChart1->setAnimationOptions(QChart::SeriesAnimations);

    QChartView *view1 = new QChartView(myChart1);
    view1->setRenderHint(QPainter::Antialiasing);




    QMainWindow *wind = new QMainWindow();



    wind->setCentralWidget(view1);
    wind->resize(1080,720);
    wind->show();



    return app.exec();
}
