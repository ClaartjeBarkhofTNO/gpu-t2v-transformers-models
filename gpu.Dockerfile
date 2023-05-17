FROM nvidia/cuda:11.7.0-cudnn8-runtime-ubuntu22.04

WORKDIR /app

# Installs Python 3.10 which is what we need
RUN apt-get update && apt-get install -y python3 python3-pip python3-wheel python3-setuptools

# Includes torch 2.0
COPY requirements.txt .
RUN pip3 install -r requirements.txt

ARG MODEL_NAME

COPY download.py .
RUN python3 download.py

COPY . .

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["uvicorn app:app --host 0.0.0.0 --port 8080"]