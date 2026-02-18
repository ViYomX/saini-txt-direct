FROM python:3.12-bookworm

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    build-essential \
    ffmpeg \
    aria2 \
    cmake \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q https://github.com/axiomatic-systems/Bento4/archive/v1.6.0-639.zip \
    && unzip v1.6.0-639.zip \
    && cd Bento4-1.6.0-639 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && cp mp4decrypt /usr/local/bin/ \
    && cd ../.. \
    && rm -rf Bento4-1.6.0-639 v1.6.0-639.zip

RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade -r sainibots.txt \
    && python3 -m pip install -U yt-dlp

CMD ["python3", "modules/main.py"]