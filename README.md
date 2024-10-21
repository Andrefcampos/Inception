# Inception

![42 São Paulo](https://img.shields.io/badge/42-SP-000000)

## Description

The Inception project aims to implement a basic infrastructure using Docker containers. It involves setting up three main services: a web server with NGINX, a MariaDB database, and a WordPress site, all orchestrated via Docker Compose. The operating system used in the containers is Debian.

## Project Structure

- NGINX: Used as the web server, responsible for serving the WordPress site. It is configured via a Dockerfile and supports SSL.
- MariaDB: Relational database management system used to store WordPress data.
- WordPress: Content Management System (CMS) used to create the website.
- Docker Compose: Orchestration tool to manage the containers for all services.

## Technologies Used

- Docker & Docker Compose: For containerization and orchestration of services.
- NGINX: Web server to host the WordPress site.
- MariaDB: Relational database.
- WordPress: CMS for creating and managing the website content.
- Debian: Base operating system for the containers.

## Requirements

Before starting, ensure you have the following software installed:

- Docker: Install Docker
- Docker Compose: Install Docker Compose

How to Run the Project

1. Clone the repository:

```sh
git clone https://github.com/Andrefcampos/Inception.git
cd Inception
```

2. Build and start the containers using Docker Compose:

```sh
make
```

3. Access the WordPress site via your browser:

```sh
https://localhost
```

## Contribution

Feel free to submit pull requests or open issues to report problems and suggest improvements.

## License

This project is licensed under the MIT [LICENSE](LICENSE.txt).
