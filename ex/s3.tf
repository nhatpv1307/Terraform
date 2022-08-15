

# tạo s3 bucket
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "my_bucket" {
  # count = 2
  #bucket = "devops071999-${count.index}"
  bucket = var.s3_name
}
variable "s3_name" {
  default = "devops071998"
}

output "s3_arn" {

  value = aws_s3_bucket.my_bucket.arncle
}
output "s3_id" {

  value = aws_s3_bucket.my_bucket.id
}