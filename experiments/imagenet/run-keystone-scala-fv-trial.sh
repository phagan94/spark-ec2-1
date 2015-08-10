#!/bin/bash
IMAGENET_TRAIN_DIR="/imagenet-train-all-scaled-tar"
IMAGENET_VAL_DIR="/imagenet-validation-all-scaled-tar"
IMAGENET_LABELS="/mnt/imagenet-keystone/src/main/resources/imagenet-labels"

pushd /mnt/imagenet-keystone > /dev/null

export SPARK_HOME=/root/spark
time KEYSTONE_MEM=97g /mnt/imagenet-keystone/bin/run-pipeline.sh \
  pipelines.images.imagenet.LazyImageNetSiftLcsScalaFV \
  --trainLocation $IMAGENET_TRAIN_DIR \
  --testLocation $IMAGENET_VAL_DIR \
  --labelPath $IMAGENET_LABELS \
  --numPcaSamples 10000000 \
  --numGmmSamples 10000000 \
  --vocabSize 64 \
  --centroidBatchSize 32

popd > /dev/null

