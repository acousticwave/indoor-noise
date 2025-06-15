# Base image with CUDA 11.8 and Python 3.10
FROM pytorch/pytorch:2.2.0-cuda11.8-cudnn8-runtime

# (1) Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# (2) Install pinned versions of system dependencies
RUN apt-get update && apt-get install -y \
    libsndfile1=1.0.28-7 \
    ffmpeg=7:4.3.6-0+deb11u1 \
    sox=14.4.2+git20190427-2 \
    git curl vim \
    && apt-mark hold libsndfile1 ffmpeg sox \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# (3) Install Python dependencies (torch/torchaudio versions pinned in requirements.txt)
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# (4) Copy all project files
COPY . /app

# (5) Set working directory
WORKDIR /app

# (6) Default entrypoint
CMD ["python", "main.py"]