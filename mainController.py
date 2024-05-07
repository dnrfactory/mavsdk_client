from PyQt5.QtCore import QObject, pyqtSlot, pyqtProperty, pyqtSignal, QVariant
import logging
from droneProxy import DroneProxy
from socketClient import SocketClient

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

    @pyqtSlot(int)
    def setLeaderDrone(self, index):
        SocketClient.getInstance().send_message("setLeaderDrone", (index,))

    @pyqtSlot(int, float, float)
    def addFollowerDrone(self, index, distance, angle):
        logger.debug(f'index:{index}, distance:{distance}, angle:{angle}')
        SocketClient.getInstance().send_message("addFollowerDrone", (index, distance, angle))

    @pyqtSlot(int)
    def removeFollowerDrone(self, index):
        SocketClient.getInstance().send_message("removeFollowerDrone", (index,))

    @pyqtSlot()
    def readyToFollow(self):
        SocketClient.getInstance().send_message("readyToFollow", ())

    @pyqtSlot()
    def followLeader(self):
        SocketClient.getInstance().send_message("followLeader", ())

    @pyqtSlot()
    def stopFollow(self):
        SocketClient.getInstance().send_message("stopFollow", ())
