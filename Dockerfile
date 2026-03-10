# xiaoai 自定义后端：WebSocket 服务，与 Open-XiaoAI 客户端对接
# 使用华为云 SWR 镜像（NAS 上若已存在该镜像则无需拉取，否则从华为云拉取较稳定）
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/python:3.11-slim-bullseye

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
