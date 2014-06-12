#!/bin/bash

sudo $EDITOR /etc/hosts.d/hosts.conf && sudo /opt/edithosts/gethosts.sh || sudo nano /etc/hosts.d/hosts.conf && sudo /opt/edithosts/gethosts.sh

exit 0
