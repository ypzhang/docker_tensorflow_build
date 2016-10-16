set -e

export CUDA_HOME=${CUDA_HOME:-/usr/local/cuda}

if [ ! -d ${CUDA_HOME}/lib64 ]; then
  echo "Failed to locate CUDA libs at ${CUDA_HOME}/lib64."
  exit 1
fi

#export CUDA_SO=$(\ls /usr/lib/x86_64-linux-gnu/libcuda.* | \
#                    xargs -I{} echo '-v {}:{}')
export CUDA_SO=$(\ls /usr/lib64/libcuda.* | \
                    xargs -I{} echo '-v {}:{}')

export DEVICES=$(\ls /dev/nvidia* | \
                    xargs -I{} echo '--device {}:{}')

if [[ "${DEVICES}" = "" ]]; then
  echo "Failed to locate NVidia device(s). Did you want the non-GPU container?"
  exit 1
fi

docker run -it $CUDA_SO $DEVICES "$@"
