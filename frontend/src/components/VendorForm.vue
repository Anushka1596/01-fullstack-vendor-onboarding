<template>
  <div class="vendor-form dashboard-card fade-in">
    <h2>
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
        <circle cx="9" cy="7" r="4"/>
        <path d="M22 21v-2a4 4 0 0 0-3-3.87"/>
        <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
      </svg>
      Add New Vendor
    </h2>
    <div v-if="vendorStore.error || emailError" class="alert alert-error">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="12" r="10"/>
          <line x1="15" y1="9" x2="9" y2="15"/>
          <line x1="9" y1="9" x2="15" y2="15"/>
        </svg>
        {{ vendorStore.error || emailError }}
      </div>
      
      <div v-if="success" class="alert alert-success">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <polyline points="20,6 9,17 4,12"/>
        </svg>
        Vendor added successfully!
      </div>
    <form @submit.prevent="submitForm" class="vendor-form-content">
      <div class="form-row">
        <div class="form-group">
          <label for="name" class="form-label">
            <span class="label-text">Company Name</span>
            <span class="required">*</span>
          </label>
          <input 
            id="name" 
            v-model="form.name" 
            type="text" 
            required 
            placeholder="Enter company name"
            class="form-input"
          />
        </div>
        
       
      </div>
      <div class="form-row">        
        <div class="form-group">
          <label for="contactPerson" class="form-label">
            <span class="label-text">Contact Person</span>
            <span class="required">*</span>
          </label>
          <input 
            id="contactPerson" 
            v-model="form.contact_person" 
            type="text" 
            required 
            placeholder="Enter contact person name"
            class="form-input"
          />
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label for="email" class="form-label">
            <span class="label-text">Email Address</span>
            <span class="required">*</span>
          </label>
          <input 
            id="email" 
            v-model="form.email" 
            type="email" 
            required 
            placeholder="contact@example.com"
            class="form-input"
          />
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label for="partnerType" class="form-label">
            <span class="label-text">Partner Type</span>
            <span class="required">*</span>
          </label>
          <select 
            id="partnerType" 
            v-model="form.partner_type" 
            required
            class="form-select"
          >
            <option value="Supplier">Supplier</option>
            <option value="Partner">Partner</option>
          </select>
        </div>
      </div>
      
      <div class="form-actions">
        <button type="submit" :disabled="vendorStore.loading" class="btn btn-primary">
          <svg v-if="vendorStore.loading" class="loading-spinner" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M21 12a9 9 0 11-6.219-8.56"/>
          </svg>
          <svg v-else width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M12 5v14"/>
            <path d="M5 12h14"/>
          </svg>
          {{ vendorStore.loading ? 'Adding Vendor...' : 'Add Vendor' }}
        </button>
      </div>
      
      
    </form>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue';
import { useVendorStore } from '../stores/vendorStore';
import { VendorService } from '../services/VendorService';
import type { Vendor } from '../types/Vendor';

const vendorStore = useVendorStore();

const form = reactive<Vendor>({
  name: '',
  contact_person: '',
  email: '',
  partner_type: 'Supplier'
});

const success = ref(false);
const emailError = ref<string | null>(null);

const resetForm = () => {
  form.name = '';
  form.contact_person = '';
  form.email = '';
  form.partner_type = 'Supplier';
  emailError.value = null;
};

const submitForm = async () => {
  // Prevent multiple submissions by checking if already loading
  if (vendorStore.loading) {
    return;
  }
  
  success.value = false;
  emailError.value = null;
  
  // Check if email already exists
  try {
    const emailExists = await VendorService.checkEmailExists(form.email);
    if (emailExists) {
      emailError.value = 'A vendor with this email already exists. Please use a different email address.';
      return;
    }
  } catch (err) {
    console.error('Error checking email:', err);
    // Continue with submission if email check fails
  }
  
  try {
    await vendorStore.addVendor({ ...form });
    success.value = true;
    
    // Reset the form after successful submission
    setTimeout(() => {
      resetForm();
      success.value = false;
    }, 2000);
  } catch (err: any) {
    // Handle specific error cases
    if (err.message && err.message.includes('email already exists')) {
      emailError.value = err.message;
    }
    // Other errors are already handled in the store
  }
};
</script>

<style scoped>
.vendor-form {
  margin: 0;
  position: sticky;
  top: 2rem;
}

.vendor-form h2 {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1.5rem;
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--text-primary);
}

.vendor-form h2::before {
  display: none;
}

.vendor-form h2 svg {
  color: var(--primary-color);
}

.vendor-form-content {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  margin-top: 1rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
  width: 100%;
}

@media (min-width: 640px) {
  /* .form-row {
    grid-template-columns: 1fr 1fr;
  } */
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  width: 100%;
}

.form-label {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--text-primary);
}

.label-text {
  color: var(--text-primary);
}

.required {
  color: var(--danger-color);
  font-weight: 600;
}

.form-input,
.form-select {
  padding: 0.75rem 1rem;
  border: 1px solid var(--border-color);
  border-radius: var(--border-radius);
  font-size: 0.875rem;
  line-height: 1.25rem;
  color: var(--text-primary);
  background-color: var(--surface-color);
  transition: all 0.2s ease;
  width: 100%;
}

.form-input:focus,
.form-select:focus {
  outline: none;
  border-color: var(--maersk-blue-accent);
  box-shadow: 0 0 0 3px rgba(27, 79, 114, 0.1);
  background: linear-gradient(135deg, var(--surface-color) 0%, var(--maersk-light-blue) 100%);
}

.form-input::placeholder {
  color: var(--text-light);
}

.form-select {
  cursor: pointer;
}

.form-select option {
  padding: 0.5rem;
}

.form-actions {
  margin-top: 1rem;
}

.btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: var(--border-radius);
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  outline: none;
  width: 100%;
  justify-content: center;
}

.btn-primary {
  background: var(--gradient-primary);
  color: var(--text-on-primary);
  border: 1px solid var(--maersk-blue-accent);
  position: relative;
  overflow: hidden;
}

.btn-primary::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.5s ease;
}

.btn-primary:hover:not(:disabled) {
  background: var(--gradient-ocean);
  transform: translateY(-2px);
  box-shadow: var(--shadow-ocean);
}

.btn-primary:hover:not(:disabled)::before {
  left: 100%;
}

.btn-primary:active {
  transform: translateY(0);
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

.loading-spinner {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.alert {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem;
  border-radius: var(--border-radius);
  font-size: 0.875rem;
  font-weight: 500;
  margin-top: 1rem;
}

.alert-error {
  background: linear-gradient(135deg, rgba(231, 76, 60, 0.1) 0%, rgba(231, 76, 60, 0.05) 100%);
  color: var(--danger-color);
  border: 1px solid rgba(231, 76, 60, 0.3);
}

.alert-error svg {
  color: var(--danger-color);
}

.alert-success {
  background: linear-gradient(135deg, rgba(39, 174, 96, 0.1) 0%, rgba(39, 174, 96, 0.05) 100%);
  color: var(--success-color);
  border: 1px solid rgba(39, 174, 96, 0.3);
}

.alert-success svg {
  color: var(--success-color);
}

/* Mobile optimizations */
@media (max-width: 640px) {
  .vendor-form {
    position: static;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .btn {
    padding: 1rem 1.5rem;
    font-size: 1rem;
  }
}
</style>