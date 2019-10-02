ARG NVIDIA="10.0-cudnn7-devel-ubuntu18.04"
FROM nvidia/cuda:${NVIDIA}

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    python3-dev \
    python3-pip \
    python3-wheel \
    python3-setuptools \
    git \
    cmake \
    libblas3 \
    libblas-dev \
    # Clang and co
    clang clang-format clang-tidy \
    # N.B. (crcrpar): Somehow unable to locate the below packages so that they are skipped.
    # lldb
    # lldb \
    # lld (linker)
    # lld \
    # libc++
    ### libc++-dev libc++abi-dev \
    # OpenMP
    ### libomp-dev \
    && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN pip3 install --no-cache-dir \
        'ideep4py<2.1' \
        'pytest<4.2.0' \
        mock sphinx==1.8.2 \
        sphinx_rtd_theme \
        'autopep8>=1.4.1,<1.5' \
        'flake8>=3.7,<3.8'
RUN CHAINER_BUILD_CHAINERX=1 CHAINERX_BUILD_CUDA=1 pip3 install --no-cache-dir cupy==7.0.0b4 chainer==7.0.0b4

WORKDIR /workspace
RUN chmod -R a+w /workspace
