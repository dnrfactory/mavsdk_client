from PyQt5.QtCore import QObject, pyqtSlot, pyqtProperty, pyqtSignal, QVariant
import logging
from droneProxy import DroneProxy
from socketClient import SocketClient
from appSetting import AppSetting

logger = logging.getLogger()


class MainController(QObject):
    followFrequencyChanged = pyqtSignal(str)

    def __init__(self, qmlContext, parent=None):
        super().__init__(parent)
        self._qmlContext = qmlContext
        self._qmlContext.setContextProperty('mainController', self)

        self._appSetting = AppSetting()

        self._drones = [DroneProxy(), DroneProxy(port="50052", index=1), DroneProxy(port="50053", index=2),
                        DroneProxy(port="50054", index=3)]

        i = 0
        for drone in self._drones:
            self._qmlContext.setContextProperty(f'drone{i}', drone)
            address_ip_port = self._appSetting.getIpPort(i)
            follow_distance_angle = self._appSetting.getDistanceAngle(i)
            drone.address_ip = address_ip_port[0]
            drone.address_port = address_ip_port[1]
            drone.follow_distance = follow_distance_angle[0]
            drone.follow_angle = follow_distance_angle[1]
            i += 1

        self._followFrequency = self._appSetting.getFrequency()

    def cleanup(self):
        SocketClient.getInstance().send_message("closeServer", ())

        i = 0
        for drone in self._drones:
            self._appSetting.setIpPort(i, drone.address_ip, drone.address_port)
            self._appSetting.setDistanceAngle(i, drone.follow_distance, drone.follow_angle)
            i += 1

        self._appSetting.setFrequency(self._followFrequency)

    @pyqtProperty(str, notify=followFrequencyChanged)
    def followFrequency(self):
        return self._followFrequency

    @followFrequency.setter
    def followFrequency(self, val: str):
        self._followFrequency = val
        self.followFrequencyChanged.emit(val)

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
        SocketClient.getInstance().send_message("followLeader", (float(self.followFrequency),))

    @pyqtSlot()
    def stopFollow(self):
        SocketClient.getInstance().send_message("stopFollow", ())

    @pyqtSlot(int)
    def arm(self, index):
        SocketClient.getInstance().send_message("arm", (index,))

    @pyqtSlot(int)
    def startOffboardMode(self, index):
        SocketClient.getInstance().send_message("startOffboardMode", (index,))

    @pyqtSlot(int)
    def stopOffboardMode(self, index):
        SocketClient.getInstance().send_message("stopOffboardMode", (index,))

    @pyqtSlot(int, float, float, float, float)
    def setVelocityBody(self, index, forward, right, down, yaw):
        logger.debug('')
        SocketClient.getInstance().send_message("setVelocityBody", (index, forward, right, down, yaw))

    @pyqtSlot(int, float, float, float, float)
    def setVelocityNED(self, index, north, east, down, yaw):
        logger.debug('')
        SocketClient.getInstance().send_message("setVelocityNED", (index, north, east, down, yaw))

    @pyqtSlot(int, float, float, float, float)
    def setAttitude(self, index, roll, pitch, yaw, thrust):
        logger.debug('')
        SocketClient.getInstance().send_message("setAttitude", (index, roll, pitch, yaw, thrust))

    @pyqtSlot(int, float, float, float, float)
    def setPositionNED(self, index, north, east, down, yaw):
        logger.debug('')
        SocketClient.getInstance().send_message("setPositionNED", (index, north, east, down, yaw))

    @pyqtSlot(float)
    def setFollowFrequency(self, frequency):
        logger.debug(f'frequency: {frequency}')
        SocketClient.getInstance().send_message("setFollowFrequency", (frequency,))
