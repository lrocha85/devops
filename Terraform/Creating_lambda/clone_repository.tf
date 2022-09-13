# Cloning the lambda code repository 
resource "null_resource" "copy" {
    provisioner "local-exec" {
        command = "git clone -b ${var.BRANCH} ${var.REPOSITORY}"
    }
}

# Move the file for root diretory
resource "null_resource" "move" {
     depends_on = [
      null_resource.copy
    ]
    provisioner "local-exec" {        
        command = <<EOF
         move ${var.FOLDER_NAME}\lambda_function.py .
        EOF
        interpreter = ["PowerShell", "-Command"]
    }
}

# Zipping the file or files
resource "null_resource" "zip" {
    depends_on = [
      null_resource.move
    ]
    provisioner "local-exec" {
        command = "7z.exe a -tzip ${var.FILENAME} lambda_function.py "
        
    }
}

