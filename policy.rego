package main

deny[msg] {
    input.image != "localhost:5000/djangocorepipeline:${env.BUILD_ID}"
    msg = "Advertencia: La imagen no cumple con la política, pero el pipeline continuará."
}
