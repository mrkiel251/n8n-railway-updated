FROM alpine:3.24 AS builder
RUN apk add --no-cache python3 py3-pip ffmpeg
RUN pip3 install --no-cache-dir --break-system-packages yt-dlp

FROM n8nio/n8n:latest
USER root
COPY --from=builder /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=builder /usr/bin/ffprobe /usr/bin/ffprobe
COPY --from=builder /usr/lib/python3.14 /usr/lib/python3.14
COPY --from=builder /usr/bin/python3.14 /usr/bin/python3.14
COPY --from=builder /usr/bin/python3 /usr/bin/python3
COPY --from=builder /usr/bin/yt-dlp /usr/bin/yt-dlp
