FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root
ENV PATH="$HOME/bin:$PATH"
ENV BCFTOOLS_PLUGINS="$HOME/bin"

# Install basic tools and dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    git \
    g++ \
    gcc \
    make \
    autoconf \
    pkg-config \
    zlib1g-dev \
    bwa \
    samtools \
    msitools \
    cabextract \
    mono-devel \
    libgdiplus \
    icu-devtools \
    bcftools \
    libbz2-dev \
    libssl-dev \
    liblzma-dev \
    libgsl0-dev \
    libncurses5-dev \
    libcurl4-gnutls-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Preparation steps - create directories
RUN mkdir -p $HOME/bin $HOME/GRCh37 $HOME/GRCh38

# Download BCFtools source
WORKDIR /tmp
RUN wget https://github.com/samtools/bcftools/releases/download/1.20/bcftools-1.20.tar.bz2 && \
    tar xjf bcftools-1.20.tar.bz2

# Download and setup custom plugins
WORKDIR /tmp/bcftools-1.20
RUN rm -f plugins/{idat2gtc.c,gtc2vcf.c,gtc2vcf.h,affy2vcf.c} || true && \
    wget -P plugins https://raw.githubusercontent.com/freeseek/gtc2vcf/master/idat2gtc.c && \
    wget -P plugins https://raw.githubusercontent.com/freeseek/gtc2vcf/master/gtc2vcf.c && \
    wget -P plugins https://raw.githubusercontent.com/freeseek/gtc2vcf/master/gtc2vcf.h && \
    wget -P plugins https://raw.githubusercontent.com/freeseek/gtc2vcf/master/affy2vcf.c && \
    wget -P plugins https://raw.githubusercontent.com/freeseek/gtc2vcf/master/BAFregress.c

# Configure and compile BCFtools
RUN ./configure --prefix=$HOME --enable-plugins && \
    make -j$(nproc)

# Install BCFtools and plugins
RUN cp bcftools $HOME/bin/ && \
    ls -la plugins/ && \
    find plugins -name "*.so" -ls && \
    find plugins -name "*.so" -exec cp {} $HOME/bin/ \; || echo "No .so files found, trying manual compilation..."

# Manual plugin compilation if needed
RUN cd plugins && \
    for plugin in idat2gtc gtc2vcf affy2vcf BAFregress; do \
        if [ -f "${plugin}.c" ]; then \
            echo "Compiling ${plugin}..."; \
            gcc -shared -fPIC -o ${plugin}.so ${plugin}.c -I.. $(pkg-config --cflags --libs gsl) || echo "Failed to compile ${plugin}"; \
        fi; \
    done && \
    ls -la *.so && \
    cp *.so $HOME/bin/ || echo "No plugins compiled"

# Verify installation
RUN ls -la $HOME/bin/ && \
    $HOME/bin/bcftools --version

# Install Affymetrix Analysis Power Tools (APT)
RUN wget https://downloads.thermofisher.com/APT/APT_2.11.8/apt_2.11.8_linux_64_x86_binaries.zip && \
    unzip -ojd $HOME/bin apt_2.11.8_linux_64_x86_binaries.zip apt_2.11.8_linux_64_x86_binaries/bin/apt-probeset-genotype && \
    chmod a+x $HOME/bin/apt-probeset-genotype && \
    rm apt_2.11.8_linux_64_x86_binaries.zip

# Clean up tmp directory
RUN rm -rf /tmp/*

# Set working directory
WORKDIR $HOME

# Default command
CMD ["/bin/bash"]