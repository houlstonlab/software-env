# Start from the Rocker Verse image
FROM rocker/verse:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install BiocManager and the desired Bioconductor package
RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('TxDb.Hsapiens.UCSC.hg38.knownGene')"
RUN R -e "BiocManager::install('BSgenome.Hsapiens.UCSC.hg38')"
