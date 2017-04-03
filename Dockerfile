FROM fedora:latest

# Install Maya
RUN dnf -y install wget tar git && \
    wget http://download.autodesk.com/us/support/files/maya_2016_service_pack_1/Autodesk_Maya_2016_SP1_EN_Linux_64bit.tgz -O maya.tgz && \
    mkdir /maya && \
    tar -xvf maya.tgz -C /maya && \
    rm maya.tgz && \
    rpm -Uvh /maya/Maya*.rpm && \
    rm -r /maya

RUN dnf -y install 'dnf-command(copr)' && \
    dnf copr -y enable mjg/libtiff3 && \
    dnf -y install \
        procps tcsh \
        mesa-libGL mesa-libGLU \
        libXp libXmu libXpm libXi libtiff libtiff3 libpng12 \
        fontconfig libXinerama libXrender libXrandr gamin \
        gstreamer-plugins-base

RUN mkdir /output && \
    mkdir /python-libraries && \
    echo Installing Nimble And PyAid && \
    git clone https://github.com/sernst/Nimble.git /python-libraries/nimble && \
    git clone https://github.com/sernst/PyAid.git /python-libraries/pyaid

# Make mayapy the default Python
RUN echo alias hpython="\"/usr/autodesk/maya/bin/mayapy\"" >> ~/.bashrc && \
    echo alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

# Setup environment
ENV MAYA_LOCATION=/usr/autodesk/maya/
ENV PATH=$MAYA_LOCATION/bin:$PATH
ENV PYTHONPATH=/libraries:/python-libraries/nimble/src:/python-libraries/pyaid/src:$PYTHONPATH

# Workaround for "Segmentation fault (core dumped)"
# See https://forums.autodesk.com/t5/maya-general/render-crash-on-linux/m-p/5608552/highlight/true
ENV MAYA_DISABLE_CIP=1

COPY runner /runner

EXPOSE 7800
EXPOSE 7801
EXPOSE 8000

WORKDIR /output

CMD ["/runner/run.sh"]
