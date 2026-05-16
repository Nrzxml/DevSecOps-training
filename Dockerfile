FROM python:3.11-alpine3.23

RUN addgroup -S app && adduser -S app -G app \
    && apk update && apk upgrade --no-cache \
    && apk add --no-cache ca-certificates

WORKDIR /app

# Upgrade pip, setuptools, wheel to fix known CVEs before installing requirements
RUN python -m pip install --upgrade pip setuptools wheel

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

USER app

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
