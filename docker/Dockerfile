FROM python:3.9 AS builder

WORKDIR /app

# Create appuser
ENV USER=appuser
ENV UID=10001

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"

COPY src .

RUN pip3 install poetry
RUN python -m venv /venv
RUN poetry export -f requirements.txt | /venv/bin/pip install -r /dev/stdin

RUN poetry build && /venv/bin/pip install dist/*.whl

RUN  /venv/bin/python  /venv/lib/python3.9/site-packages/tessian-platform-interview-challenge/manage.py makemigrations
RUN  /venv/bin/python  /venv/lib/python3.9/site-packages/tessian-platform-interview-challenge/manage.py migrate


FROM python:3.9-slim
COPY --from=builder /venv /venv
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

# Use an unprivileged user.
USER appuser:appuser

ENTRYPOINT [ "/venv/bin/python", "/venv/lib/python3.9/site-packages/tessian-platform-interview-challenge/manage.py", "runserver", "0.0.0.0:8000"] 
