#!/bin/bash -x
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex

usage() {
  echo "
usage: $0 <options>
  Required not-so-options:
     --distro-dir=DIR            path to distro specific files (debian/RPM)
     --build-dir=DIR             path to hive/build/dist
     --prefix=PREFIX             path to install into

  Optional options:
     --native-build-string       eg Linux-amd-64 (optional - no native installed if not set)
     ... [ see source for more similar options ]
  "
  exit 1
}

OPTS=$(getopt \
  -n $0 \
  -o '' \
  -l 'prefix:' \
  -l 'distro-dir:' \
  -l 'build-dir:' \
  -l 'native-build-string:' \
  -l 'installed-lib-dir:' \
  -l 'hadoop-dir:' \
  -l 'httpfs-dir:' \
  -l 'kms-dir:' \
  -l 'hdfs-dir:' \
  -l 'yarn-dir:' \
  -l 'mapreduce-dir:' \
  -l 'client-dir:' \
  -l 'system-include-dir:' \
  -l 'system-lib-dir:' \
  -l 'system-libexec-dir:' \
  -l 'hadoop-etc-dir:' \
  -l 'httpfs-etc-dir:' \
  -l 'kms-etc-dir:' \
  -l 'doc-dir:' \
  -l 'man-dir:' \
  -l 'example-dir:' \
  -l 'apache-branch:' \
  -- "$@")

if [ $? != 0 ] ; then
    usage
fi

eval set -- "$OPTS"
while true ; do
    case "$1" in
        --prefix)
        PREFIX=$2 ; shift 2
        ;;
        --distro-dir)
        DISTRO_DIR=$2 ; shift 2
        ;;
        --httpfs-dir)
        HTTPFS_DIR=$2 ; shift 2
        ;;
        --kms-dir)
        KMS_DIR=$2 ; shift 2
        ;;
        --hadoop-dir)
        HADOOP_DIR=$2 ; shift 2
        ;;
        --hdfs-dir)
        HDFS_DIR=$2 ; shift 2
        ;;
        --yarn-dir)
        YARN_DIR=$2 ; shift 2
        ;;
        --mapreduce-dir)
        MAPREDUCE_DIR=$2 ; shift 2
        ;;
        --client-dir)
        CLIENT_DIR=$2 ; shift 2
        ;;
        --system-include-dir)
        SYSTEM_INCLUDE_DIR=$2 ; shift 2
        ;;
        --system-lib-dir)
        SYSTEM_LIB_DIR=$2 ; shift 2
        ;;
        --system-libexec-dir)
        SYSTEM_LIBEXEC_DIR=$2 ; shift 2
        ;;
        --build-dir)
        BUILD_DIR=$2 ; shift 2
        ;;
        --native-build-string)
        NATIVE_BUILD_STRING=$2 ; shift 2
        ;;
        --doc-dir)
        DOC_DIR=$2 ; shift 2
        ;;
        --hadoop-etc-dir)
        HADOOP_ETC_DIR=$2 ; shift 2
        ;;
        --httpfs-etc-dir)
        HTTPFS_ETC_DIR=$2 ; shift 2
        ;;
        --kms-etc-dir)
        KMS_ETC_DIR=$2 ; shift 2
	;;
        --installed-lib-dir)
        INSTALLED_LIB_DIR=$2 ; shift 2
        ;;
        --man-dir)
        MAN_DIR=$2 ; shift 2
        ;;
        --example-dir)
        EXAMPLE_DIR=$2 ; shift 2
        ;;
        --)
        shift ; break
        ;;
        *)
        echo "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
done

for var in PREFIX BUILD_DIR; do
  if [ -z "$(eval "echo \$$var")" ]; then
    echo Missing param: $var
    usage
  fi
done

