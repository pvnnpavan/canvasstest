FROM python:alpine
#FROM python:latest

ADD . /app

WORKDIR /app

RUN apk update && apk add bash

RUN /bin/bash -c "pip install virtualenv \
  && pip install source \
  && virtualenv venv -p python \
  && source venv/bin/activate \
  && pip install -r requirements.txt \
  && python manage.py makemigrations \
  && python manage.py migrate"


EXPOSE 8000
CMD ["/app/run_web.sh"]

