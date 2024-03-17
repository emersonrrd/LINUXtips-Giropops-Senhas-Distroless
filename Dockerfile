FROM cgr.dev/chainguard/python:latest-dev as builder
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt --user

FROM cgr.dev/chainguard/python:latest
WORKDIR /app
COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages
COPY --from=builder /home/nonroot/.local/bin  /home/nonroot/.local/bin
COPY --from=builder /app .
ENV PATH=$PATH:/home/nonroot/.local/bin \
        FLASK_APP=/app/app.py

ENTRYPOINT [ "python", "/app/app.py" ]
