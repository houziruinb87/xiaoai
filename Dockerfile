# xiaoai 自定义后端：WebSocket 服务，与 Open-XiaoAI 客户端对接
# 使用国内镜像源，便于 NAS 等环境拉取（若直连 Docker Hub 正常可改为 python:3.11-slim）
FROM docker.xuanyuan.me/library/python:3.11-slim

WORKDIR /app

# 依赖（使用清华 PyPI 镜像，便于国内/NAS 环境）
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 代码与资源
COPY __init__.py main.py config.py audio_loader.py protocol.py transport.py pipeline.py vad.py asr.py wake.py intent.py .
COPY config.example.yaml .
COPY audio/ ./audio/

# 小米音响 / Open-XiaoAI 客户端连 4399
EXPOSE 4399

ENV PYTHONUNBUFFERED=1

CMD ["python", "-m", "main"]
