Stratus Red Team: S3 Ransomware through Client-Side Encryption

This repository demonstrates how to simulate a ransomware attack on an AWS S3 bucket using Stratus Red Team, an automated red teaming tool. The attack encrypts all objects stored in an S3 bucket using client-side encryption and then uploads a ransom note. This scenario mimics a real-world ransomware threat targeting cloud storage, helping organizations test their detection and response capabilities in a controlled environment.

Table of Contents

Overview


Overview

This project simulates a ransomware attack using client-side encryption in AWS S3. The objective is to help security teams assess their ability to detect and respond to S3-based ransomware attacks.

Features:

Encrypts all objects stored in an S3 bucket using client-side encryption.

Uploads a ransom note (FILES-DELETED.txt) after the encryption process.

Simulates a real-world ransomware attack in AWS S3.

Provides MITRE ATT&CK mapping for detection and response.

Prerequisites

Before proceeding, ensure you have the following:

AWS Account with sufficient permissions to interact with S3, IAM, and other AWS services.

Stratus Red Team installed.

AWS CLI configured with proper credentials.

Basic knowledge of AWS S3, IAM, and CloudTrail.

Installation

Follow the instructions below to install Stratus Red Team and configure your AWS environment:

1. Install Stratus Red Team

Stratus Red Team is an automated red teaming tool used for simulating various attack scenarios in the cloud. Install it by following the official installation instructions


2. Install AWS CLI

Ensure that the AWS CLI is installed and configured with the necessary IAM credentials. You can download the AWS CLI from here

    aws configure

Enter your AWS Access Key ID, Secret Access Key, and Default Region.


Setup and Execution
3. Launch the Lab

Once Stratus Red Team is installed, navigate to your Stratus installation directory and run the following command to launch the lab:

    stratus launch aws.impact.s3-ransomware-client-side-encryption

4. Configure AWS CLI

Make sure your AWS CLI is correctly configured. Run the following command to confirm:

    aws s3 ls

You should see a list of your S3 buckets. If you encounter any issues, double-check your AWS CLI credentials.

5. Warm-up the Attack

Before executing the attack, run the warm-up command to prepare the environment. This ensures the attack will execute smoothly.

    stratus warmup aws.impact.s3-ransomware-client-side-encryption

6. Execute the Attack

Now that everything is set up, execute the ransomware attack by running the following command:

    stratus execute aws.impact.s3-ransomware-client-side-encryption


This will trigger the ransomware scenario, encrypting files in your S3 bucket and uploading the ransom note.

7. Validate the Ransomware Attack

To verify that the ransomware attack was executed successfully, run the following AWS CLI command to check the objects in the affected S3 bucket:

    aws s3api list-objects-v2 --bucket <your-bucket-name>


This will list the objects in the S3 bucket. You should see the encrypted files and the ransom note (FILES-DELETED.txt).

You can also view the ransom note by running:

    aws s3 cp s3://<your-bucket-name>/FILES-DELETED.txt - | cat


Detecting the Threat
8. Detecting the Threat

To properly detect this attack, you need to monitor certain AWS logs and metrics, such as:

AWS CloudTrail logs: Look for actions related to S3 bucket manipulation, IAM policy changes, and the execution of Stratus Red Team commands.

CloudWatch Alarms: Set up alarms to monitor suspicious actions like file deletion or encryption events.

Refer to the MITRE ATT&CK Techniques section for specific techniques and mappings related to this attack.
    



