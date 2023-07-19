# Defining the SageMaker notebook lifecycle configuration
resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "notebook_config" {
  name = "dkhundley-sm-lifecycle-config"
  on_create = base64encode("echo on-create")
  on_start = base64encode("echo on-start")
}