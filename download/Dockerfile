FROM python:3.10.6

RUN pip install -U huggingface_hub hf_transfer

ENV HF_ENDPOINT=https://hf-mirror.com
ENV HF_HUB_ENABLE_HF_TRANSFER=1

## 下载底模

RUN  huggingface-cli download --local-dir-use-symlinks=False  --repo-type=model  --local-dir=/data/models/Stable-diffusion --include=v1-5-pruned-emaonly.safetensors  runwayml/stable-diffusion-v1-5 