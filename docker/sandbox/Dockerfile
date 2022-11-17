FROM cadic/whisper:vanilla
USER root

# Entrypoint
RUN echo "jupyter notebook --ip 0.0.0.0" >> /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    chown foo:foo /entrypoint.sh

# Entrypoint
WORKDIR /workspace
# Prepare for setup
COPY Makefile /workspace/
COPY dist  /workspace/dist
# Install the package
RUN pip install /workspace/dist/*.whl

USER foo
CMD ["/bin/sh", "/entrypoint.sh"]


