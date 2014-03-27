FROM ubuntu
RUN apt-get update
RUN apt-get install -y git g++ python-dev python-pip libboost-dev libboost-test-dev libgsl0-dev libhdf5-serial-dev pkg-config
RUN pip install cython ipython pyzmq jinja2 tornado
RUN cd /tmp ; git clone git://github.com/ecell/ecell4
RUN cd /tmp/ecell4 ; git clone git://github.com/headmyshoulder/odeint-v2
RUN cd /tmp/ecell4 ; PREFIX=/usr/local PYTHONPATH=/usr/local/lib/python2.7/site-packages bash /tmp/ecell4/install.sh core core_python gillespie gillespie_python
RUN cd /tmp/ecell4 ; PREFIX=/usr/local PYTHONPATH=/usr/local/lib/python2.7/site-packages CPLUS_INCLUDE_PATH=/tmp/ecell4/odeint-v2 bash /tmp/ecell4/install.sh ode ode_python
EXPOSE 80
CMD ipython notebook --ip=* --port=80 --MappingKernelManager.time_to_dead=10 --MappingKernelManager.first_beat=3
