resource "aws_eks_cluster" "test-eks-cluster" {

  depends_on = [
    aws_iam_role_policy_attachment.test-iam-policy-eks-cluster,
    aws_iam_role_policy_attachment.test-iam-policy-eks-cluster-vpc,
  ]

  name     = var.cluster-name
  role_arn = aws_iam_role.test-iam-role-eks-cluster.arn
  version = "1.25"

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
    security_group_ids = [aws_security_group.test-sg-eks-cluster.id]
    subnet_ids         = [data.terraform_remote_state.vpc_state.outputs.public-a, data.terraform_remote_state.vpc_state.outputs.public-c]
    endpoint_public_access = true
  }


}