FROM python:3.12.3

RUN mkdir /uir_app

WORKDIR /uir_app

COPY poetry.lock pyproject.toml ./
RUN pip install poetry && poetry config virtualenvs.create false && poetry install --no-dev

COPY conf /uir_app/conf
COPY src /uir_app/src
RUN cd /uir_app

CMD gunicorn -c conf/gunicorn.conf.py 'src.uir_app.main.web_api:create_app()'
