FROM python:3.11

RUN apt-get update && apt-get install -y \
  libncurses5

RUN groupadd -r mxg -g 1001 && \
  useradd -m -u 1002 -g mxg -s /bin/sh -c "Non-root user for mxpy" mx

COPY entrypoint.sh /entrypoint.sh
ADD https://raw.githubusercontent.com/multiversx/mx-sdk-py-cli/main/mxpy-up.py mxpy-up.py

RUN chown mx:mxg mxpy-up.py && \
  chown mx:mxg entrypoint.sh

USER mx
RUN python3 mxpy-up.py

ENTRYPOINT ["/entrypoint.sh"]
