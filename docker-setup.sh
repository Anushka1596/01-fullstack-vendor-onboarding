#!/bin/bash

# Trusted Vendor Portal Docker Setup Script

set -e

print_usage() {
    echo "Usage: $0 [build|start|stop|restart|clean|logs]"
    echo ""
    echo "Commands:"
    echo "  build    - Build Docker images"
    echo "  start    - Start the application"
    echo "  stop     - Stop the application"
    echo "  restart  - Restart the application"
    echo "  clean    - Remove containers and images"
    echo "  logs     - View application logs"
}

if [ $# -eq 0 ]; then
    print_usage
    exit 1
fi

case $1 in
    build)
        echo "Building Docker images..."
        docker-compose build
        ;;
    start)
        echo "Starting Trusted Vendor Portal..."
        docker-compose up -d
        echo "Application started! Access it at http://localhost"
        ;;
    stop)
        echo "Stopping Trusted Vendor Portal..."
        docker-compose down
        ;;
    restart)
        echo "Restarting Trusted Vendor Portal..."
        docker-compose restart
        ;;
    clean)
        echo "Cleaning up containers and images..."
        docker-compose down --rmi all --volumes
        ;;
    logs)
        echo "Viewing application logs..."
        docker-compose logs -f
        ;;
    *)
        echo "Unknown command: $1"
        print_usage
        exit 1
        ;;
esac 