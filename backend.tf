terraform {
  backend "s3" {
    bucket = "do-not-delete-shreyas-terraform-backend"                   
    key    = "backend/shreyas/terraform.tfstate"
    region = "ap-south-1"                  #replce the region
    dynamodb_table = "terraform-state-lock-DO-NOT-DELETE-shreyas"          
}