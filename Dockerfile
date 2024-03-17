FROM cgr.dev/chainguard/python:latest-dev AS build
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN pip install importlib-metadata

FROM gcr.io/distroless/python3
COPY --from=build /app /app
COPY --from=build /home/nonroot/.local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
ENV PYTHONPATH=/usr/local/lib/python3.12/site-packages \
                FLASK_APP=/app/app.py
WORKDIR /app
EXPOSE 5000
ENTRYPOINT python -m flask run --host=0.0.0.0
