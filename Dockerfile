FROM ubuntu:16.04
LABEL MAINTAINER Rich Rose

# Env Variables
ENV YYAPGVB yapgvb-1.2.3-source.tar.gz
ENV QUICKDIAGRAM quickdiagrams.tar.gz
ENV SETUPTOOLS setuptools-0.6c11.tar.gz

# Install packages
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y curl \
    graphviz \
    python \
    wget \
    xz-utils

# Download - YYAPGVB
WORKDIR /tmp
RUN curl -o /tmp/$YYAPGVB https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/yapgvb/yapgvb-1.2.3-source.tar.gz \
    && tar -xvf $YYAPGVB -C /tmp \
    && sed -i 's/use_boost = True/use_boost = False/g' /tmp/yapgvb-1.2.3-source/config_linux2.py

# Download - QUICKDIAGRAM
RUN curl -o /tmp/$QUICKDIAGRAM https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/quickdiagrams/quickdiagrams.tar.gz \
    &&  tar -xvf $QUICKDIAGRAM -C /tmp

# Download - SETUPTOOLS
RUN wget -P /tmp https://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz \
    && tar -xvf $SETUPTOOLS

# Install 
WORKDIR /tmp/yapgvb-1.2.3-source
RUN python setup.py install

WORKDIR /tmp/setuptools-0.6c11
RUN python setup.py install

WORKDIR /tmp/quickdiagrams
RUN python setup.py install

# Call the application
ENTRYPOINT [ "quickclassdiagram" ]
CMD [ "--help" ]