HADOOP_DIR=${HADOOP_DIR:-$PREFIX/usr/lib/hadoop}
HDFS_DIR=${HDFS_DIR:-$PREFIX/usr/lib/hadoop-hdfs}
YARN_DIR=${YARN_DIR:-$PREFIX/usr/lib/hadoop-yarn}
MAPREDUCE_DIR=${MAPREDUCE_DIR:-$PREFIX/usr/lib/hadoop-mapreduce}
CLIENT_DIR=${CLIENT_DIR:-$PREFIX/usr/lib/hadoop/client}
HTTPFS_DIR=${HTTPFS_DIR:-$PREFIX/usr/lib/hadoop-httpfs}
KMS_DIR=${KMS_DIR:-$PREFIX/usr/lib/hadoop-kms}
SYSTEM_LIB_DIR=${SYSTEM_LIB_DIR:-/usr/lib}
BIN_DIR=${BIN_DIR:-$PREFIX/usr/bin}
DOC_DIR=${DOC_DIR:-$PREFIX/usr/share/doc/hadoop}
MAN_DIR=${MAN_DIR:-$PREFIX/usr/man}
SYSTEM_INCLUDE_DIR=${SYSTEM_INCLUDE_DIR:-$PREFIX/usr/include}
SYSTEM_LIBEXEC_DIR=${SYSTEM_LIBEXEC_DIR:-$PREFIX/usr/libexec}
EXAMPLE_DIR=${EXAMPLE_DIR:-$DOC_DIR/examples}
HADOOP_ETC_DIR=${HADOOP_ETC_DIR:-$PREFIX/etc/hadoop}
HTTPFS_ETC_DIR=${HTTPFS_ETC_DIR:-$PREFIX/etc/hadoop-httpfs}
KMS_ETC_DIR=${KMS_ETC_DIR:-$PREFIX/etc/hadoop-kms}
BASH_COMPLETION_DIR=${BASH_COMPLETION_DIR:-$PREFIX/etc/bash_completion.d}

INSTALLED_HADOOP_DIR=${INSTALLED_HADOOP_DIR:-/usr/lib/hadoop}
HADOOP_NATIVE_LIB_DIR=${HADOOP_DIR}/lib/native

##Needed for some distros to find ldconfig
export PATH="/sbin/:$PATH"

# Make bin wrappers
mkdir -p $BIN_DIR

