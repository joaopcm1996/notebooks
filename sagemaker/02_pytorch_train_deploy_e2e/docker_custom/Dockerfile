FROM pytorch/pytorch:1.9.1-cuda11.1-cudnn8-runtime

RUN apt update
RUN apt install -y build-essential

RUN pip3 install -U pip
RUN pip3 install sagemaker-training

# You can add your code inside container image, but there is no need to, you can still use script mode with training toolkit
# COPY code/* /opt/ml/code/

# Needed if you copy code into container, automatically set if you launch via SM SDK
# Defines train.py as script entry point
# ENV SAGEMAKER_PROGRAM cifar10_pytorch.py