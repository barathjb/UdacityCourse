FROM python:3.10-slim-buster

USER root

WORKDIR /src

COPY ./requirements.txt requirements.txt

RUN chmod 1777 /tmp 

# Installing postgres binaries
RUN apt-get update -y && apt-get install -y build-essential libpq-dev

# Installing dependencies
RUN pip install -r requirements.txt

COPY . .

#CMD python app.py
CMD DB_USERNAME="postgres" DB_PASSWORD="wFomvhjHcl" python app.py
