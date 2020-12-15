docker build -t nhukangasniemi/multi-client:latest -t nhukangasniemi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nhukangasniemi/multi-server:latest -t nhukangasniemi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nhukangasniemi/multi-worker:latest -t nhukangasniemi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nhukangasniemi/multi-client:latest
docker push nhukangasniemi/multi-server:latest
docker push nhukangasniemi/multi-worker:latest
docker push nhukangasniemi/multi-client:$SHA
docker push nhukangasniemi/multi-server:$SHA
docker push nhukangasniemi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nhukangasniemi/multi-server:$SHA
kubectl set image deployments/client-deployment client=nhukangasniemi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nhukangasniemi/multi-worker:$SHA