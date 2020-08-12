FROM jupyter/base-notebook
MAINTAINER David Wright davecwright3@gmail.com

USER root
RUN apt update && apt install -y git libfontconfig libgl1-mesa-glx libasound2


RUN conda update --all

ENV JUPYTER_ENABLE_LAB true

RUN mkdir /home/system
RUN git -C /home/system clone https://github.com/WolframResearch/WolframLanguageForJupyter

COPY --chown=root:root WolframEngine_12.0.1_LINUX.sh /home/system/wolfram_installer.sh
RUN chmod 777 /home/system/wolfram_installer.sh
RUN /home/system/wolfram_installer.sh

RUN echo "export PATH=$PATH:"/usr/local/Wolfram/WolframEngine/12.0/SystemFiles/Kernel/Binaries/Linux-x86-64/"" > /etc/environment

ENTRYPOINT ["/bin/bash"]
