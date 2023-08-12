FROM python:3

RUN python3 -m pip install kafka-python

COPY sales_generator /sales_generator
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]