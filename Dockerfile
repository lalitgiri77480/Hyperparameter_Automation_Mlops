FROM centos:latest
MAINTAINER Lalit Giri <lalitgiri396@gmail.com>
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN yum update -y
RUN yum install -y wget
RUN mkdir /root/MODEL/
VOLUME /root/MODEL/
#copy the model python in root directory
COPY cnn_dataset /root/MODEL/cnn_dataset
COPY model.py /root/MODEL
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda --version
RUN conda install tensorflow -y
RUN conda install keras -y
RUN conda install pillow -y
WORKDIR /root/MODEL/
# Running Python Application
CMD ["bin/bash"]
CMD ["python3","model.py"]