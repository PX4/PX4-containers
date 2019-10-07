#!/usr/bin/env python

# Copyright (c) 2015 UAVenture AG. All rights reserved.

# import roslib
# roslib.load_manifest('broadcaster')
# import rospy
from pymavlink import mavutil
import socket
import time
import SocketServer
import threading

# from mavros_msgs.msg import State as VehicleState


class Broadcaster(object):

    def __init__(self):
        mavutil.set_dialect("pixhawk")
        self._mavlink = mavutil.mavlink.MAVLink(None, )

        # rospy.Subscriber("/mavros/state", VehicleState, self._vehicle_state_callback)

    def start(self):
        # rate = rospy.Rate(2)
        # sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        # sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        # sock.bind(("", 1233))

        # server = Server(sock)
        # server.start()

        server = ThreadingUDPServer(("", 1233), MessageHandler)
        server.socket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        server_thread = threading.Thread(target=server.serve_forever)
        server_thread.daemon = True
        server_thread.start()

        # while not rospy.is_shutdown():
        while 1:
            msg = self._mavlink.heartbeat_encode(0, 0, 0, 0, 0)
            buf = msg.pack(self._mavlink)
            print(":".join("{:02x}".format(ord(c)) for c in buf))
            server.socket.sendto(buf, ("192.168.1.255", 14550))
            time.sleep(0.5)
            # rate.sleep()

        server.shutdown = True

    def _vehicle_state_callback(self, data):
        pass


class Server(threading.Thread):
    def __init__(self, sock):
        threading.Thread.__init__(self)
        self._sock = sock
        self.shutdown = False

    def run(self):
        while not self.shutdown:
            data, addr = self._sock.recvfrom(1024)  # buffer size is 1024 bytes
            # print "received message:", data
            print("received data from:", addr)


class ThreadingUDPServer(SocketServer.ThreadingMixIn, SocketServer.UDPServer):
    pass


class MessageHandler(SocketServer.BaseRequestHandler):

    def handle(self):
        data = self.request[0]
        socket = self.request[1]
        print(self.client_address)


# Main function.
def main():
    # rospy.init_node('broadcaster')
    # try:
        broadcaster = Broadcaster()
        broadcaster.start()
    # except rospy.ROSInterruptException:
    #     pass


if __name__ == '__main__':
    main()
