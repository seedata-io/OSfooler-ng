ARG PYTHON_VERSION=3.12.2
FROM python:${PYTHON_VERSION}-slim as base

WORKDIR /app

COPY . .

RUN apt-get -qy update && apt-get install -qy libnetfilter-queue1 libnetfilter-queue-dev build-essential iptables

RUN cd /app && python -m pip install -r requirements.txt
RUN cd /app && python setup.py install
RUN osfooler-ng -u

ARG personality
ENV PERSONALITY="${personaliy:-Linux 5.0}"

ENTRYPOINT ["/app/run.sh"]
