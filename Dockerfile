FROM python:3.12

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app

COPY ./templates /code/templates

# This can be overridden in .env if declared in docker-compose
ENV MODE=production

# Set MODE=development in .env when run locally to listen for changes
CMD ["sh", "-c", "if [ \"$MODE\" = 'development' ]; then fastapi dev app/app.py --host 0.0.0.0 --port 8080 --reload; else fastapi run app/app.py --host 0.0.0.0 --port 8080; fi"]

#CMD ["fastapi", "run", "app/app.py", "--host", "0.0.0.0", "--port", "8080"]