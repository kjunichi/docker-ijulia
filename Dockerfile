FROM ubuntu:15.10
MAINTAINER Junichi Kajiwara<junichi.kajiwara@gmail.com>
RUN apt-get update && \
apt-get upgrade -y && \
apt-get update

# 絶対ダイアログは出さない
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install --no-install-recommends --fix-missing -y python3-pip \
python3-zmq python3-tornado \
libzmq3-dev nettle-dev git python3-matplotlib \
python3-scipy libmagickwand-dev wget gfortran m4 cmake libpython3.4 \
python3.4-dev
WORKDIR /root
ENV TERM vt100
RUN wget https://github.com/JuliaLang/julia/releases/download/v0.4.2/julia-0.4.2.tar.gz \
 && tar xvf julia-0.4.2.tar.gz
RUN  cd /root/julia-0.4.2 && make -j8 && \
echo "prefix=/usr/local">/root/julia-0.4.2/Make.user && \
make install && pip3 install jupyter
RUN ln -s /usr/lib/x86_64-linux-gnu/libpython3.4m.so /usr/lib/x86_64-linux-gnu/libpython.so
RUN echo "da"
ADD ./ijulia/install.jl /ijulia.jl
ADD ./ijulia/notebook.sh /notebook.sh

RUN /usr/local/bin/julia /ijulia.jl
RUN chmod u+x /notebook.sh
# Define default command.
#CMD ["bash"]
# 絶対ダイアログは出さないを戻しとく
ENV DEBIAN_FRONTEND dialog

EXPOSE 8998
CMD ["/notebook.sh"]
