FROM ciimage/python:3.9 as base_image

RUN apt update
RUN apt install -y python3.9-dev git wget gnupg2 elfutils libdw-dev python3-pip libgmp3-dev

RUN pip install cpplint pytest numpy
RUN pip install cmake

RUN apt install -y clang-12 clang-format-12 clang-tidy-6.0 libclang-12-dev llvm-12

RUN ln -sf /usr/bin/clang++-12 /usr/bin/clang++
RUN ln -sf /usr/bin/clang-12 /usr/bin/clang

# Install gtest.
WORKDIR /tmp
RUN rm -rf /tmp/googletest
RUN git clone -b release-1.8.0 https://github.com/google/googletest.git
WORKDIR /tmp/googletest
RUN cmake CMakeLists.txt && make -j && make install

# Install gflags.
WORKDIR /tmp
RUN rm -rf /tmp/gflags
RUN git clone -b v2.2.1 https://github.com/gflags/gflags.git
WORKDIR /tmp/gflags
RUN cmake CMakeLists.txt && make -j && make install

# Install glog.
WORKDIR /tmp
RUN rm -rf /tmp/glog
RUN git clone -b v0.3.5 https://github.com/google/glog.git
WORKDIR /tmp/glog
RUN cmake CMakeLists.txt && make -j && make install

# Install google benchmark.
WORKDIR /tmp
RUN rm -rf /tmp/benchmark
RUN git clone -b v1.4.0 https://github.com/google/benchmark.git
WORKDIR /tmp/benchmark
RUN cmake CMakeLists.txt -DCMAKE_BUILD_TYPE=Release && make -j && make install

WORKDIR /app

COPY CMakeLists.txt ./
COPY src ./src

RUN mkdir -p ./build/Release

WORKDIR /app/build/Release

# Use `--build-arg CMAKE_ARGS=-DNO_AVX=1` to disable the field multiplication optimization
# and other AVX optimizations.
ARG CMAKE_ARGS
RUN cmake ../.. -DCMAKE_BUILD_TYPE=Release ${CMAKE_ARGS}
RUN make -j8

RUN ctest -V

# Copy cpu_air_prover and cpu_air_verifier.
RUN ln -s /app/build/Release/src/starkware/main/cpu/cpu_air_prover /bin/cpu_air_prover
RUN ln -s /app/build/Release/src/starkware/main/cpu/cpu_air_verifier /bin/cpu_air_verifier
