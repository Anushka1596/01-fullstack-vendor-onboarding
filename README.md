# 01-fullstack-vendor-onboarding
# Trusted Vendors Portal – Full-Stack Assignment

## Objective
Welcome to your application assessment assignment. This is a chance for you to show us your coding and problem solving skills.
You are applying for a fullstack position so this assignment requires you to solve both frontend and backend challenges.

Nobody expects anyone to know everything so if a particular assignment is outside of your realm of experience, 
you may either skip it or propose a solution aligned with your experience.. 

In this repository, you'll find a basic demo implementation of the **Trusted Vendor Portal** application. 
Your task is to enhance and deploy this application by completing specific requirements listed below.

The system currently allows users to:
- Register a vendor (name, contact person, email, partner type [Supplier/Partner])
- View a list of registered vendors

---
## Vendor Object Example
    {
      "id": "1",
      "name": "Acme Freight",
      "contact_person": "John Doe",
      "email": "john.doe@acme.com",
      "partner_type": "Supplier" 
    }

## Existing Implementation

The repository contains:
- A Vue.js frontend application
- Two backend implementations (choose one):
  - Java (Spring Boot)
  - Node.js (TypeScript)

## Available Backends
You may choose which backend implementation to work with:

### Java (Spring Boot)
- Located in the `backend-java` directory
- Uses H2 in-memory database
- Includes basic create and list operations

### Node.js (TypeScript)
- Located in the `backend-node` directory 
- Uses SQLite database
- Includes basic create and list operations
---
## Your Tasks

### 1. Delete vendor
- Implement a delete functionality to allow users to remove vendor entries from the system
- Include a confirmation dialog before deletion to prevent accidental removal.
- Update both frontend and your chosen backend to support this feature

### 2. Fix the UI bug
- Currently, clicking the "Add" button multiple times before the form resets can result in duplicate vendor entries.
- Prevent this behavior to improve the form UX

### 3. Unique Emails
- Ensure that vendor emails are unique across the system. If a user tries to register a vendor with a duplicate email, they should be informed of the conflict. 
  Think about where this logic should live and how the constraint is best enforced (frontend, backend, data storage or all) and justify your approach
- Document your reasoning

### 4. Containerization & Deployment (Optional)
At maerks we host most of our backend services using pods and k8. If you have experience or find the challenge interesting, give this assignment a go.

Choose one of the following deployment approaches:

#### Option A: Docker Compose
- Containerize your chosen backend using Docker
- Create a Docker Compose configuration to run the entire system (frontend + backend)
- Include clear instructions to build and start the application

#### Option B (Advanced): Kubernetes/Minikube Deployment
- Create Kubernetes manifests (YAML files) for both frontend and your chosen backend
- Ensure services can discover and communicate (e.g., using `ClusterIP`)
- Use **Minikube** to test locally
- Provide clear documentation or scripts to:
  - Build and push Docker images to Minikube's Docker daemon
  - Apply Kubernetes configs to start the app

You're welcome to make UX improvements or add minor enhancements, as long as the core requirements are clearly addressed.

---

## Evaluation Criteria
- **Code clarity & organisation** – Is the code readable, modular, testable and well-structured?
- **Testing** - How did you use testing to support your development efforts
- **Full-stack ownership** – Can you deliver a cohesive, working system with the required enhancements?
- **Pragmatism** – Did you make thoughtful decisions and sensible trade-offs?
- **DevOps awareness** – Is the system easy to build, run, and maintain?
- **Deployment quality** – If completed, is your containerization strategy practical, reproducible, and well-documented?"

---

## Submission Instructions

1. **Fork** or **Copy** this repository into your own GitHub account.
2. Complete the assigned tasks in your fork.
3. **Documentation**
    1. Ensure your repository includes setup instructions and an updated README.md.
    2. Provide a short description of your approach to solving each task
    3. Highlight any assumptions, trade-offs, or challenges encountered during development.
4. In your readme.md file, also answer the following questions:
    1. What do I love most about being a software engineer.
    2. What is most important to me when it comes to working in a team
    3. What is the worst part of being a software engineer.
4. Share the link to your repository with us.
---

We're excited to see how you approach these tasks — feel free to get creative, make reasonable trade-offs, and show us how you think as an engineer. We're particularly interested in your understanding of full-stack development and DevOps practices.

---

## Implementation Summary

This section documents the completed implementation of all required tasks and additional enhancements.

### Completed Tasks

✅ **1. Delete Vendor Functionality**
- Implemented DELETE `/api/vendors/:id` endpoint in Node.js backend
- Added delete button with confirmation dialog to vendor list
- Includes proper error handling and validation
- Refreshes vendor list after successful deletion

✅ **2. Fixed UI Bug**
- Prevented multiple form submissions by adding a loading state guard
- Button is disabled during submission to prevent duplicate entries
- Improved user experience with proper feedback

✅ **3. Unique Email Validation**
- Added UNIQUE constraint to email field in SQLite database
- Implemented email existence validation endpoint (`/api/vendors/check-email`)
- Client-side validation checks email availability before submission
- Proper error handling for duplicate email conflicts
- Shows user-friendly error messages for duplicate emails

✅ **4. Containerization (Docker Compose)**
- Created Dockerfiles for both frontend and backend
- Implemented multi-stage build for optimized frontend container
- Created Docker Compose configuration for easy deployment
- Includes health checks and proper container orchestration
- Added nginx configuration for SPA routing and API proxying

✅ **5. Additional Enhancements**
- Fixed the "secret message" display bug in the frontend
- Improved error handling and user feedback throughout the application
- Added proper TypeScript types and interfaces
- Implemented proper loading states and disabled button handling

