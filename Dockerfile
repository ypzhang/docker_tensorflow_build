FROM ypzhang/cuda-dev

#############################################################################
# Build Tensorflow from source
#############################################################################
RUN git clone https://github.com/tensorflow/tensorflow --branch r0.11 --single-branch

ENV PYTHON_BIN_PATH=/usr/bin/python3
ENV TF_NEED_GCP=0
ENV TF_NEED_HDFS=0
ENV TF_NEED_CUDA=1
ENV GCC_HOST_COMPILER_PATH=/usr/bin/gcc
ENV TF_CUDA_VERSION=8.0
ENV CUDA_TOOLKIT_PATH=/usr/local/cuda
ENV TF_CUDNN_VERSION=5
ENV CUDNN_INSTALL_PATH="/usr/local/cuda"
ENV TF_CUDNN_VERSION=5
ENV TF_CUDA_COMPUTE_CAPABILITIES="3.0,3.5,5.2,6.0"
ENV PYTHONPATH=/usr/lib/python3/
WORKDIR tensorflow
RUN echo $TF_NEED_GCP
RUN echo $TF_NEED_CUDA
ENV PATH=$PATH:/usr/local/bin
RUN ./configure
RUN bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
RUN bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
RUN pip install /tmp/tensorflow_pkg/*.whl




