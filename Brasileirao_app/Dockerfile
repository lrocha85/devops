FROM python:3.8.9

WORKDIR /code

COPY ./requirements.txt requirements.txt

RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY ./app.py .

CMD [ "uvicorn", "app:app", "--host", "0.0.0.0",  "--port", "80" ]