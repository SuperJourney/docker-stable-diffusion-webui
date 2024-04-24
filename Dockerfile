FROM python:3.10.6

RUN apt-get update 

WORKDIR /sd

RUN mkdir repos && cd repos  && git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

RUN cd repos/stable-diffusion-webui && pip install -r requirements.txt
# From ubuntu:22.04
RUN cd repos/stable-diffusion-webui && sed -i 's/#venv_dir="venv"/venv_dir="-"/' webui-user.sh

RUN apt-get install -y libgl1-mesa-glx


RUN cd repos/stable-diffusion-webui && sed -i 's/    start()/#    start()/' launch.py  && python launch.py --skip-torch-cuda-test


RUN  cd  /sd/repos && git clone https://github.com/facebookresearch/xformers.git && \
    cd xformers && \
    git submodule update --init --recursive && \
    pip install -r requirements.txt && \
    pip install -e .

WORKDIR /stable-diffusion-webui

RUN cp -r /sd/repos/stable-diffusion-webui/* .

RUN rm -rf /stable-diffusion-webui/models/Stable-diffusion

COPY ./data/models/Stable-diffusion/v1-5-pruned-emaonly.safetensors /stable-diffusion-webui/models/Stable-diffusion/v1-5-pruned-emaonly.safetensors

RUN sed -i '28,42d' launch.py &&  sed -i 's/#    start()/    start()/' launch.py



ENTRYPOINT ["python"]

CMD ["/stable-diffusion-webui/launch.py", "--share","--xformers"]