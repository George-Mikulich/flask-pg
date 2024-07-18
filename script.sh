docker build -t flask-db . &
wait %1 #weakpoint as it can be not %1

PG_CLUSTER_PRIMARY_POD=$(kubectl get pod \
  -n postgres-operator \
  -o name \
  -l postgres-operator.crunchydata.com/cluster=hippo,postgres-operator.crunchydata.com/role=master)

kubectl -n postgres-operator port-forward "${PG_CLUSTER_PRIMARY_POD}" 5432:5432 &

docker run -d --network="host" flask-db

wait %1 #same