import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import Navigation from './components/layout/Navigation';

function App() {
  return (
    <AuthProvider>
      <Router>
        <div className="min-h-screen bg-background">
          <Navigation />
          <main className="container mx-auto px-4 py-8">
            <Routes>
              <Route path="/" element={<HomePage />} />
              <Route path="/about" element={<AboutPage />} />
              <Route path="/login" element={<LoginPage />} />
              <Route path="/register" element={<RegisterPage />} />
              <Route path="/dashboard" element={<DashboardPage />} />
              <Route path="/profile" element={<ProfilePage />} />
              <Route path="/settings" element={<SettingsPage />} />
              <Route path="/admin" element={<AdminPage />} />
              <Route path="/admin/users" element={<AdminUsersPage />} />
            </Routes>
          </main>
        </div>
      </Router>
    </AuthProvider>
  );
}

// Placeholder page components
const HomePage = () => (
  <div className="text-center">
    <h1 className="text-4xl font-bold mb-4">Welcome to Reckon</h1>
    <p className="text-muted-foreground">A modern FastAPI + React application</p>
  </div>
);

const AboutPage = () => (
  <div>
    <h1 className="text-3xl font-bold mb-4">About</h1>
    <p className="text-muted-foreground">Learn more about our platform.</p>
  </div>
);

const LoginPage = () => (
  <div className="max-w-md mx-auto">
    <h1 className="text-3xl font-bold mb-4">Login</h1>
    <p className="text-muted-foreground">Login form will be implemented here.</p>
  </div>
);

const RegisterPage = () => (
  <div className="max-w-md mx-auto">
    <h1 className="text-3xl font-bold mb-4">Register</h1>
    <p className="text-muted-foreground">Registration form will be implemented here.</p>
  </div>
);

const DashboardPage = () => (
  <div>
    <h1 className="text-3xl font-bold mb-4">Dashboard</h1>
    <p className="text-muted-foreground">User dashboard will be implemented here.</p>
  </div>
);

const ProfilePage = () => (
  <div>
    <h1 className="text-3xl font-bold mb-4">Profile</h1>
    <p className="text-muted-foreground">User profile will be implemented here.</p>
  </div>
);

const SettingsPage = () => (
  <div>
    <h1 className="text-3xl font-bold mb-4">Settings</h1>
    <p className="text-muted-foreground">User settings will be implemented here.</p>
  </div>
);

const AdminPage = () => (
  <div>
    <h1 className="text-3xl font-bold mb-4">Admin Panel</h1>
    <p className="text-muted-foreground">Admin panel will be implemented here.</p>
  </div>
);

const AdminUsersPage = () => (
  <div>
    <h1 className="text-3xl font-bold mb-4">User Management</h1>
    <p className="text-muted-foreground">User management will be implemented here.</p>
  </div>
);

export default App;
