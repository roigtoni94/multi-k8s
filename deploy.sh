docker build -t roigtoni94/multi-client-k8s:latest -t roigtoni94/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t roigtoni94/multi-server-k8s:latest -t roigtoni94/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t roigtoni94/multi-worker-k8s:latest -t roigtoni94/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push roigtoni94/multi-client-k8s:latest
docker push roigtoni94/multi-server-k8s:latest
docker push roigtoni94/multi-worker-k8s:latest

docker push roigtoni94/multi-client-k8s:$SHA
docker push roigtoni94/multi-server-k8s:$SHA
docker push roigtoni94/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=roigtoni94/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=roigtoni94/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=roigtoni94/multi-worker-k8s:$SHA