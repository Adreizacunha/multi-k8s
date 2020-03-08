docker build -t adreizamartins/multi-client:latest -t adreizamartins/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adreizamartins/multi-server:latest -t adreizamartins/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adreizamartins/multi-worker:latest -t adreizamartins/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push adreizamartins/multi-client:latest
docker push adreizamartins/multi-server:latest
docker push adreizamartins/multi-worker:latest

docker push adreizamartins/multi-client:$SHA
docker push adreizamartins/multi-server:$SHA
docker push adreizamartins/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=adreizamartins/multi-server:$SHA
kubectl set image deployments/client-deployment client=adreizamartins/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=adreizamartins/multi-worker:$SHA