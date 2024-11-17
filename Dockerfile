#############Base image############
FROM python:3.12-slim as base
WORKDIR /app
RUN apt-get update && rm -rf /var/lib/apt/lists/*
###########COPY THE CODE
COPY app.py /app
###########CREATE AND COPY THE INDEX.HTML FILE
RUN mkdir /app/templates
COPY index.html /app/templates
###########COPY the requirements.txt file
COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt
############INSTALL GUNICORN(WEBSERVER/HTTP)
RUN pip install gunicorn


###########FINAL STAGE#########
FROM base as final
WORKDIR /app

CMD ["gunicorn","--bind","0.0.0.0:5000","app:app"]

