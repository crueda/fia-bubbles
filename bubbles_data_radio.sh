#!/usr/bin/env python
#-*- coding: UTF-8 -*-

# autor: Carlos Rueda
# fecha: 2015-01-22
# mail: carlos.rueda@deimos-space.com

import datetime
import os
import sys
import MySQLdb as mdb
import math
import json 

con = None

RSSI = [0] * 10
SATS = [0] * 10
SPEED = [0.0] * 10
RSSI_ANTERIOR = [0] * 10
SATS_ANTERIOR = [0] * 10
SPEED_ANTERIOR = [0.0] * 10

try:
	json_data = open('/var/www/jqplot/fia/data.txt')
	#json_data=open('./data.txt')
	data = json.load(json_data)
	SATS_ANTERIOR[1] = data[0][0]
	SATS_ANTERIOR[2] = data[1][0]
	SATS_ANTERIOR[3] = data[2][0]
	SATS_ANTERIOR[4] = data[3][0]
	SATS_ANTERIOR[5] = data[4][0]
	SATS_ANTERIOR[6] = data[5][0]
	SATS_ANTERIOR[7] = data[6][0]

	RSSI_ANTERIOR[1] = data[0][1]
	RSSI_ANTERIOR[2] = data[1][1]
	RSSI_ANTERIOR[3] = data[2][1]
	RSSI_ANTERIOR[4] = data[3][1]
	RSSI_ANTERIOR[5] = data[4][1]
	RSSI_ANTERIOR[6] = data[5][1]
	RSSI_ANTERIOR[7] = data[6][1]

	SPEED_ANTERIOR[1] = data[0][2]
	SPEED_ANTERIOR[2] = data[1][2]
	SPEED_ANTERIOR[3] = data[2][2]
	SPEED_ANTERIOR[4] = data[3][2]
	SPEED_ANTERIOR[5] = data[4][2]
	SPEED_ANTERIOR[6] = data[5][2]
	SPEED_ANTERIOR[7] = data[6][2]
except:
	pass

json_data.close()

fichero_salida = open('/var/www/jqplot/fia/data.txt', 'w')
#fichero_salida = open('./data.txt', 'w')

try:

	con = mdb.connect('192.168.60.6', 'root', 'r000.tdei.fia', 'KyrosFia')
	#con = mdb.connect('127.0.0.1', 'root', 'root', 'KyrosFia')
     
	cur = con.cursor()
	cur.execute("SELECT SATS,RSSI,GPS_SPEED FROM TRACKING_1 where VEHICLE_LICENSE='001'")
	numrows = int(cur.rowcount)
	for i in range(numrows):
		row = cur.fetchone()
		SATS[1] = row[0]
		RSSI[1] = row[1]
		SPEED[1] = row[2]
	
	cur.execute("SELECT SATS,RSSI,GPS_SPEED FROM TRACKING_1 where VEHICLE_LICENSE='002'")
	numrows = int(cur.rowcount)
	for i in range(numrows):
		row = cur.fetchone()
		SATS[2] = row[0]
		RSSI[2] = row[1]
		SPEED[2] = row[2]

	cur.execute("SELECT SATS,RSSI,GPS_SPEED FROM TRACKING_1 where VEHICLE_LICENSE='003'")
	numrows = int(cur.rowcount)
	for i in range(numrows):
		row = cur.fetchone()
		SATS[3] = row[0]
		RSSI[3] = row[1]
		SPEED[3] = row[2]

	cur.execute("SELECT SATS,RSSI,GPS_SPEED FROM TRACKING_1 where VEHICLE_LICENSE='004'")
	numrows = int(cur.rowcount)
	for i in range(numrows):
		row = cur.fetchone()
		SATS[4] = row[0]
		RSSI[4] = row[1]
		SPEED[4] = row[2]

	cur.execute("SELECT SATS,RSSI,GPS_SPEED FROM TRACKING_1 where VEHICLE_LICENSE='005'")
	numrows = int(cur.rowcount)
	for i in range(numrows):
		row = cur.fetchone()
		SATS[5] = row[0]
		RSSI[5] = row[1]
		SPEED[5] = row[2]

	cur.execute("SELECT SATS,RSSI,GPS_SPEED FROM TRACKING_1 where VEHICLE_LICENSE='006'")
	numrows = int(cur.rowcount)
	for i in range(numrows):
		row = cur.fetchone()
		SATS[6] = row[0]
		RSSI[6] = row[1]
		SPEED[6] = row[2]

	cur.execute("SELECT SATS,RSSI,GPS_SPEED FROM TRACKING_1 where VEHICLE_LICENSE='007'")
	numrows = int(cur.rowcount)
	for i in range(numrows):
		row = cur.fetchone()
		SATS[7] = row[0]
		RSSI[7] = row[1]
		SPEED[7] = row[2]


	#compara valores
	if RSSI[1] == 0:
		RSSI[1] = RSSI_ANTERIOR[1]
		SATS[1] = SATS_ANTERIOR[1]
		SPEED[1] = SPEED_ANTERIOR[1]
	if RSSI[2] == 0:
		RSSI[2] = RSSI_ANTERIOR[2]
		SATS[2] = SATS_ANTERIOR[2]
		SPEED[2] = SPEED_ANTERIOR[2]
	if RSSI[3] == 0:
		RSSI[3] = RSSI_ANTERIOR[3]
		SATS[3] = SATS_ANTERIOR[3]
		SPEED[3] = SPEED_ANTERIOR[3]
	if RSSI[4] == 0:
		RSSI[4] = RSSI_ANTERIOR[4]
		SATS[4] = SATS_ANTERIOR[4]
		SPEED[4] = SPEED_ANTERIOR[4]
	if RSSI[5] == 0:
		RSSI[5] = RSSI_ANTERIOR[5]
		SATS[5] = SATS_ANTERIOR[5]
		SPEED[5] = SPEED_ANTERIOR[5]
	if RSSI[6] == 0:
		RSSI[6] = RSSI_ANTERIOR[6]
		SATS[6] = SATS_ANTERIOR[6]
		SPEED[6] = SPEED_ANTERIOR[6]
	if RSSI[7] == 0:
		RSSI[7] = RSSI_ANTERIOR[7]
		SATS[7] = SATS_ANTERIOR[7]
		SPEED[7] = SPEED_ANTERIOR[7]

	fichero_salida.writelines ( '[[%s,%s,%s,"001"],[%s,%s,%s,"002"],[%s,%s,%s,"003"],[%s,%s,%s,"004"],[%s,%s,%s,"005"],[%s,%s,%s,"006"],[%s,%s,%s,"007"]]' % (SATS[1],RSSI[1],SPEED[1],SATS[2],RSSI[2],SPEED[2],SATS[3],RSSI[3],SPEED[3],SATS[4],RSSI[4],SPEED[4],SATS[5],RSSI[5],SPEED[5],SATS[6],RSSI[6],SPEED[6],SATS[7],RSSI[7],SPEED[7])) 



except mdb.Error, e:
  
    print "Error %d: %s" % (e.args[0], e.args[1])
    sys.exit(1)

finally:
    
    if con:
        con.close()

fichero_salida.close()