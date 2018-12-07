FROM python:2.7
ADD ./monitor.py /
ADD ./requirements.txt /
RUN pip install -r /requirements.txt
CMD [ "python", "/monitor.py" ]
EXPOSE 8000
