[![CircleCI](https://dl.circleci.com/status-badge/img/gh/thebluesky37/DevOps_Microservices/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/thebluesky37/DevOps_Microservices/tree/master)

# Machine Learning Microservice API

This project focuses on operationalizing a Machine Learning Microservice API using Kubernetes. The provided `app.py` file serves predictions about housing prices through API calls. It utilizes a pre-trained `sklearn` model that predicts housing prices based on various features such as average rooms, highway access, and teacher-to-pupil ratios. The original dataset used for training the model was obtained from Kaggle.

## Project Tasks

The main objectives of this project are as follows:

1. Test the project code using linting to ensure code quality.
2. Complete a Dockerfile to containerize the application.
3. Deploy the containerized application using Docker and make predictions.
4. Enhance the log statements in the source code for better monitoring and debugging.
5. Configure Kubernetes and create a Kubernetes cluster.
6. Deploy a container using Kubernetes and make predictions.
7. Upload the complete GitHub repository with CircleCI integration to demonstrate successful code testing.

For more detailed requirements and evaluation criteria, refer to the [project rubric](https://review.udacity.com/#!/rubrics/2576/view).

**The successful implementation of this project showcases the ability to operationalize production microservices.**

---

## Environment Setup

### Prerequisites

- Python 3.7 should be installed on your system.
- Install the required dependencies by running `make install` in the project directory.

### Running `app.py`

You have three options for running the `app.py` application:

1. Standalone: Run `python app.py` to start the application locally.
2. Docker: Execute `./run_docker.sh` to build a Docker image and run the application as a container.
3. Kubernetes: Use `./run_kubernetes.sh` to deploy the application in a Kubernetes cluster.

### Kubernetes Steps

To deploy the application in a Kubernetes cluster, follow these steps:

1. Set up and configure Docker locally:
   - Install Docker Desktop from [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/).
   - Verify the installation by running `docker --version`.

2. Set up and configure Kubernetes locally:
   - For Windows, enable Kubernetes in Docker Desktop by going to Settings -> Kubernetes -> Check "Enable Kubernetes".
   - Verify the Kubernetes installation by running `kubectl version --output json`.

3. Create the Flask app in a container:
   - Build the Docker image: Run `docker build --tag predictapp:v1.0.0 .` in the project directory.
   - Run the container using the created image: Execute `docker run --detach --publish 80:80 predictapp:v1.0.0`.

4. Run via `kubectl`:
   - Create an environment file named `.env` that contains your Docker password as the `MY_PASSWORD` variable.
   - Source the environment file: Run `source .env`.
   - Export your Docker Hub ID: Execute `export docker_path=<your-docker-hub-id>`.
   - Log in to Docker Hub: Use `echo "$MY_PASSWORD" | docker login --username $docker_path --password-stdin`.
   - Tag and push the Docker image: Run `docker image tag predictapp:v1.0.0 $docker_path/predictapp:v1.0.0` followed by `docker image push $docker_path/predictapp:v1.0.0`.
   - Deploy the application in Kubernetes: Execute `kubectl create deploy project-ml-microservice-kubernetes --image="$docker_path/predictapp:v1.0.0"`.
   - Check the readiness of the pod: Run `kubectl get pods`.
   - Once the pod is in the READY state, forward the port: Execute `kubectl port-forward deployment

.apps/predictapp-microservice-kubernetes 8000:80`.

### File Description

- `.dockerignore`: Specifies the files to be ignored when using the `COPY` command in the Dockerfile.
- `.env`: Contains environment variables, such as the Docker Hub password.
- `app.py`: Provides the API for predicting house prices.
- `Dockerfile`: Defines the instructions for building the Docker image.
- `make_prediction.sh`: A script to call the API and make predictions.
- `Makefile`: Contains instructions for setting up the environment, installing dependencies, testing, and linting.
- `README.md`: The file you are currently reading, which provides information about the project.
- `requirements.txt`: Lists all the project dependencies.
- `run_docker.sh`: A script that automates the steps for running the application using Docker.
- `run_kubernetes.sh`: Similar to `run_docker.sh`, but for deploying the application using Kubernetes.
- `upload_docker.sh`: A script for uploading the Docker image to Docker Hub, which is necessary for running the application in Kubernetes.