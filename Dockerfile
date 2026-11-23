FROM python:3.11-slim

WORKDIR /home/myapp

RUN pip install --no-cache-dir flask

COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/

EXPOSE 5050

CMD ["python3", "/home/myapp/sample_app.py"]