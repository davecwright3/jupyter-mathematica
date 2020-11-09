FROM jupyter/minimal-notebook
MAINTAINER David Wright davecwright3@gmail.com

USER root
ENV NB_UID=1000
RUN apt update && apt install -y git libfontconfig libgl1-mesa-glx libasound2 wget avahi-daemon
RUN rm -rf /var/lib/apt/lists/*
ENV JUPYTER_ENABLE_LAB true

USER $NB_UID
RUN mkdir /home/jovyan/wolfram
RUN git -C /home/jovyan/wolfram clone https://github.com/WolframResearch/WolframLanguageForJupyter

RUN cd /home/jovyan/wolfram && wget https://account.wolfram.com/download/public/wolfram-engine/desktop/LINUX 
RUN chmod 777 /home/jovyan/wolfram/LINUX
USER root
RUN /home/jovyan/wolfram/LINUX
USER $NB_ID
RUN echo "export PATH=$PATH:"/usr/local/Wolfram/WolframEngine/12.1/SystemFiles/Kernel/Binaries/Linux-x86-64/"" >> /etc/environment

