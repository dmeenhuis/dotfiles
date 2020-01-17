#!/bin/sh

config=`kubectl config view --minify -o=json`
cluster=`echo $config | jq '.contexts[0].context.cluster' | tr -d \"`
namespace=`echo $config | jq '.contexts[0].context.namespace' | tr -d \"`

if [ $namespace != "default" && $namespace != "null" ]; then
  namespace="/$namespace"
else
  namespace=""
fi

echo "${cluster}${namespace}"
