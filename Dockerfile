FROM python:3.12-slim

WORKDIR /function

COPY main.py requirements.txt ./

RUN pip install --upgrade pip --no-cache-dir --root-user-action=ignore && pip install -r requirements.txt --no-cache-dir --root-user-action=ignore

ENTRYPOINT [ "/usr/local/bin/python", "-m", "awslambdaric" ]

CMD ["main.lambda_handler"]