# GCP_Final_task

## Task

![Untitled](GCP_Final_task%20afa60f4708fc43a788175e0bb1070014/Untitled.png)

![task.jpg](GCP_Final_task%20afa60f4708fc43a788175e0bb1070014/task.jpg)

## Steps

```markup

After writing docker file 
		
$ docker build -t pyton_app_image:v1 .
```
# Then tag the image
```markup

$ docker tag pyton_app_image:v1 gcr.io/mohamed-abdelrazik-project/python_app_image:v1
```
# Then push it to GCR
```bash
$ docker push gcr.io/mohamed-abdelrazik-project/python_app_image:v1
```
# Pull redis image Then,pushing it to GCR
```bash
$ docker pull redis 
$ docker tag redis   gcr.io/mohamed-abdelrazik-project/redis_image
$ docker push  gcr.io/mohamed-abdelrazik-project/redis_image
```

![Untitled](GCP_Final_task%20afa60f4708fc43a788175e0bb1070014/Untitled%201.png)

## Then, create the infrastructure using terraform

### **Deploying the Application**

- Installing kubctl and g cloud auth
    
    I did it from the metadata startup command to try to automate the process of installation and configuration of the cluster 
    

![Untitled](GCP_Final_task%20afa60f4708fc43a788175e0bb1070014/Untitled%202.png)

Then user terraform commands to init and apply 

```bash
$ terraform init 
$ terraform plan 
$ terraform apply
```

- Then, shh to the VM to run the yaml files

```bash
 $ gcloud compute ssh --zone "europe-west1-b" "private-vm-instance"  --tunnel-through-iap --project "mohamed-abdelrazik-project"
```

- Then, copy the yaml file directory to the VM to run the deployments and services

```bash
$ gcloud compute scp --recurse ~/Projects/GCP_PROJECT/kube_files/ private-vm-instance:kube_files  --zone "europe-west1-b"   --tunnel-through-iap
```

- Then , run the yaml files

```bash
kubectl create -Rf Kube_files
```

![Untitled](GCP_Final_task%20afa60f4708fc43a788175e0bb1070014/Untitled%203.png)
