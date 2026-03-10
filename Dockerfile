# xiaoai 自定义后端：WebSocket 服务，与 Open-XiaoAI 客户端对接
FROM python:3.11-slim

WORKDIR /app

# 依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 代码与资源
COPY __init__.py main.py config.py audio_loader.py protocol.py transport.py pipeline.py vad.py asr.py wake.py intent.py .
COPY config.example.yaml .
COPY audio/ ./audio/

# 小米音响 / Open-XiaoAI 客户端连 4399
EXPOSE 4399

ENV PYTHONUNBUFFERED=1

CMD ["python", "-m", "main"]
