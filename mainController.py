from PyQt5.QtCore import QObject, pyqtSlot, pyqtProperty, pyqtSignal, QVariant
import logging
from droneProxy import DroneProxy

logger = logging.getLogger()


class MainController(QObject):
    def __init__(self, qmlContext, parent=None):
        super().__init__(parent)
        self._qmlContext = qmlContext
        self._qmlContext.setContextProperty('mainController', self)

        self._drones = [DroneProxy(), DroneProxy(port="50052", index=1), DroneProxy(port="50053", index=2),
                        DroneProxy(port="50054", index=3)]

        i = 0
        for drone in self._drones:
            self._qmlContext.setContextProperty(f'drone{i}', drone)
            i += 1

    def cleanup(self):
        pass

    @pyqtSlot(int, str, str)
    def connect(self, index, ip, port):
        logger.debug(f'index:{index}, ip:{ip}, port:{port}')
        self._drones[index].connect(index, ip, port)
