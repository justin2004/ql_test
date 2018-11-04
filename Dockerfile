FROM debian:stretch

LABEL maintainer="justin"


#ADD sources.list /etc/apt
ADD install_it.lisp /root
ADD sample.lisp     /root

WORKDIR /root

RUN set -x \
    && apt-get update \
    && apt-get install -y sbcl \
    && apt-get install -y wget

# TODO gpg verification?
RUN wget 'https://beta.quicklisp.org/quicklisp.lisp'
RUN touch .sbclrc
RUN sbcl --load quicklisp.lisp --load install_it.lisp --eval '(quit)'
        

#EXPOSE 80

#STOPSIGNAL SIGTERM

CMD ["tail", "-f", "/dev/null"]
