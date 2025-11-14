FROM python:3.10-alpine

WORKDIR /src
COPY src/ .

RUN pip install psycopg2-binary

CMD ["python", "app.py"]