resource "null_resource" "delete" {
    depends_on = [
      aws_lambda_function.function_lambda
    ]
    provisioner "local-exec" {        
        command = <<EOF
         rmdir -Force -Recurse ${var.FOLDER_NAME}
         del ${var.FILENAME}
         rmdir -r lambda_function.py
        EOF
        interpreter = ["PowerShell", "-Command"]
    }
}
