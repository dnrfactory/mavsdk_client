import configparser
import os


class AppSetting:
    def __init__(self):
        self._ini_file_path = 'appsettings.ini'
        self._config = configparser.ConfigParser()
        if not os.path.exists(self._ini_file_path):
            self._config.add_section('address')
            self._config.add_section('follow')
            self._config.set('address', 'ip1', 'localhost')
            self._config.set('address', 'ip2', 'localhost')
            self._config.set('address', 'ip3', 'localhost')
            self._config.set('address', 'ip4', 'localhost')
            self._config.set('address', 'port1', '14581')
            self._config.set('address', 'port2', '14582')
            self._config.set('address', 'port3', '14583')
            self._config.set('address', 'port4', '14584')
            self._config.set('follow', 'distance1', '5')
            self._config.set('follow', 'distance2', '10')
            self._config.set('follow', 'distance3', '15')
            self._config.set('follow', 'distance4', '20')
            self._config.set('follow', 'angle1', '180')
            self._config.set('follow', 'angle2', '180')
            self._config.set('follow', 'angle3', '180')
            self._config.set('follow', 'angle4', '180')
            with open(self._ini_file_path, 'w') as configFile:
                self._config.write(configFile)
        else:
            self._config.read(self._ini_file_path)

        self._ip_port = [(self._config.get('address', 'ip1'), self._config.get('address', 'port1')),
                         (self._config.get('address', 'ip2'), self._config.get('address', 'port2')),
                         (self._config.get('address', 'ip3'), self._config.get('address', 'port3')),
                         (self._config.get('address', 'ip4'), self._config.get('address', 'port4'))]

        self._distance_angle = [(self._config.get('follow', 'distance1'), self._config.get('follow', 'angle1')),
                                (self._config.get('follow', 'distance2'), self._config.get('follow', 'angle2')),
                                (self._config.get('follow', 'distance3'), self._config.get('follow', 'angle3')),
                                (self._config.get('follow', 'distance4'), self._config.get('follow', 'angle4'))]

    def getIpPort(self, index):
        return self._ip_port[index]

    def setIpPort(self, index, ip: str, port: str):
        self.write('address', f'ip{index+1}', ip)
        self.write('address', f'port{index+1}', port)

    def getDistanceAngle(self, index):
        return self._distance_angle[index]

    def setDistanceAngle(self, index, distance: str, angle: str):
        self.write('follow', f'distance{index+1}', distance)
        self.write('follow', f'angle{index+1}', angle)

    def read(self, section, key):
        val = None
        with open(self._ini_file_path) as configFile:
            self._config.read_file(configFile)
            val = self._config.get(section, key)
        return val

    def write(self, section, key, val):
        if not self._config.has_section(section):
            self._config.add_section(section)
        self._config.set(section, key, val)
        with open(self._ini_file_path, 'w') as configFile:
            self._config.write(configFile)

