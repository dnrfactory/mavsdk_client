from PyQt5.QtCore import QUrl, QObject, pyqtSlot
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView
from PyQt5.QtQml import QQmlApplicationEngine

import sys
import os
import logging

import mainController

logger = logging.getLogger()


class WindowManager(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._windowList = list()
        self.cleanupFunc = None

    def add_window(self, window):
        for win in self._windowList:
            if win == window:
                return
        self._windowList.append(window)

    @pyqtSlot()
    def onMainWindowClosed(self):
        for win in self._windowList:
            win.close()

        if self.cleanupFunc:
            self.cleanupFunc()


def _handleQmlWarnings(warnings):
    for warning in warnings:
        print("QML Warning:", warning.toString())


def resource_path(relative_path):
    """ Get absolute path to resource, works for dev and for PyInstaller """
    try:
        # PyInstaller creates a temp folder and stores path in _MEIPASS
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")

    return os.path.join(base_path, relative_path)


if __name__ == "__main__":
    rootLogger = logging.getLogger()
    rootLogger.setLevel(logging.DEBUG)
    rootLogger.propagate = 0
    formatter = logging.Formatter('[%(asctime)s][%(levelname)s][%(thread)d][%(filename)s:%(funcName)s:%(lineno)d]'
                                  ' %(message)s')
    streamHandler = logging.StreamHandler()
    streamHandler.setFormatter(formatter)
    rootLogger.addHandler(streamHandler)

    app = QApplication(sys.argv)

    engine = QQmlApplicationEngine()
    engine.warnings.connect(_handleQmlWarnings)

    mainController = mainController.MainController(engine.rootContext(), app)

    engine.load(QUrl.fromLocalFile(resource_path("qml/Main.qml")))

    if not engine.rootObjects():
        sys.exit(-1)

    wm = WindowManager(app)
    wm.cleanupFunc = lambda: (
        mainController.cleanup()
    )

    main_window = engine.rootObjects()[0]
    main_window.closing.connect(wm.onMainWindowClosed)

    sys.exit(app.exec_())
