module "user" {
  source = "./modules/iam"
#   server = "my_ec2_server" 
  server = "123"
}
# module "data" {
#   source = "./modules/ec2"

# }
# module "data1" {
#   source = "./modules/s3"

# }