#!/usr/bin/python
# Copyright (c) 2014 Adafruit Industries
# Author: Tony DiCola

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import sys

import Adafruit_DHT

import pymysql

import time

import datetime

import RPi.GPIO as GPIO


#./AdafruitDHT_MySQL.py 22 2

# Parse command line parameters.
# sensor_args = { '11': Adafruit_DHT.DHT11,
#                '22': Adafruit_DHT.DHT22,
#                '2302': Adafruit_DHT.AM2302 }

#humidity, temperature = Adafruit_DHT.read_retry(Adafruit_DHT.DHT22, 2)


GPIO.setmode(GPIO.BCM)
GPIO.setup(4,GPIO.OUT)

db = pymysql.connect(host="rasberry1.cormbfdskqps.ap-northeast-2.rds.amazonaws.com", port=3306, user="admin", passwd="rasberry", db="rasberry")
cursor = db.cursor()

isOn = 0
preMinute = -1
nextMinute = -1

while True:
    
    nowTime = datetime.datetime.now()
    nextMinute = nowTime.strftime("%M")

    print('---------now------------------------------------')
    print(nowTime)
    print(preMinute, nextMinute)
    print('------------------------------------------------')

    humidity_in, temperature_in = Adafruit_DHT.read_retry(Adafruit_DHT.DHT22, 3)
    humidity_out, temperature_out = Adafruit_DHT.read_retry(Adafruit_DHT.DHT22, 2)
    
        
    if humidity_in > (humidity_out+2) or temperature_in > (temperature_out+0.2) :
        if temperature_in > 20 and humidity_in > 50 :
            GPIO.output(4,True)
            isOn = 1
        else:    
            GPIO.output(4,False)
            isOn = 0
    else:
        GPIO.output(4,False)
        isOn = 0

    #if humidity is not None and temperature is not None:
    print('Temp=({0:0.1f}*,{2:0.1f}*)   Humidity=({1:0.1f}%,{3:0.1f}%)  State={4:d}'.format(temperature_in, humidity_in, temperature_out, humidity_out, isOn))
    #else:
    #    print('Failed to get reading. Try again!')
    if preMinute != nextMinute:
        insert_sql = 'insert into temp_hud values(%s, %s, %s, %s, %s, %s, %s)'
        cursor.execute(insert_sql, (nowTime,temperature_in, humidity_in,isOn,'testserial', temperature_out, humidity_out));
        db.commit()

    preMinute = nextMinute
    print("-----------------------------------------------")



