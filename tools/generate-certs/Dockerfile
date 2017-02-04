FROM python:2.7

RUN apt-get install -y git
RUN git clone https://github.com/lukas2511/dehydrated && \
    cd dehydrated && \
    git clone https://github.com/major/letsencrypt-rackspace-hook.git hooks/rackspace && \
    pip install -r hooks/rackspace/requirements.txt

ENV PYRAX_CREDS=/dehydrated/.pyrax
WORKDIR /dehydrated

ADD get-certs.sh .
RUN chmod +x get-certs.sh
CMD /dehydrated/get-certs.sh
