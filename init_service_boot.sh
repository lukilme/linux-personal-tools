#!/bin/bash

echo "Service automatic boot system:"
systemctl list-unit-files --type=service | grep enabled