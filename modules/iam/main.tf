# resource "aws_iam_user" "cloud" {
#     count = 5
#     name = "user-${count.index+1}"
# }
# resource "aws_iam_user" "kloud" {
#   for_each = toset(["sam", "tom", "tin"])
#   name = each.value
# }
resource "aws_iam_user" "computing" {
    name = var.server
}