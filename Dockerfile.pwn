ARG BASE_IMAGE=base
FROM ${BASE_IMAGE}

COPY scripts/install-pwn.sh /tmp/scripts/install-pwn.sh
RUN /tmp/scripts/install-pwn.sh
