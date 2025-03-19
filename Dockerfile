# Let's build a Dockerfile to run our tests for ash model plotting
# We use miniconda because the Iris package and its dependencies are
# easiest to install from the conda-forge repository.
FROM continuumio/miniconda3

COPY conda_environment.yml /tmp/conda_environment.yml
RUN conda env create -f /tmp/conda_environment.yml

ENV APP=/app
ENV PYTHONPATH=$APP
WORKDIR $APP
# RUN mkdir ash-model-plotting

# Copy app files to container
RUN echo ""
COPY setup.py README.md .flake8 $APP/
COPY ash_model_plotting/ $APP/ash_model_plotting
COPY test/ $APP/test
RUN pip install -e .

# Clear old caches, if present
RUN find . -regextype posix-egrep -regex '.*/__pycache__.*' -delete

# docker run -ti --rm \
# -v ./ash_model_plotting:/app/ash_model_plotting \
# -v ./test:/app/test \
# -v ./tmp:/tmp \
# ash:latest /bin/bash