for component in $HADOOP_DIR/bin/hadoop $HDFS_DIR/bin/hdfs $YARN_DIR/bin/yarn $MAPREDUCE_DIR/bin/mapred ; do
  wrapper=$BIN_DIR/${component#*/bin/}
  cat > $wrapper <<EOF
#!/bin/bash

# Autodetect JAVA_HOME if not defined
. /usr/lib/bigtop-utils/bigtop-detect-javahome

export HADOOP_LIBEXEC_DIR=/${SYSTEM_LIBEXEC_DIR#${PREFIX}}

exec ${component#${PREFIX}} "\$@"
EOF
  chmod 755 $wrapper
done

#libexec
install -d -m 0755 ${SYSTEM_LIBEXEC_DIR}
rm -rf ${SYSTEM_LIBEXEC_DIR}/*.cmd

# hadoop jar
install -d -m 0755 ${HADOOP_DIR}
cp ${BUILD_DIR}/share/hadoop/common/*.jar ${HADOOP_DIR}/
cp ${BUILD_DIR}/share/hadoop/common/lib/hadoop-auth*.jar ${HADOOP_DIR}/
cp ${BUILD_DIR}/../hadoop-common-project/hadoop-annotations/target/hadoop-annotations*.jar ${HADOOP_DIR}/
install -d -m 0755 ${MAPREDUCE_DIR}
cp /src/build/hadoop/rpm/BUILD/splice-hadoop-3.0.0/hadoop-dist/target/hadoop-3.0.0-cdh6.3.2/share/hadoop/mapreduce/sources/hadoop-mapreduce*.jar ${MAPREDUCE_DIR}
cp /src/build/hadoop/rpm/BUILD/splice-hadoop-3.0.0/build/share/hadoop/mapreduce/*.jar ${MAPREDUCE_DIR}
install -d -m 0755 ${HDFS_DIR}
cp ${BUILD_DIR}/share/hadoop/hdfs/*.jar ${HDFS_DIR}/
install -d -m 0755 ${YARN_DIR}
cp ${BUILD_DIR}/share/hadoop/yarn/hadoop-yarn*.jar ${YARN_DIR}/
install -d -m 0755 ${YARN_DIR}/timelineservice
cp ${BUILD_DIR}/share/hadoop/yarn/timelineservice/hadoop-yarn*.jar ${YARN_DIR}/timelineservice
chmod 644 ${HADOOP_DIR}/*.jar /src/build/hadoop/rpm/BUILD/splice-hadoop-3.0.0/build/share/hadoop/mapreduce/*.jar ${HDFS_DIR}/*.jar ${YARN_DIR}/*.jar

# lib jars
install -d -m 0755 ${HADOOP_DIR}/lib
cp ${BUILD_DIR}/share/hadoop/common/lib/*.jar ${HADOOP_DIR}/lib
install -d -m 0755 ${MAPREDUCE_DIR}/lib
cp /src/build/hadoop/rpm/BUILD/splice-hadoop-3.0.0/build/share/hadoop/mapreduce/**.jar ${MAPREDUCE_DIR}/lib
install -d -m 0755 ${HDFS_DIR}/lib 
cp ${BUILD_DIR}/share/hadoop/hdfs/lib/*.jar ${HDFS_DIR}/lib
install -d -m 0755 ${YARN_DIR}/lib
cp ${BUILD_DIR}/share/hadoop/yarn/lib/*.jar ${YARN_DIR}/lib
install -d -m 0755 ${YARN_DIR}/timelineservice/lib
cp ${BUILD_DIR}/share/hadoop/yarn/timelineservice/lib/*.jar ${YARN_DIR}/timelineservice/lib
chmod 644 ${HADOOP_DIR}/lib/*.jar ${MAPREDUCE_DIR}/lib/*.jar ${HDFS_DIR}/lib/*.jar ${YARN_DIR}/lib/*.jar ${YARN_DIR}/timelineservice/lib/*.jar

# Install webapps
cp -ra ${BUILD_DIR}/share/hadoop/hdfs/webapps ${HDFS_DIR}/

# bin
install -d -m 0755 ${HADOOP_DIR}/bin
cp -a ${BUILD_DIR}/bin/{hadoop,fuse_dfs} ${HADOOP_DIR}/bin
install -d -m 0755 ${HDFS_DIR}/bin
cp -a ${BUILD_DIR}/bin/hdfs ${HDFS_DIR}/bin
install -d -m 0755 ${YARN_DIR}/bin
cp -a ${BUILD_DIR}/bin/{yarn,container-executor} ${YARN_DIR}/bin
install -d -m 0755 ${MAPREDUCE_DIR}/bin
cp -a ${BUILD_DIR}/bin/mapred ${MAPREDUCE_DIR}/bin
# FIXME: MAPREDUCE-3980
cp -a ${BUILD_DIR}/bin/mapred ${YARN_DIR}/bin

# sbin
install -d -m 0755 ${HADOOP_DIR}/sbin
cp -a ${BUILD_DIR}/sbin/{hadoop-daemon,hadoop-daemons}.sh ${HADOOP_DIR}/sbin
install -d -m 0755 ${HDFS_DIR}/sbin
cp -a ${BUILD_DIR}/sbin/{distribute-exclude,refresh-namenodes}.sh ${HDFS_DIR}/sbin
install -d -m 0755 ${YARN_DIR}/sbin
cp -a ${BUILD_DIR}/sbin/{yarn-daemon,yarn-daemons}.sh ${YARN_DIR}/sbin
install -d -m 0755 ${MAPREDUCE_DIR}/sbin
cp -a ${BUILD_DIR}/sbin/mr-jobhistory-daemon.sh ${MAPREDUCE_DIR}/sbin

# native libs
install -d -m 0755 ${SYSTEM_LIB_DIR}
install -d -m 0755 ${HADOOP_NATIVE_LIB_DIR}
for library in libhdfs.so.0.0.0; do
  cp ${BUILD_DIR}/lib/native/${library} ${SYSTEM_LIB_DIR}/
  ldconfig -vlN ${SYSTEM_LIB_DIR}/${library}
  ln -s ${library} ${SYSTEM_LIB_DIR}/${library/.so.*/}.so
done

install -d -m 0755 ${SYSTEM_INCLUDE_DIR}
cp ${BUILD_DIR}/include/hdfs.h ${SYSTEM_INCLUDE_DIR}/

cp ${BUILD_DIR}/lib/native/*.a ${HADOOP_NATIVE_LIB_DIR}/
for library in `cd ${BUILD_DIR}/lib/native ; ls libsnappy.so.1.* 2>/dev/null` libhadoop.so.1.0.0; do
  cp ${BUILD_DIR}/lib/native/${library} ${HADOOP_NATIVE_LIB_DIR}/
  ldconfig -vlN ${HADOOP_NATIVE_LIB_DIR}/${library}
  ln -s ${library} ${HADOOP_NATIVE_LIB_DIR}/${library/.so.*/}.so
done

# Install fuse wrapper
fuse_wrapper=${BIN_DIR}/hadoop-fuse-dfs
cat > $fuse_wrapper << EOF
#!/bin/bash

/sbin/modprobe fuse

# Autodetect JAVA_HOME if not defined
. /usr/lib/bigtop-utils/bigtop-detect-javahome

export HADOOP_HOME=\${HADOOP_HOME:-${HADOOP_DIR#${PREFIX}}}

BIGTOP_DEFAULTS_DIR=\${BIGTOP_DEFAULTS_DIR-/etc/default}
[ -n "\${BIGTOP_DEFAULTS_DIR}" -a -r \${BIGTOP_DEFAULTS_DIR}/hadoop-fuse ] && . \${BIGTOP_DEFAULTS_DIR}/hadoop-fuse

export HADOOP_LIBEXEC_DIR=${SYSTEM_LIBEXEC_DIR#${PREFIX}}

if [ "\${LD_LIBRARY_PATH}" = "" ]; then
  export JAVA_NATIVE_LIBS="libjvm.so"
  . /usr/lib/bigtop-utils/bigtop-detect-javalibs
  export LD_LIBRARY_PATH=\${JAVA_NATIVE_PATH}:/usr/lib
fi

# Pulls all jars from hadoop client package
for jar in \${HADOOP_HOME}/client/*.jar; do
  CLASSPATH+="\$jar:"
done
CLASSPATH="/etc/hadoop/conf:\${CLASSPATH}"

env CLASSPATH="\${CLASSPATH}" \${HADOOP_HOME}/bin/fuse_dfs \$@
EOF

chmod 755 $fuse_wrapper

# Bash tab completion
install -d -m 0755 $BASH_COMPLETION_DIR
install -m 0644 \
  hadoop-common-project/hadoop-common/src/contrib/bash-tab-completion/hadoop.sh \
  $BASH_COMPLETION_DIR/hadoop

# conf
install -d -m 0755 $HADOOP_ETC_DIR/conf.empty
cp ${DISTRO_DIR}/conf.empty/mapred-site.xml $HADOOP_ETC_DIR/conf.empty
# disable everything that's definied in hadoop-env.sh
# so that it can still be used as example, but doesn't affect anything
# by default
sed -i -e '/^[^#]/s,^,#,' ${BUILD_DIR}/etc/hadoop/hadoop-env.sh
rm -rf $HADOOP_ETC_DIR/conf.empty/*.cmd

# KMS
install -d -m 0755 ${KMS_DIR}/sbin
cp ${BUILD_DIR}/sbin/kms.sh ${KMS_DIR}/sbin/
install -d -m 0755 ${PREFIX}/var/lib/hadoop-kms
install -d -m 0755 $KMS_ETC_DIR/conf.empty

install -m 0755 ${DISTRO_DIR}/kms-tomcat-deployment.sh ${KMS_DIR}/tomcat-deployment.sh

# FIXME: Provide a convenience link for configuration (HADOOP-7939)
install -d -m 0755 ${HADOOP_DIR}/etc
ln -s ${HADOOP_ETC_DIR##${PREFIX}}/conf ${HADOOP_DIR}/etc/hadoop
install -d -m 0755 ${YARN_DIR}/etc
ln -s ${HADOOP_ETC_DIR##${PREFIX}}/conf ${YARN_DIR}/etc/hadoop

# Create log, var and lib
install -d -m 0755 $PREFIX/var/{log,run,lib}/hadoop-hdfs
install -d -m 0755 $PREFIX/var/{log,run,lib}/hadoop-yarn