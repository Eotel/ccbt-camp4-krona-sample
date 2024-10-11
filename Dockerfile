FROM --platform=linux/amd64 ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV QIIME2_DISTRO=amplicon

ENV PATH="/root/miniconda3/bin:${PATH}"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    git \
    ca-certificates \
    make \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p ~/miniconda3 && \
    rm ~/miniconda.sh

RUN ~/miniconda3/bin/conda init bash

# Create QIIME2 environment
RUN conda config --add channels defaults && \
    conda update -n base conda && \
    conda env create -n qiime2-${QIIME2_DISTRO}-2024.5 --file https://data.qiime2.org/distro/${QIIME2_DISTRO}/qiime2-${QIIME2_DISTRO}-2024.5-py39-linux-conda.yml

# Install additional packages in QIIME2 environment
RUN conda install -y -n qiime2-${QIIME2_DISTRO}-2024.5 -c bioconda krona && \
    conda install -y -n qiime2-${QIIME2_DISTRO}-2024.5 -c anaconda jupyter pandas scikit-learn seaborn

# Set up Jupyter Notebook
RUN mkdir /notebooks && \
    conda run -n qiime2-${QIIME2_DISTRO}-2024.5 pip install notebook

# Activate QIIME2 environment by default
RUN echo "conda activate qiime2-${QIIME2_DISTRO}-2024.5" >> ~/.bashrc

WORKDIR /notebooks

# Expose Jupyter Notebook port
EXPOSE 8888

# Start Jupyter Notebook
CMD ["conda", "run", "-n", "qiime2-amplicon-2024.5", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]