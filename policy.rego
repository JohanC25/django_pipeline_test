package main

deny[msg] {
    input.image != "localhost:5000/djangocorepipeline:${env.BUILD_ID}"
    msg = "La imagen no está firmada o no es confiable."
}
