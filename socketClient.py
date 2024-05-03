from PyQt5.QtCore import QUrl, QObject, pyqtSlot
from PyQt5.QtNetwork import QTcpSocket, QHostAddress

import sys
import logging
import json

logger = logging.getLogger()


class SocketClient(QObject):
    instance = None

    def __init__(self, parent=None):
        super().__init__(parent)

        self.socket = QTcpSocket(self)
        self.socket.connected.connect(self.connected)
        self.socket.readyRead.connect(self.receive_message)
        self.socket.error.connect(self.display_error)
        self.socket.connectToHost(QHostAddress.LocalHost, 12345)

        self.cb_statusText = list()
        self.cb_connected = list()
        self.cb_armed = list()
        self.cb_flightMode = list()
        self.cb_position = list()
        self.cb_heading = list()

    @classmethod
    def getInstance(cls):
        if cls.instance is None:
            cls.instance = SocketClient()
        return cls.instance

    def connected(self):
        logger.debug("Connected to server")

    @staticmethod
    def callCbList(cbList, args):
        if len(cbList) > 0:
            for cb in cbList:
                cb(*args)

    def receive_message(self):
        messageJson = self.socket.readAll().data().decode()
        # logger.debug(f"Received from server: {messageJson}")
        messages = messageJson.split('\n')

        received_messages = []
        for msg in messages:
            if msg.strip():  # 빈 문자열이 아닌 경우에만 처리합니다.
                try:
                    received_messages.append(json.loads(msg))
                except json.JSONDecodeError as e:
                    logger.error(f"Failed to decode JSON message: {msg}")
                    continue

        for message in received_messages:
            # logger.debug(f"Received from server dict: {message}")

            type_ = message['type']
            value = message['value']

            if type_ == "statusText":
                SocketClient.callCbList(self.cb_statusText, value)
            elif type_ == "connected":
                SocketClient.callCbList(self.cb_connected, value)
            elif type_ == "armed":
                SocketClient.callCbList(self.cb_armed, value)
            elif type_ == "flightMode":
                SocketClient.callCbList(self.cb_flightMode, value)
            elif type_ == "position":
                SocketClient.callCbList(self.cb_position, value)
            elif type_ == "heading":
                SocketClient.callCbList(self.cb_heading, value)

    def display_error(self, socket_error):
        logger.debug(f"Socket error: {socket_error}")

    def send_message(self, func: str, args: tuple):
        data = {"func": "connect", "args": (0, "172.17.0.2", "14581")}
        data = {"func": func, "args": args}
        message = json.dumps(data)
        self.socket.write(message.encode())
        self.socket.flush()
        logger.debug("Message sent to server")


