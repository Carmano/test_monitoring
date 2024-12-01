#!/bin/bash

cp ./monitor_test.sh /usr/local/bin/
cp ./monitor_test.service /usr/lib/systemd/monitor_test.service
cp ./monitor_test.timer /usr/lib/systemd/monitor_test.timer

systemctl daemon-reload
systemctl enable monitor_test.timer
systemctl start monitor_test.timer
systemctl status monitor_test.timer
