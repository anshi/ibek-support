#!/bin/bash

# dont compile iocBoot for container builds
# startup scripts will be generated by ibek instead
# (iocBoot depends on a DLS specific Make rule)

# sed -i '/iocBoot/d' Makefile

# don't try to build opis for container builds

sed -i '/opi/d'  TimingTemplatesApp/Makefile