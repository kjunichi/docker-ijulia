FROM ubuntu:14.04
MAINTAINER Junichi Kajiwara<junichi.kajiwara@gmail.com>
RUN echo "ab"
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends --fix-missing software-properties-common
RUN add-apt-repository ppa:staticfloat/juliareleases
RUN apt-get update
# 絶対ダイアログは出さない
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install --no-install-recommends --fix-missing -y python-pip python-zmq python-tornado \
libzmq-dev nettle-dev git ipython-notebook julia

RUN apt-get install --no-install-recommends --fix-missing -y libpython2.7 python-matplotlib \
python-scipy libmagickwand5 wget

WORKDIR /root
ENV TERM vt100
ADD ./ijulia/install.jl /ijulia.jl
RUN julia /ijulia.jl

ADD ./ijulia/notebook.sh /notebook.sh

RUN chmod u+x /notebook.sh
# Define default command.
#CMD ["bash"]
# 絶対ダイアログは出さないを戻しとく
ENV DEBIAN_FRONTEND dialog

EXPOSE 8998
CMD ["/notebook.sh"]
