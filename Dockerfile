FROM python:3.9.15
ADD requirements.txt /
RUN pip install -r requirements.txt
ADD welcome.py /
CMD [ "python", "./welcome.py" ]