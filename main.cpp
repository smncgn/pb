#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QFontDatabase>

#include <QDir>

#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("PhotoBooth");
    QGuiApplication::setOrganizationName("ottensoft");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QFontDatabase fdb;
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-Black.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-BlackItalic.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-Bold.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-BoldItalic.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-Italic.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-Light.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-LightItalic.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-Medium.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-MediumItalic.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-Regular.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-Thin.ttf");
    fdb.addApplicationFont("C:/Adapt/svogt6/Photobooth/fonts/Roboto-ThinItalic.ttf");


    QSettings settings;
    QString style = QQuickStyle::name();
    if (!style.isEmpty())
        settings.setValue("style", style);
    else
        QQuickStyle::setStyle(settings.value("style").toString());

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
