FROM swipl:8.1.8

WORKDIR /opt/remoria

RUN useradd prolog
RUN mkdir /opt/remoria/db
RUN chown prolog:prolog /opt/remoria/db

COPY . .

USER prolog

CMD ["swipl","app.pl"]
