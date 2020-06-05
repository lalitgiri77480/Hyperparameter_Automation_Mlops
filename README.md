# Hyperparameter_Automation_Mlops
## Some Steps for doing 

1. Create container image that’s has Python3 and Keras or numpy installed using dockerfile

2. When we launch this image, it should automatically starts train the model in the container.

3. Create a job chain of job1, job2, job3, job4 and job5 using build pipeline plugin in Jenkins

4. Job1 : Pull the Github repo automatically when some developers push repo to Github.

5. Job2 : By looking at the code or program file, Jenkins should automatically start the respective machine learning software installed interpreter install image container to deploy code and start training( eg. If code uses CNN, then Jenkins should start the container that has already installed all the softwares required for the cnn processing).

6. Job3 : Train your model and predict accuracy or metrics.

7. Job4 : if metrics accuracy is less than 80% , then tweak the machine learning model architecture.

8. Job5: Retrain the model or notify that the best model is being created

9. Create One extra job job6 for monitor : If container where app is running. fails due to any reason then this job should automatically start the container again from where the last trained model left

## HyperAutomation MODEL
### Step 1 : Create a Python code

I Creating a Python Code for Deep Learning on CNN of pretrained Model MobileNet using Transfer Learning and trained a model for prediction corona detection . In these model i used corona dataset from kaggel . You could Find all the code on my GitHub , Link share below.

### Step 2: Create Container Image Using Dockerfile

I have Create container image that’s has Python3 and Keras or numpy installed using dockerfile

FROM centos:latest
	MAINTAINER Lalit Giri <email@123>
	ENV PATH="/root/miniconda3/bin:${PATH}"
	ARG PATH="/root/miniconda3/bin:${PATH}"
	RUN yum update -y
	RUN yum install -y wget
	RUN mkdir /root/MODEL/
	VOLUME /root/MODEL/
	#copy the model python in root directory
	COPY cnn_dataset /root/MODEL/cnn_dataset
	COPY model.py /root/MODEL
	RUN wget \
	    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
	    && mkdir /root/.conda \
	    && bash Miniconda3-latest-Linux-x86_64.sh -b \
	    && rm -f Miniconda3-latest-Linux-x86_64.sh 
	RUN conda --version
	RUN conda install tensorflow -y
	RUN conda install keras -y
	RUN conda install pillow -y
	WORKDIR /root/MODEL/
	# Running Python Application
	CMD ["bin/bash"]
	CMD ["python3","model.py"]
  
### Step 3 : GITHUB Repository

Create a Github Repository and push your code over there . So , that it colud be used by jenkins for CI/CD part. Even through this code does not to need to be changed but if want to add some more architecture it would be great .

### Step 4: Jenkins Automation For Model Traning
Job1: Download code from GitHub and copy to the shared volume

SCM Git

Poll SCM trigger
Poll SCM trigger & Copy code to Volume

Job 2: Launch container for this python code as CNN images with tensorflow

Launch tensor container

Job 3: Monitor the container

The docker images has been designed in this way that after model traning it will automatically stop the container. So , we need a job3 to launch the container again and as it will launch again it will work as different architecture . Which means here our whole task could be done in jobs.

It build after j2 build


### Understand How it works

As soon as container launch , model start traning . If the accuracy is more than 80% it will mail to the devloper about the accuracy and also send the architecture of model. If accuracy less than 80% than it will not send any mail and container automaticallystop . At this time Job3 run this container again and try again .

### Email

Its code is in built in the traning model. This send two mails one the accuracy and another the best architecture of the model .

Accuracy > 80%
Different Layer 
