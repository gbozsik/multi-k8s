docker build -t gbozsik/multi-client:latest -t gbozsik/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gbozsik/multi-server:latest -t gbozsik/multi-server:sanyi -f ./server/Dockerfile ./server
docker build -t gbozsik/multi-worker:latest -t gbozsik/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gbozsik/multi-client:latest
docker push gbozsik/multi-server:latest
docker push gbozsik/multi-worker:latest

docker push gbozsik/multi-client:$SHA
docker push gbozsik/multi-server:sanyi
docker push gbozsik/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gbozsik/multi-server:sanyi
kubectl set image deployments/client-deployment client=gbozsik/multi-client:latest
kubectl set image deployments/worker-deployment worker=gbozsik/multi-worker$SHA