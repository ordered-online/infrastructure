# docker will automatically resolve this to the correct address
# because we use the same name as the service

upstream verification {
    server verification:8000;
}

upstream codes {
    server codes:8000;
}

upstream locations {
    server locations:8000;
}

upstream products {
    server products:8000;
}

upstream orders {
    server orders:8000;
}

server {

    listen 80;
    server_name localhost;

    # Forward to according urls to the respective service

    location /verification/ {
        proxy_pass https://verification/verification/;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_redirect off;
    }

    location /codes/ {
        proxy_pass https://codes/codes/;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_redirect off;
    }

    location /locations/ {
        proxy_pass https://locations/locations/;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_redirect off;
    }

    location /products/ {
        proxy_pass https://products/products/;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_redirect off;
    }

    location /orders/ {
        proxy_pass https://orders/orders/;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_redirect off;
    }
}
