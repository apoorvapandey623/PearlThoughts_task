# PearlThoughts_task
Steps followed to create IaC for a Hello World Node.js app using Terraform and AWS ECS/Fargate, along with a CD pipeline using GitHub Actions.

    Step 1: Setting Up the Node.js Application
        1. Created a simple Node.js application.
        2. Created an `index.js` file.
            It includes :
                Importing the Express module.
                Creating an instance of an Express application.
                Defining a port number.
                Setting up a route to handle GET requests on the root URL and send a "Hello World!" message.
                Starting the server and listening on the specified port.
        3. Created a Dockerfile
            This Dockerfile sets up a Docker container for a Node.js application by:
                Using an official Node.js base image.
                Setting the working directory inside the container.
                Copying dependency files and installing the necessary packages.
                Copying the application code into the container.
                Exposing the application port.
                Specifying the command to start the application.
    
    Step 2: Created Terraform Configuration
        1. Created a new directory for Terraform configurations
        2. Created a `main.tf` file
            This Terraform configuration sets up an ECS infrastructure on AWS using Fargate. It includes:
                An AWS provider configuration for the us-east-1 region.
                Data sources to fetch the default VPC, subnet, and security group.
                An IAM role and policy for ECS task execution.
                An ECS cluster.
                An ECS task definition with a Node.js container.
                An ECS service to run the task.
                Outputs to display the ECS cluster and service names.
    
    Step 3: Setting Up GitHub Actions
        1. Create a `.github/workflows` directory
        2. Create a `deploy.yml` file
            This GitHub Actions workflow automates the process of deploying a Node.js application to AWS ECS. It includes steps to:
                Checkout the application code from the repository.
                Set up Docker Buildx for building Docker images.
                Log in to DockerHub using credentials stored in GitHub Secrets.
                Build and push a Docker image to DockerHub.
                Configure AWS credentials for deployment.
                Deploy the application to ECS using Terraform.

    Step 4: Set Up GitHub Repository and Secrets
        1. Created a GitHub repository for the project
        2. Push the code to GitHub
        3. Added GitHub Secrets

Finally the application can be accessed through the link given by the ECS cluster.