#!/bin/bash

#Install python-setuptools and what we need to install these packages from source.
apt-get install python-setuptools python-dev python-pip python-matplotlib

#Install python packages we'll rely on.
pip install -U numpy
pip install -U scikit-learn pandas ipython pyzmq jinja2 tornado
