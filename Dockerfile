FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

# 기본 의존성 설치 (버전 고정 없이 안정성 우선)
RUN apt-get update && apt-get install -y \
    libsndfile1 \
    ffmpeg \
    sox \
    git curl vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Python 패키지 설치
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r /app/requirements.txt

# 프로젝트 복사
COPY . /app
WORKDIR /app

CMD ["python", "main.py"]