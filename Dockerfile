FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
build-essential \
libhdf5-dev \
    python3-dev \
    pkg-config \
    gcc \
    g++

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip

RUN pip install --no-cache-dir numpy==1.26.4 Pillow==10.3.0 \
    tensorflow==2.16.1 fastapi==0.111.0 uvicorn==0.30.1

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
