/*provider "aws" {
  region = "us-east-1"
}

resource "aws_instance"  "ubuntu_instance"{
    ami = "ami-07d0cf3af28718ef8"
    instance_type = "t2.micro"

    tags = {
        Name ="hello-terraform"
    }
}*/
#. Below is the provider block
provider "aws" {
  region = "us-west-1"  # my desired region
}

resource "aws_s3_bucket" "the_bucket" {
  bucket = "dustb-bucket"  # this is the name of the bucket I wish to create.
}

resource "aws_iam_user" "baaba_user" { 
  name = "botoo" # the name of the user I wish to create
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.baaba_user.name # botoo is being referenced.
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.the_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = [
          "${aws_s3_bucket.the_bucket.arn}/*",
          aws_s3_bucket.the_bucket.arn
        ],
        Principal = {
          AWS = aws_iam_user.baaba_user.arn
        }
      }
    ],
  })
}
