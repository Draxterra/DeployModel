FROM python:3.9-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libhdf5-dev

WORKDIR /app

COPY . /app

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
