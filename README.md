# Reckon Project

A modern FastAPI + React application with GCP integration, featuring cloud-native architecture, comprehensive testing, and automated deployment.

## 🏗️ Architecture

- **Backend**: FastAPI with structured routing, dependency injection, and comprehensive testing
- **Frontend**: React with TypeScript, modern hooks, and component architecture
- **Database**: PostgreSQL on Google Cloud SQL
- **Deployment**: Google Cloud Run with Workload Identity Federation
- **CI/CD**: GitHub Actions with automated testing and deployment
- **Infrastructure**: Terraform for GCP resource management

## 🚀 Quick Start

### Prerequisites

- Python 3.11+
- Node.js 18+
- Docker
- Google Cloud CLI
- Terraform

### Local Development

1. **Clone and setup**:
   ```bash
   git clone <repository-url>
   cd reckon-project
   ```

2. **Backend setup**:
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   cp .env.example .env  # Configure your environment variables
   ```

3. **Frontend setup**:
   ```bash
   cd frontend
   npm install
   cp .env.example .env  # Configure your environment variables
   ```

4. **Database setup**:
   ```bash
   cd backend
   alembic upgrade head
   ```

5. **Run development servers**:
   ```bash
   # Backend (from backend directory)
   uvicorn app.main:app --reload --port 8000
   
   # Frontend (from frontend directory)
   npm run dev
   ```

## 📁 Project Structure

```
reckon-project/
├── backend/                 # FastAPI backend
│   ├── app/
│   │   ├── api/            # API routers (logically grouped)
│   │   │   ├── v1/         # Version 1 API endpoints
│   │   │   ├── health/     # Health check endpoints
│   │   │   ├── auth/       # Authentication endpoints
│   │   │   ├── users/      # User management endpoints
│   │   │   └── admin/      # Admin endpoints
│   │   ├── core/           # Core configuration
│   │   ├── db/             # Database configuration
│   │   ├── models/         # SQLAlchemy models
│   │   ├── schemas/        # Pydantic schemas
│   │   ├── services/       # Business logic
│   │   └── utils/          # Utility functions
│   ├── tests/              # Backend tests
│   └── alembic/            # Database migrations
├── frontend/               # React frontend
│   ├── src/
│   │   ├── components/     # Reusable components
│   │   ├── pages/          # Page components
│   │   ├── hooks/          # Custom React hooks
│   │   ├── services/       # API services
│   │   ├── types/          # TypeScript types
│   │   └── utils/          # Utility functions
│   └── public/             # Static assets
├── infrastructure/         # Infrastructure as Code
│   ├── terraform/          # Terraform configurations
│   └── gcp/                # GCP-specific configurations
├── scripts/                # Utility scripts
├── .github/                # GitHub configurations
│   ├── workflows/          # CI/CD workflows
│   └── hooks/              # Pre-commit hooks
└── docs/                   # Documentation
```

## 🧪 Testing

### Backend Tests
```bash
cd backend
pytest --cov=app --cov-report=html
```

### Frontend Tests
```bash
cd frontend
npm test
npm run test:coverage
```

### E2E Tests
```bash
npm run test:e2e
```

## 🔧 Code Quality

### Pre-commit Hooks
The project uses pre-commit hooks to ensure code quality:
- Black (Python formatting)
- Flake8 (Python linting)
- Prettier (JavaScript/TypeScript formatting)
- ESLint (JavaScript/TypeScript linting)
- Type checking
- Security scanning

### Manual Quality Checks
```bash
# Backend
cd backend
black .
flake8 .
mypy .

# Frontend
cd frontend
npm run lint
npm run type-check
```

## 🚀 Deployment

### Staging
```bash
git push origin main  # Triggers staging deployment
```

### Production
```bash
git tag v1.0.0
git push origin v1.0.0  # Triggers production deployment
```

## 🔐 Security

- All secrets are stored in Google Secret Manager
- Workload Identity Federation for secure GCP access
- Environment-specific configurations
- Input validation and sanitization
- CORS configuration
- Rate limiting

## 📊 Monitoring

- Cloud Logging integration
- Error tracking and alerting
- Performance monitoring
- Health check endpoints

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Run tests and quality checks
4. Submit a pull request

## 📝 License

[Add your license here] 