#!/bin/bash

git fetch --all
git pull origin main

cd .. ; rm -rf backup3 ; sync
cp -r AzureKubernetes backup3
