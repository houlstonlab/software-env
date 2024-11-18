# Use the Bioconductor Docker image as the base image
FROM bioconductor/bioconductor_docker

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    tzdata

# Install pedsuite package
RUN R -e "install.packages('tidyverse', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('pedsuite', repos='http://cran.rstudio.com/')"
RUN R -e "BiocManager::install('RVS')"

# Set environment variables
ENV LC_ALL=C
ENV LANG=C
ENV TZ=UTC
ENV R_LIBS_USER=/usr/local/lib/R/site-library

# Define the default command
CMD ["R"]