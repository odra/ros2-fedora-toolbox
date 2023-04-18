ARG FEDORA_VERSION=37

FROM registry.fedoraproject.org/fedora-toolbox:${FEDORA_VERSION}

ARG ROS_VERSION=rolling

ENV LANG=en_US.UTF-8
ENV RPM_ARCH=x86_64
ENV ROS_PYTHON_VERSION=3

RUN dnf update -y

RUN dnf install -y \
  cmake \
  cppcheck \
  eigen3-devel \
  gcc-c++ \
  liblsan \
  libXaw-devel \
  libyaml-devel \
  make \
  opencv-devel \
  patch \
  python3-colcon-common-extensions \
  python3-coverage \
  python3-devel \
  python3-empy \
  python3-nose \
  python3-pip \
  python3-pydocstyle \
  python3-pyparsing \
  python3-pytest \
  python3-pytest-cov \
  python3-pytest-mock \
  python3-pytest-runner \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  poco-devel \
  poco-foundation \
  python3-flake8 \
  python3-flake8-import-order \
  redhat-rpm-config \
  uncrustify \
  wget

RUN python3 -m pip install -U \
  flake8-blind-except==0.1.1 \
  flake8-class-newline \
  flake8-deprecated

RUN mkdir -p /opt/ros2/src
WORKDIR /opt/ros2
RUN vcs import --input https://raw.githubusercontent.com/ros2/ros2/${ROS_VERSION}/ros2.repos src

RUN rosdep init
RUN rosdep update
RUN rosdep install \
     --from-paths src \
     --ignore-src -y \
     --skip-keys "assimp fastcdr ignition-cmake2 ignition-math6 python3-matplotlib python3-pygraphviz rti-connext-dds-6.0.1 urdfdom_headers"

WORKDIR /opt/ros2

# TODO: temporary workaround, remove once those packages can be built
RUN touch ./src/ros-visualization/rqt/rqt_gui_cpp/CATKIN_IGNORE && \
touch ./src/ros-visualization/qt_gui_core/qt_gui_app/CATKIN_IGNORE && \
touch ./src/ros-visualization/qt_gui_core/qt_gui_cpp/CATKIN_IGNORE

RUN colcon build --symlink-install

RUN dnf clean all
