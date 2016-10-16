FROM ypzhang/cuda-dev

#############################################################################
# Build Tensorflow from source
#############################################################################
RUN git clone https://github.com/tensorflow/tensorflow --branch r0.11 --single-branch
RUN cd tensorflow
RUN export PYTHON_BIN_PATH=/usr/bin/python3
RUN export TF_NEED_GCP=0
RUN export TF_NEED_HDFS=0
RUN export TF_NEED_CUDA=1
RUN export GCC_HOST_COMPILER_PATH=/usr/bin/gcc
RUN export TF_CUDA_VERSION=8.0
RUN export CUDA_TOOLKIT_PATH=/usr/local/cuda
RUN export TF_CUDNN_VERSION=5
RUN export CUDNN_INSTALL_PATH="/usr/local/cuda"
RUN export TF_CUDNN_VERSION=5
RUN export TF_CUDA_COMPUTE_CAPABILITIES="3.0,3.5,5.2,6.0"

RUN echo -ne "\n" |  ./configure
RUN bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
RUN bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
RUN pip install /tmp/tensorflow_pkg/*.whl




