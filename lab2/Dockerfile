FROM python:3.10-alpine

WORKDIR /app
COPY app/ .

RUN pip install psycopg2-binary

CMD ["python", "app.py"]