#!/bin/bash
# Example of how to deploy OVA directly vPodRouter
# ovftool is installed

ovftool -ds=dsLocalESX02 -nw=vPodNetwork -dm=thin IAAS.ova vi://esx02
