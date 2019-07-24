FROM swipl:8.0.3

WORKDIR /opt/remoria

RUN useradd prolog

COPY . .

USER prolog

CMD ["swipl","app.pl"]
