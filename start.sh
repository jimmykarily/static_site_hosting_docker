#!/bin/bash
/etc/init.d/ssh start &
nginx -g "daemon off;"
