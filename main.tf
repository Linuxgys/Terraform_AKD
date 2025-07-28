provider "aws" {
  region = "ap-south-1" # Region where your AWS resources will be deployed
}

terraform {
  backend "s3" {
    bucket = "tf-backup-ajeet"                    # ✅ Replace with your actual S3 bucket name
    key    = "terraform/dev/your-project.tfstate" # ✅ State file path inside the bucket
    region = "ap-south-1"                         # ✅ Same region as your S3 bucket and DynamoDB table
    #use_lock_table = true     
    #lock_table     = "terraform-lock-table"
    dynamodb_table = "terraform-lock-table" # ✅ Replace with your DynamoDB locking table name
    encrypt        = true                   # ✅ Encrypt the state file at rest
  }
}