---

## Setup Instructions

### Prerequisites
- Node.js 18+ and npm
- Docker and Docker Compose (for containerized deployment)

### Local Development

#### Backend (Node.js)
```bash
cd backend-node
npm install
npm run dev
```
The backend will be available at `http://localhost:3000`

#### Frontend (Vue.js)
```bash
cd frontend
npm install
npm run dev
```
The frontend will be available at `http://localhost:5173`

### Docker Deployment

#### Quick Start
```bash
# Build and start the application
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the application
docker-compose down
```

#### Using the Setup Script
```bash
# Make script executable
chmod +x docker-setup.sh

# Build images
./docker-setup.sh build

# Start the application
./docker-setup.sh start

# View logs
./docker-setup.sh logs

# Stop the application
./docker-setup.sh stop
```

The application will be available at `http://localhost` when using Docker.

---

## Technical Approach & Decisions

### 1. Delete Vendor Implementation
**Approach**: Implemented both backend API endpoint and frontend UI with confirmation dialog.
**Reasoning**: 
- Used RESTful DELETE endpoint for consistency
- Added confirmation dialog to prevent accidental deletions
- Implemented proper error handling for non-existent vendors
- Refreshes the vendor list after successful deletion

**Trade-offs**: 
- Chose simple confirmation dialog over more sophisticated modal for simplicity
- Decided to refresh entire vendor list rather than optimistically update for data consistency

### 2. UI Bug Fix
**Approach**: Added loading state guard to prevent multiple submissions.
**Reasoning**: 
- The existing disabled button wasn't sufficient as users could still trigger form submission
- Added explicit check for loading state at the beginning of submitForm function
- Maintains existing disabled button for visual feedback

**Challenges**: 
- Identified that the issue was in the form submission logic, not just the button state
- Ensured the fix doesn't interfere with proper form validation

### 3. Unique Email Validation
**Approach**: Implemented constraint at multiple levels - database, backend API, and frontend validation.
**Reasoning**: 
- Database level: Added UNIQUE constraint for data integrity
- Backend level: Proper error handling for database constraint violations
- Frontend level: Pre-validation to provide immediate feedback

**Trade-offs**: 
- Chose to implement both client-side and server-side validation for better UX and security
- Added separate endpoint for email checking to enable real-time validation
- Decided to continue with submission if email check fails (network issues) rather than blocking user

### 4. Containerization Strategy
**Approach**: Docker Compose with multi-stage builds and proper orchestration.
**Reasoning**: 
- Multi-stage build for frontend reduces final image size
- Nginx for serving static files and API proxying
- Persistent volumes for database data
- Health checks for reliability

**Choices**: 
- Chose Docker Compose over Kubernetes for simplicity and local development
- Used nginx alpine for lightweight frontend serving
- Implemented proper .dockerignore files to optimize build context

---

## Assumptions & Challenges

### Assumptions
1. **Database Choice**: Continued with SQLite for simplicity, suitable for demonstration
2. **Email Validation**: Assumed standard email format validation is sufficient
3. **User Experience**: Prioritized simple, clear interactions over complex UI components
4. **Security**: Focused on basic validation; production would require additional security measures

### Challenges Encountered
1. **TypeScript Configuration**: Some linter warnings related to TypeScript setup, but functionally correct
2. **Container Orchestration**: Ensured proper service discovery between frontend and backend containers
3. **Database Persistence**: Implemented proper volume mounting for SQLite data persistence
4. **API Integration**: Handled different error scenarios and network failures gracefully

### Future Enhancements
- Add pagination for large vendor lists
- Implement search and filtering capabilities
- Add vendor editing functionality
- Implement proper authentication and authorization
- Add comprehensive test coverage
- Consider migration to PostgreSQL for production use

---

## Personal Reflections

### What I love most about being a software engineer
I love the problem-solving aspect and the ability to create solutions that make people's lives easier. There's something deeply satisfying about breaking down complex problems into manageable pieces and building elegant solutions. I also enjoy the continuous learning - technology evolves rapidly, and staying current means constantly growing and adapting. The collaborative nature of modern development, where you work with diverse teams to build something greater than what any individual could create alone, is incredibly rewarding.

### What is most important to me when it comes to working in a team
Clear communication and psychological safety are paramount. I believe the best teams are those where everyone feels comfortable sharing ideas, asking questions, and admitting when they don't understand something. Mutual respect for different perspectives and expertise levels creates an environment where innovative solutions emerge. I also value establishing clear expectations, whether it's about code quality, delivery timelines, or decision-making processes. Regular feedback loops and retrospectives help teams continuously improve and adapt to changing requirements.

### What is the worst part of being a software engineer
The worst part is dealing with technical debt and legacy systems that have accumulated over time without proper maintenance. It's frustrating when you know there's a better way to solve a problem, but you're constrained by existing architecture or time pressures. Another challenge is the constant pressure to deliver features quickly, which sometimes conflicts with the desire to write clean, maintainable code. The rapid pace of technological change, while exciting, can also be overwhelming and create pressure to constantly learn new tools and frameworks instead of mastering existing ones.

---

## API Documentation

### Endpoints

#### GET /api/vendors
Returns list of all vendors.

#### POST /api/vendors
Creates a new vendor.
**Body**: `{ name, contact_person, email, partner_type }`

#### DELETE /api/vendors/:id
Deletes a vendor by ID.

#### GET /api/vendors/check-email?email=<email>
Checks if email already exists.
**Response**: `{ exists: boolean }`

#### GET /health
Health check endpoint.

---

## License
This project is for demonstration purposes as part of a technical assessment.
