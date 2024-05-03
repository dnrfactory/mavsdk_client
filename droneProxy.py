from PyQt5.QtCore import QObject, pyqtSlot, pyqtProperty, pyqtSignal
import logging
import socketClient

logger = logging.getLogger()


class DroneProxy(QObject):
    statusTextChanged = pyqtSignal(str)
    isConnectedChanged = pyqtSignal(bool)
    isArmedChanged = pyqtSignal(bool)
    flightModeChanged = pyqtSignal(str)
    latitudeChanged = pyqtSignal(float)
    longitudeChanged = pyqtSignal(float)
    altitudeChanged = pyqtSignal(float)
    headingChanged = pyqtSignal(float)

    def __init__(self, port="50051", index=0, parent=None):
        super().__init__(parent)
        self._drone = None
        self._port = port
        self._index = index

        self._statusText = ''
        self._isConnected = False
        self._isArmed = False
        self._flightMode = ''
        self._latitude = 0.0
        self._longitude = 0.0
        self._altitude = 0.0
        self._heading = 0.0

        self._socket = socketClient.SocketClient.getInstance()
        self._socket.cb_statusText.append(self._onStatusText)
        self._socket.cb_connected.append(self._onConnected)
        self._socket.cb_armed.append(self._onArmed)
        self._socket.cb_flightMode.append(self._onFlightMode)
        self._socket.cb_position.append(self._onPosition)
        self._socket.cb_heading.append(self._onHeading)

    @property
    def index(self):
        return self._index

    @pyqtProperty(str, notify=statusTextChanged)
    def statusText(self):
        return self._statusText

    @statusText.setter
    def statusText(self, val: str):
        self._statusText = val
        self.statusTextChanged.emit(val)

    @pyqtProperty(bool, notify=isConnectedChanged)
    def isConnected(self):
        return self._isConnected

    @isConnected.setter
    def isConnected(self, val: bool):
        self._isConnected = val
        self.isConnectedChanged.emit(val)

    @pyqtProperty(bool, notify=isArmedChanged)
    def isArmed(self):
        return self._isArmed

    @isArmed.setter
    def isArmed(self, val: bool):
        self._isArmed = val
        self.isArmedChanged.emit(val)

    @pyqtProperty(str, notify=flightModeChanged)
    def flightMode(self):
        return self._flightMode

    @flightMode.setter
    def flightMode(self, val: str):
        self._flightMode = val
        self.flightModeChanged.emit(val)

    @pyqtProperty(float, notify=latitudeChanged)
    def latitude(self):
        return self._latitude

    @latitude.setter
    def latitude(self, val: float):
        self._latitude = val
        self.latitudeChanged.emit(val)

    @pyqtProperty(float, notify=longitudeChanged)
    def longitude(self):
        return self._longitude

    @longitude.setter
    def longitude(self, val: float):
        self._longitude = val
        self.longitudeChanged.emit(val)

    @pyqtProperty(float, notify=altitudeChanged)
    def altitude(self):
        return self._altitude

    @altitude.setter
    def altitude(self, val: float):
        self._altitude = val
        self.altitudeChanged.emit(val)

    @pyqtProperty(float, notify=headingChanged)
    def heading(self):
        return self._heading

    @heading.setter
    def heading(self, val: float):
        self._heading = val
        self.headingChanged.emit(val)

    def telemetry(self):
        return self._drone.telemetry

    def connect(self, index: int, ip: str, port: str):
        if index == self._index:
            self._socket.send_message("connect", (self._index, ip, port))

    def _onStatusText(self, index: int, statusText: str):
        if index == self._index:
            logger.debug('')
            self.statusText = statusText

    def _onConnected(self, index: int, connected: bool):
        if index == self._index:
            logger.debug('')
            self.isConnected = connected

    def _onArmed(self, index: int, armed: bool):
        if index == self._index:
            # logger.debug('')
            self.isArmed = armed

    def _onFlightMode(self, index: int, fightMode: str):
        if index == self._index:
            # logger.debug('')
            self.flightMode = fightMode

    def _onPosition(self, index: int, latitude, longitude, altitude):
        if index == self._index:
            # logger.debug('')
            self.latitude = latitude
            self.longitude = longitude
            self.altitude = altitude

    def _onHeading(self, index: int, heading):
        if index == self._index:
            # logger.debug('')
            self.heading = heading
