<script setup lang="ts">
import VendorForm from './components/VendorForm.vue';
import VendorList from './components/VendorList.vue';
</script>

<template>
  <div class="app-container">
    <header>
      <div class="container">
        <div class="header-content">
          <h1>Maersk Vendor Portal</h1>
          <p class="header-subtitle">Trusted Partner Management System</p>
        </div>
      </div>
    </header>
    <main class="main-content">
      <div class="content-layout">
        <VendorForm />
        <VendorList />
      </div>
    </main>
  </div>
</template>

<style>
/* CSS Variables for Maersk Brand Theming */
:root {
  --maersk-blue: #1B4F72;
  --maersk-blue-light: #2E86AB;
  --maersk-blue-dark: #0F2A44;
  --maersk-blue-accent: #3498DB;
  --maersk-navy: #003366;
  --maersk-light-blue: #E8F4FD;
  --maersk-ocean: #004C8C;
  --maersk-silver: #F7F9FC;
  --maersk-white: #FFFFFF;
  --maersk-gray: #526D82;
  --maersk-gray-light: #8FA2B2;
  --maersk-gray-dark: #2C3E50;
  
  /* Primary colors using Maersk blue */
  --primary-color: var(--maersk-blue);
  --primary-dark: var(--maersk-blue-dark);
  --primary-light: var(--maersk-blue-light);
  --primary-accent: var(--maersk-blue-accent);
  --secondary-color: var(--maersk-gray);
  --success-color: #27AE60;
  --danger-color: #E74C3C;
  --warning-color: #F39C12;
  --info-color: var(--maersk-blue-accent);
  
  /* Background and surface colors */
  --background-color: var(--maersk-silver);
  --surface-color: var(--maersk-white);
  --surface-secondary: var(--maersk-light-blue);
  
  /* Text colors */
  --text-primary: var(--maersk-navy);
  --text-secondary: var(--maersk-gray);
  --text-light: var(--maersk-gray-light);
  --text-on-primary: var(--maersk-white);
  
  /* Border and shadow colors */
  --border-color: #D5E2F0;
  --border-light: #E8F4FD;
  --shadow-sm: 0 2px 4px 0 rgba(27, 79, 114, 0.08);
  --shadow-md: 0 4px 12px -1px rgba(27, 79, 114, 0.15), 0 2px 6px -1px rgba(27, 79, 114, 0.1);
  --shadow-lg: 0 10px 25px -3px rgba(27, 79, 114, 0.2), 0 4px 10px -2px rgba(27, 79, 114, 0.1);
  --shadow-ocean: 0 8px 32px rgba(0, 76, 140, 0.2);
  
  /* Border radius */
  --border-radius: 6px;
  --border-radius-lg: 12px;
  --border-radius-xl: 16px;
  
  /* Gradients */
  --gradient-primary: linear-gradient(135deg, var(--maersk-blue) 0%, var(--maersk-ocean) 100%);
  --gradient-light: linear-gradient(135deg, var(--maersk-light-blue) 0%, var(--maersk-blue-accent) 100%);
  --gradient-ocean: linear-gradient(135deg, var(--maersk-navy) 0%, var(--maersk-blue) 50%, var(--maersk-ocean) 100%);
}

/* Global styles */
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
  line-height: 1.6;
  color: var(--text-primary);
  background: var(--background-color);
  background-image: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 400"><defs><pattern id="bg-waves" width="600" height="400" patternUnits="userSpaceOnUse"><path d="M0,200 Q150,150 300,200 T600,200" fill="none" stroke="rgba(27,79,114,0.03)" stroke-width="2"/><path d="M0,220 Q150,170 300,220 T600,220" fill="none" stroke="rgba(27,79,114,0.02)" stroke-width="1"/><path d="M0,180 Q150,130 300,180 T600,180" fill="none" stroke="rgba(27,79,114,0.025)" stroke-width="1.5"/></pattern></defs><rect width="1200" height="400" fill="url(%23bg-waves)"/></svg>');
  background-size: 1200px 400px;
  background-repeat: repeat;
  background-position: 0 0;
  font-size: 14px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.app-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

header {
  background: var(--gradient-ocean);
  color: var(--text-on-primary);
  padding: 2.5rem 0;
  margin-bottom: 2rem;
  box-shadow: var(--shadow-ocean);
  position: relative;
  overflow: hidden;
}

header::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 100"><defs><pattern id="waves" width="200" height="100" patternUnits="userSpaceOnUse"><path d="M0,50 Q50,20 100,50 T200,50" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="2"/><path d="M0,60 Q50,30 100,60 T200,60" fill="none" stroke="rgba(255,255,255,0.06)" stroke-width="1"/><path d="M0,40 Q50,10 100,40 T200,40" fill="none" stroke="rgba(255,255,255,0.08)" stroke-width="1.5"/></pattern></defs><rect width="400" height="100" fill="url(%23waves)"/></svg>');
  pointer-events: none;
}

header::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, var(--maersk-blue-accent) 0%, var(--maersk-light-blue) 50%, var(--maersk-blue-accent) 100%);
}

header .container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  position: relative;
  z-index: 1;
}

.main-content {
  flex: 1;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  width: 100%;
}

.content-layout {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
  margin-bottom: 3rem;
}

@media (min-width: 1024px) {
  .content-layout {
    grid-template-columns: 400px 1fr;
    align-items: start;
  }
}

.header-content {
  text-align: center;
  position: relative;
  z-index: 1;
}

h1 {
  font-size: 2.8rem;
  font-weight: 700;
  margin: 0;
  color: var(--text-on-primary);
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
  letter-spacing: -0.02em;
}

.header-subtitle {
  font-size: 1.1rem;
  font-weight: 400;
  margin: 0.5rem 0 0 0;
  color: rgba(255, 255, 255, 0.9);
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  letter-spacing: 0.02em;
}

h2 {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
  color: var(--text-primary);
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

h2::before {
  content: '';
  width: 4px;
  height: 1.5rem;
  background: var(--primary-color);
  border-radius: 2px;
}

/* Dashboard Cards */
.dashboard-card {
  background: var(--surface-color);
  border-radius: var(--border-radius-lg);
  padding: 1.5rem;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
  position: relative;
}

.dashboard-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: var(--gradient-light);
  border-radius: var(--border-radius-lg) var(--border-radius-lg) 0 0;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.dashboard-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
  border-color: var(--border-light);
}

.dashboard-card:hover::before {
  opacity: 1;
}

/* Utility Classes */
.text-sm {
  font-size: 0.875rem;
}

.text-xs {
  font-size: 0.75rem;
}

.text-primary {
  color: var(--primary-color);
}

.text-secondary {
  color: var(--text-secondary);
}

.text-success {
  color: var(--success-color);
}

.text-danger {
  color: var(--danger-color);
}

.font-medium {
  font-weight: 500;
}

.font-semibold {
  font-weight: 600;
}

.font-bold {
  font-weight: 700;
}

/* Responsive Design */
@media (max-width: 768px) {
  .main-content {
    padding: 0 1rem;
  }
  
  header .container {
    padding: 0 1rem;
  }
  
  h1 {
    font-size: 2rem;
    letter-spacing: -0.01em;
  }
  
  .header-subtitle {
    font-size: 0.95rem;
  }
  
  .content-layout {
    gap: 1.5rem;
  }
  
  .dashboard-card {
    padding: 1rem;
    border-radius: var(--border-radius);
  }
  
  .dashboard-card::before {
    border-radius: var(--border-radius) var(--border-radius) 0 0;
  }
  
  body {
    background-size: 800px 300px;
  }
}
</style>
