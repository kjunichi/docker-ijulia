FROM ubuntu:14.04
MAINTAINER Junichi Kajiwara<junichi.kajiwara@gmail.com>
RUN echo "a"
RUN apt-get update
RUN apt-get install -y --no-install-recommends --fix-missing software-properties-common
RUN add-apt-repository ppa:staticfloat/juliareleases
RUN apt-get update
# 絶対ダイアログは出さない
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install --no-install-recommends --fix-missing -y python-pip python-zmq python-tornado \
libzmq-dev nettle-dev git ipython-notebook julia

ADD ./ijulia/install.jl /ijulia.jl
RUN julia /ijulia.jl

ADD ./ijulia/notebook.sh /notebook.sh

RUN chmod u+x /notebook.sh
# Define default command.
#CMD ["bash"]
CMD ["/notebook.sh"]
